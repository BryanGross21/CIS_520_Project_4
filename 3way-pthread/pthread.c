#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#include <errno.h>

#include "pthread.h"  //Header file

char **lines = NULL;
int *results = NULL;
int lineNum = 0; // Global variable for actual lines read
int num_threads_runtime = 1;
void* findMaxAscii(void* id)
{
	int my_id = (intptr_t)id; // Or just (int)id if you prefer
	int lines_per_thread = lineNum / num_threads_runtime; // Use global lineNum now
	int remainder = lineNum % num_threads_runtime;
	int start = my_id * lines_per_thread + (my_id < remainder ? my_id : remainder);
	int end = start + lines_per_thread + (my_id < remainder ? 1 : 0);

	// Important checks for safety:
	if (start >= lineNum) { // If this thread has no work (e.g., more threads than lines)
     		pthread_exit(NULL); // Exit early
	}
	if (end > lineNum) { // Ensure 'end' doesn't go past the actual lines read
     		end = lineNum;
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
   	int i;

	char *thread_env_var = getenv("PTHREAD_NUM_THREADS"); // Read environment variable
	if (thread_env_var != NULL) {
    		num_threads_runtime = atoi(thread_env_var); // Convert string to integer
	}
	if (num_threads_runtime <= 0) {
    		fprintf(stderr, "Warning: PTHREAD_NUM_THREADS not set or invalid. Defaulting to 1 thread.\n");
    		num_threads_runtime = 1; // Ensure at least 1 thread
	}

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
	

	while((dataToRead = getline(&line,&size,fd)) != -1)
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

	pthread_t *threads = malloc(num_threads_runtime * sizeof(pthread_t));
	if (threads == NULL) {
    	perror("Failed to allocate thread array");
        	return -1;
	}
	
	for(i = 0; i < num_threads_runtime; i++)
	{
		pthread_create(&threads[i], NULL, findMaxAscii, (void *)i);
	}	 

	for (i = 0; i < num_threads_runtime; i++) {
        	pthread_join(threads[i], NULL); //We join the threads together meaning that we join the data from data into a single collection
    	}

	for(i = 0; i < lineNum; i++)
	{
		printf("%d: %d\n", (i), results[i]); //print the results of the lines
	}

	//Free the allocated memory to prevent a memory leak
	for(i = 0; i < lineNum; i++)
	{
		free(lines[i]);	
	}
	free(lines);
	free(results);
	free(threads);

	return 0;
}






