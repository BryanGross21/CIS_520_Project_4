#ifndef OPENMP_H
#define OPENMP_H

#ifdef __cplusplus
	extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>


char lines[AMOUNT_LINES][LINE_LENGTH]; //Represents the lines that we store
int results[AMOUNT_LINES]; //Represents our global results we find
int lineNum; //Represents the amount of lines we've read in
int numThreads; //The number of threads obtained by the max amount of cores


#ifndef NUM_THREADS
#define NUM_THREADS 8//The number of threads
#endif

#ifndef AMOUNT_LINES
#define AMOUNT_LINES 1000
#endif

#ifndef LINE_LENGTH
#define LINE_LENGTH 2000
#endif
//Takes in the id to determine which point to start reading lines and then determines which character has the highest ascii
//value
void* findMaxAscii();

#ifdef __cplusplus
}
#endif
#endif
