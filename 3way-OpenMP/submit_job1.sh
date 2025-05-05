#!/bin/bash
#SBATCH --job-name=openmp_max_ascii   # Job name
#SBATCH --nodes=1                     # Run on a single node
#SBATCH --ntasks=1                    # Run as a single task
#SBATCH --cpus-per-task=1             # Placeholder - updated by sbatch command e.g., --cpus-per-task=$N
#SBATCH --constraint=moles            # Use Mole nodes
#SBATCH --output=omp_job_%j_c%c.out   # Standard out (%j=jobID, %c=cpus requested)
#SBATCH --error=omp_job_%j_c%c.err    # Standard error
#SBATCH --time=02:00:00               # Default runtime (Increase for 1 core, decrease for many)
#SBATCH --mem-per-cpu=4G              # Memory PER CPU core requested (adjust if needed, OpenMP uses shared memory but static arrays are big)

# --- Sanity check for argument ---
if [ -z "$1" ]; then
  echo "Error: Missing core/thread count argument."
  echo "Usage: sbatch $0 <num_threads>"
  exit 1
fi
REQUESTED_THREADS=$1
# We expect the job to be submitted with --cpus-per-task=$REQUESTED_THREADS
echo "Script argument (threads requested): $REQUESTED_THREADS"
echo "Slurm assigned CPUs per task: $SLURM_CPUS_PER_TASK" # Check what Slurm allocated

# --- Modules ---
module purge
module load foss/2022a  # Load GCC/libgomp

# --- Environment for OpenMP ---
# Slurm *should* automatically set OMP_NUM_THREADS based on --cpus-per-task
# We explicitly set it using the value Slurm allocated ($SLURM_CPUS_PER_TASK)
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Set OMP_NUM_THREADS=$OMP_NUM_THREADS (from SLURM_CPUS_PER_TASK)"

# --- Variables ---
EXECUTABLE="./opm"
# Input file path is hardcoded in the C code now
# INPUT_FILE="/homes/dan/625/wiki_dump.txt"
TIMING_LOG="timing_omp_${REQUESTED_THREADS}t_${SLURM_JOB_ID}.log"

# --- Execution ---
echo "Running $EXECUTABLE with $OMP_NUM_THREADS OpenMP threads."
echo "Timing output (stderr from /usr/bin/time) will be in $TIMING_LOG"

# Run the program, capture time/memory to stderr, redirect program stdout to null
# Redirect stderr (where /usr/bin/time writes) to the timing log file
# No mpirun/srun needed for OpenMP executable itself.
cd $SLURM_SUBMIT_DIR/3way-OpenMP || exit 1
/usr/bin/time -f "JOBID=${SLURM_JOB_ID} REQUESTED_THREADS=${REQUESTED_THREADS} OMP_NUM_THREADS=${OMP_NUM_THREADS} SLURM_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK} TIME=%e MEM_KB=%M" \
    $EXECUTABLE > /dev/null 2>> $TIMING_LOG

echo "Job finished." 
