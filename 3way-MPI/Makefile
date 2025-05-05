CC = mpicc

PROGRAM = mpi
SRCS = MPI.c		# source file
FLAGS = -DAMOUNT_LINES=1100000 -DLINE_LENGTH=2000
OBJS      = $(SRCS:.c=.o)		# object file

$(PROGRAM): $(OBJS) 
	$(CC) $(FLAGS) -o $(PROGRAM) $(OBJS)

clean:
	/bin/rm -f $(OBJS) $(PROGRAM)
