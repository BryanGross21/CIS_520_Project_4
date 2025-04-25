#ifndef MPI_H
#define MPI_H

#ifdef __cplusplus
	extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>


int numProcesses; //The number of processes
#define AMOUNT_LINES 1000 //The amount of lines to read in
#define LINE_LENGTH 2000 //The length of each line 
char lines[AMOUNT_LINES][LINE_LENGTH]; //Represents the lines that we store
int results[AMOUNT_LINES]; //Represents our global results we find
int localResults[AMOUNT_LINES];

//Takes in the id to determine which point to start reading lines and then determines which character has the highest ascii
//value
// \param the rank of the current process
void* findMaxAscii(int rank);

#ifdef __cplusplus
}
#endif
#endif
