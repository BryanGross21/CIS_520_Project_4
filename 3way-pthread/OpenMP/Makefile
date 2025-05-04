CC = gcc

PROGRAM = opm
SRCS = OpenMP.c		# source file
FLAGS = -fopenmp -DAMOUNT_LINES=1000 -DLINE_LENGTH=2000
OBJS      = $(SRCS:.c=.o)		# object file

$(PROGRAM): $(SRCS) 
	$(CC) $(FLAGS) -o $(PROGRAM) $(SRCS)

clean:
	/bin/rm -f $(OBJS) $(PROGRAM)
