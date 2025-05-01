#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <string.h>
#include <errno.h>

#define AMOUNT_LINES 1000 //The amount of lines to read in
#define LINE_LENGTH 2000 //The length of each line 

char lines[AMOUNT_LINES][LINE_LENGTH]; //Represents the lines that we store
int results[AMOUNT_LINES]; //Represents our global results we find
int lineNum; //Represents the amount of lines we've read in
int numThreads; //The number of threads obtained by the max amount of cores


void* findMaxAscii()
{
	#pragma omp parallel for
		for(int i = 0; i < lineNum; i++)
		{
			int max = 0;
			for(char *c = lines[i]; *c; c++)
			{
				if(*c > max)
				{
					max = *c;
				}
			}
			results[i] = max;
		}
}

int main(int argc, char* argv[])
{
	FILE *fd = fopen("/homes/dan/625/wiki_dump.txt", "r");
	if(fd == NULL)
	{
		perror("Failed to open file.");
		return -1;//Represents that an error has occurred so cease all operations
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
		
	numThreads = omp_get_max_threads();
	
	printf("%d %d", numThreads, lineNum);
	
	findMaxAscii();
	
	for(int i = 0; i < lineNum; i++)
	{
		printf("%d: %d\n", (i + 1), results[i]); //print the results of the lines
	}		
	

	return 0;
}
