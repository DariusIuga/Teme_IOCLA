CC = gcc
CFLAGS = -Wall -Wextra -g -O3
VALGRIND=valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes

build: main

main: main.o operations.o
	$(CC) -o main $^ 

main.o: main.c
	$(CC) $(CFLAGS) -c $^

operations.o: operations.c
	$(CC) $(CFLAGS) -c $^

run: build
	./main 
	
check:
	$(VALGRIND)	./main 
	
clean:
	rm -f *.o main
