#!/bin/bash
#SBATCH --job-name=pthreadMaxAscii_1  # Job name
#SBATCH --output=job_output.log     # Standard output and error log
#SBATCH --error=job_error.log       # Error log
#SBATCH --partition=batch.q            # Specify the partition
#SBATCH --nodes=1                   # Number of nodes to use (1 node for pthread)
#SBATCH --ntasks=1                  # Number of tasks (pthreads are used within a single task) 
#SBATCH --nodelist=mole[045,046]
#SBATCH --cpus-per-task=1           # Number of CPUs per task (this will be used by pthreads)
#SBATCH --time=05:0:00             # Maximum runtime (hh:mm:ss)


module purge

#export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK  # Set the number of threads for pthreads

make clean
make FIELDS="-DAMOUNT_LINES=4000 -DLINE_LENGTH=2000"

./opm 
