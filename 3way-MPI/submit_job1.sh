#!/bin/bash
#SBATCH --job-name=mpi_max_ascii      # Job name
#SBATCH --ntasks=1                    # Placeholder - updated by sbatch command e.g., --ntasks=$N
#SBATCH --cpus-per-task=1             # Each MPI task needs 1 CPU
#SBATCH --constraint=moles            # Use Mole nodes
#SBATCH --output=mpi_job_%j_n%n.out   # Standard out (%j=jobID, %n=tasks)
#SBATCH --error=mpi_job_%j_n%n.err    # Standard error
#SBATCH --time=01:00:00               # Default runtime (Increase for 1 core, decrease for many)
#SBATCH --mem-per-cpu=2G              # Memory PER TASK/CORE (adjust if needed)

# --- Sanity check for argument ---
if [ -z "$1" ]; then
  echo "Error: Missing core/process count argument."
  echo "Usage: sbatch $0 <num_processes>"
  exit 1
fi
REQUESTED_PROCS=$1
# We expect the job to be submitted with --ntasks=$REQUESTED_PROCS
echo "Script argument (processes requested): $REQUESTED_PROCS"
echo "Slurm assigned tasks: $SLURM_NTASKS" # Check what Slurm allocated

# --- Modules ---
module purge
module load foss/2022a OpenMPI/4.1.4-GCC-11.3.0 # Need BOTH

# --- Variables ---
EXECUTABLE="./mpi"
# Input file path is hardcoded in the C code now
# INPUT_FILE="/homes/dan/625/wiki_dump.txt"
TIMING_LOG="timing_mpi_${REQUESTED_PROCS}p_${SLURM_JOB_ID}.log"

# --- Execution ---
echo "Running $EXECUTABLE with $REQUESTED_PROCS MPI processes."
echo "Timing output (stderr from /usr/bin/time) will be in $TIMING_LOG"

# Run the program using mpirun, capture time/memory, redirect program stdout to null
# Redirect stderr (where /usr/bin/time writes) to the timing log file
# Use $SLURM_NTASKS provided by Slurm, which should match $REQUESTED_PROCS if submitted correctly
cd $SLURM_SUBMIT_DIR/3way-MPI || exit 1
/usr/bin/time -f "JOBID=${SLURM_JOB_ID} REQUESTED_PROCS=${REQUESTED_PROCS} SLURM_NTASKS=${SLURM_NTASKS} TIME=%e MEM_KB=%M" \
    mpirun -np $SLURM_NTASKS $EXECUTABLE > /dev/null 2>> $TIMING_LOG

# Alternative using srun (sometimes preferred by Slurm)
# Make sure to submit with correct --ntasks
# /usr/bin/time -f "JOBID=${SLURM_JOB_ID} REQUESTED_PROCS=${REQUESTED_PROCS} SLURM_NTASKS=${SLURM_NTASKS} TIME=%e MEM_KB=%M" \
#     srun --mpi=pmix_v3 $EXECUTABLE > /dev/null 2>> $TIMING_LOG

echo "Job finished."
