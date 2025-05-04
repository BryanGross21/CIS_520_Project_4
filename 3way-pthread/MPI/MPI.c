#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <string.h>
#include <errno.h>

#include "MPI.h"


void* findMaxAscii(int rank)
{
	int start = rank * ((AMOUNT_LINES + numProcesses) / numProcesses);
	int end = start + ((AMOUNT_LINES + numProcesses) / numProcesses);
	if(end > AMOUNT_LINES)
	{
		end = AMOUNT_LINES;
	}
	for(int i = start; i < end; i++)
	{
		int max = 0;
		for(char *c = lines[i]; *c; c++)
		{
			if(*c > max)
			{
				max = *c;
			}
		}
		localResults[i] = max;
	}
}

int main(int argc, char* argv[])
{
   	int i, rc;
	int numtasks, rank;
	MPI_Status Status;
	
	rc = MPI_Init(&argc,&argv);
	if (rc != MPI_SUCCESS) {
	  printf ("Error starting MPI program. Terminating.\n");
          MPI_Abort(MPI_COMM_WORLD, rc);
        }

        MPI_Comm_size(MPI_COMM_WORLD,&numtasks);
        MPI_Comm_rank(MPI_COMM_WORLD,&rank);
	
	numProcesses = numtasks;
	int lineNum = 0; //Tracks the amount of lines we have

	if(rank == 0)
	{
	   	FILE *fd = fopen("/homes/dan/625/wiki_dump.txt", "r");
		if(fd == NULL)
		{
			perror("Failed to open file.");
			MPI_Abort(MPI_COMM_WORLD, 1); //Represents that an error has occurred so cease all operations
		}
		size_t size = 0; //The size of the current line
		char* line = NULL; //The data of the current line being read
	

		while(getline(&line,&size,fd) != -1 && lineNum < AMOUNT_LINES)
		{
			snprintf(lines[lineNum], size, "%s", line); //Copies over the read line into lines at position lineNum
			lineNum++;
		}
		free(line); //Free up the read in line
        	fclose(fd); //Close the file since we don't need it anymore
	}
	
	MPI_Bcast(lines, AMOUNT_LINES * LINE_LENGTH, MPI_CHAR, 0, MPI_COMM_WORLD);

	findMaxAscii(rank);

	MPI_Reduce(localResults, results, AMOUNT_LINES, MPI_INT, MPI_MAX, 0, MPI_COMM_WORLD);
	
	if(rank == 0)
	{
		for(i = 0; i < lineNum; i++)
		{
			printf("%d: %d\n", (i + 1), results[i]); //print the results of the lines
		}		
	}
	
	MPI_Finalize();

	return 0;
}






