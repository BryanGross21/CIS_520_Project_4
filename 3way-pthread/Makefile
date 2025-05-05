CC = gcc

PROGRAM = pthread_prog
SRCS = pthread.c		# source file
FLAGS = -DAMOUNT_LINES=1100000 -DLINE_LENGTH=2000
LDFLAGS = -pthread
OBJS      = $(SRCS:.c=.o)		# object file

$(PROGRAM): $(SRCS) 
	$(CC) $(FLAGS) -o $(PROGRAM) $(SRCS) $(LDFLAGS)

clean:
	/bin/rm -f $(OBJS) $(PROGRAM)
