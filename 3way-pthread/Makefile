CC = gcc

PROGRAM = pthread
SRCS = pthread.c		# source file
FLAGS = -DAMOUNT_LINES=1000 -DLINE_LENGTH=2000 -DNUM_THREADS=8
LDFLAGS = -pthread
OBJS      = $(SRCS:.c=.o)		# object file

$(PROGRAM): $(SRCS) 
	$(CC) $(FLAGS) -o $(PROGRAM) $(SRCS) $(LDFLAGS)

clean:
	/bin/rm -f $(OBJS) $(PROGRAM)
