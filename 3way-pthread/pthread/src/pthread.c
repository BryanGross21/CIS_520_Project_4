#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#include <errno.h>

#include "pthread.h" 

void* findMaxAscii(void* id)
{
	int start = ((int)id) * ((AMOUNT_LINES + NUM_THREADS) / NUM_THREADS);
	int end = start + ((AMOUNT_LINES + NUM_THREADS) / NUM_THREADS);
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
		results[i] = max;
	}
	pthread_exit(NULL);
}

int main()
{
   	int lineNum = 0; //Keeps track of how many lines we have read in
   	int i;
   	FILE *fd = fopen("/homes/dan/625/wiki_dump.txt", "r");
	if(fd == NULL)
	{
		perror("Failed to open file.");
		return -1; //-1 represents an error has occurred
	}

	lines = malloc(AMOUNT_LINES * sizeof(char*)); //Allocates an array to represent each line 
	results = malloc(AMOUNT_LINES * sizeof(int)); //An array to hold the answers
	if(lines == NULL || results == NULL)
	{
		perror("Failed allocation of either lines or results");
		fclose(fd);
		return -1; //Failed allocation of lines or results
	}

	size_t size = 0; //The size of the current line
	size_t dataToRead = 0; //The check for the line being read
	char* line = NULL; //The data of the current line being read
	

	while((dataToRead = getline(&line,&size,fd)) != -1 && lineNum < AMOUNT_LINES)
	{
		lines[lineNum] = malloc(size);
		if(lines[lineNum] == NULL)
		{
			perror("Failed alloction of lines member.");
			fclose(fd);
			return -1; //Faile allocation
		}
		snprintf(lines[lineNum], size, "%s", line); //Copies over the read line into lines at position lineNum
		lineNum++;
	}
	free(line); //Free up the read in line
	fclose(fd); //Close the file since we don't need it anymore	

	pthread_t threads[NUM_THREADS]; //The threads
	for(i = 0; i < NUM_THREADS; i++)
	{
		pthread_create(&threads[i], NULL, findMaxAscii, (void *)i);
	}	 

	for (i = 0; i < NUM_THREADS; i++) {
        	pthread_join(threads[i], NULL); //We join the threads together meaning that we join the data from data into a single collection
    	}

	for(i = 0; i < lineNum; i++)
	{
		printf("%d: %d\n", (i + 1), results[i]); //print the results of the lines
	}

	//Free the allocated memory to prevent a memory leak
	for(i = 0; i < lineNum; i++)
	{
		free(lines[i]);	
	}
	free(lines);
	free(results);

	return 0;
}






