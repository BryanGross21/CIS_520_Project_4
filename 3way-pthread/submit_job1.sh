#!/bin/bash
#SBATCH --job-name=pthread_max_ascii   # Job name
#SBATCH --nodes=1                     # Run on a single node
#SBATCH --ntasks=1                    # Run as a single task
#SBATCH --cpus-per-task=1             # Placeholder - Actual cores controlled by $1 -> PTHREAD_NUM_THREADS
#SBATCH --constraint=moles            # Use Mole nodes
#SBATCH --output=pthread_job_%j_c%c.out # Standard out (%j=jobID, %c=cpus requested)
#SBATCH --error=pthread_job_%j_c%c.err  # Standard error
#SBATCH --time=02:00:00               # Default runtime (Increase for 1 core, decrease for many)
#SBATCH --mem-per-cpu=2G              # Memory per CPU core requested (adjust if needed)

# --- Sanity check for argument ---
if [ -z "$1" ]; then
  echo "Error: Missing core count argument."
  echo "Usage: sbatch $0 <num_cores>"
  exit 1
fi
REQUESTED_CORES=$1
# Update Slurm's CPU count for this job based on the argument passed to sbatch
# This informs the scheduler about the resource request.
# NOTE: Modifying #SBATCH directives via script variables doesn't work directly after submission.
# We request resources via sbatch command options or these headers,
# and then use the allocated resources inside the script.
# Setting --cpus-per-task here acts as a request/record.
# We'll use REQUESTED_CORES to set the PTHREAD_NUM_THREADS env var.
# Let's adjust the SBATCH directive based on the input argument if possible, or just use $1 directly.
# For simplicity and direct control via environment variable, we'll ensure SLURM allocates enough via sbatch command or header.
# The `#SBATCH --cpus-per-task=$1` line might work depending on Slurm version/config when submitting,
# but relying on the env var set below is more explicit for the application.
# Let's just ensure the sbatch command requests enough CPUs, e.g., `sbatch --cpus-per-task=$N submit_pthread.sh $N`
echo "Script argument (cores requested): $REQUESTED_CORES"
echo "Slurm assigned CPUs per task: $SLURM_CPUS_PER_TASK" # Check what Slurm allocated

# --- Modules ---
module purge
module load foss/2022a  # Load GCC etc.

# --- Environment for pthreads ---
# Use the script argument $1 to set the number of threads
export PTHREAD_NUM_THREADS=$REQUESTED_CORES
echo "Set PTHREAD_NUM_THREADS=$PTHREAD_NUM_THREADS"

# --- Variables ---
EXECUTABLE="./pthread_prog"
# Input file path is hardcoded in the C code now
# INPUT_FILE="/homes/dan/625/wiki_dump.txt"
TIMING_LOG="timing_pthread_${REQUESTED_CORES}c_${SLURM_JOB_ID}.log"

# --- Execution ---
echo "Running $EXECUTABLE with $PTHREAD_NUM_THREADS threads."
echo "Timing output (stderr from /usr/bin/time) will be in $TIMING_LOG"

# Run the program, capture time/memory to stderr, redirect program stdout to null
# Redirect stderr (where /usr/bin/time writes) to the timing log file
cd $SLURM_SUBMIT_DIR/3way-pthread || exit 1
/usr/bin/time -f "JOBID=${SLURM_JOB_ID} REQUESTED_CORES=${REQUESTED_CORES} ALLOCATED_CORES=${SLURM_CPUS_PER_TASK} PTHREADS=${PTHREAD_NUM_THREADS} TIME=%e MEM_KB=%M" \
    $EXECUTABLE > /dev/null 2>> $TIMING_LOG

echo "Job finished."  
