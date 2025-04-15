#ifndef PTHREAD_H
#define PTHREAD_H

#ifdef __cplusplus
	extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>


//pthread_mutex_t mutexsum;
char** lines; //Represents the lines that we store
int* results; //Represents our results we find


#define NUM_THREADS 8//The number of threads
#define AMOUNT_LINES 1000 //The amount of lines to read in
#define LINE_LENGTH 2000 //The length of each line

//Takes in the id to determine which point to start reading lines and then determines which character has the highest ascii
//value
// \param id the id of the thread being passed in
void* findMaxAscii(void* id);

#ifdef __cplusplus
}
#endif
#endif
