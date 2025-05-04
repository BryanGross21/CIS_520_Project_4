#!/bin/bash
#SBATCH --job-name=mpiMaxAscii_1  # Job name
#SBATCH --output=job_output.log     # Standard output and error log
#SBATCH --error=job_error.log       # Error log
#SBATCH --partition=batch.q            # Specify the partition
#SBATCH --mem=2G                   # The amount of allocated memory for a given job
#SBATCH --ntasks=1                  # Number of tasks
#SBATCH --nodelist=mole[045,046] 
#SBATCH --time=00:01:00             # Maximum runtime (hh:mm:ss)


module purge
module load openmpi

make clean
make FIELDS="-DAMOUNT_LINES=2000 -DLINE_LENGTH=4000"

mpirun -np 4 ./mpi
