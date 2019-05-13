###################### CIS*2750 iCalendar Test Harness ########################
# make run1  - run test harness one   (A1, createCalendar())                  #
# make run2  - run test harness two   (A2, writeCalendar())                   #
# make run3  - run test harness three (A2, validateCalendar())                #
# make run4  - run test harness four  (A2, validateCalendar() vulnerability)  #
#                                                                             #
# make run1v - valgrind run test harness one                                  #
# make run2v - valgrind run test harness two                                  #
# make run3v - valgrind run test harness three                                #
# make run4v - valgrind run test harness four                                 #
#                                                                             #
# make clean - clean up libraries, object files, and executables              #
###############################################################################

# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall -pedantic -std=c11 -g

# Linking flags
CLINK = -Llib -lfinal

###############################################################################

# Compile all four test harnesses without running
all: compileHarness1 compileHarness2 compileHarness3 compileHarness4

###############################################################################

# Compile Test Harness 1 (A1 createCalendar error code assertions)
compileHarness1: src/A1harness.c
	$(CC) $(CFLAGS) -c -fPIC src/A1harness.c -o bin/A1m1.o -Iinclude
	$(CC) $(CFLAGS) $(CLINK) -o bin/A1m1 bin/A1m1.o -Iinclude

# Compile Test Harness 2 (A2 writeCalendar calendar writing assertions)
compileHarness2: src/A2m1harness.c
	$(CC) $(CFLAGS) -c -fPIC src/A2m1harness.c -o bin/A2m1.o -Iinclude
	$(CC) $(CFLAGS) $(CLINK) -o bin/A2m1 bin/A2m1.o -Iinclude

# Compile Test Harness 3 (A2 validateCalendar error code assertions)
compileHarness3: src/A2m2harness.c
	$(CC) $(CFLAGS) -c -fPIC src/A2m2harness.c -o bin/A2m2.o -Iinclude
	$(CC) $(CFLAGS) $(CLINK) -o bin/A2m2 bin/A2m2.o -Iinclude

# Compile Test Harness 4 (A2 validateCalendar precedence vulnerability check)
compileHarness4: src/A2m2harnessv.c
	$(CC) $(CFLAGS) -c -fPIC src/A2m2harnessv.c -o bin/A2m2v.o -Iinclude
	$(CC) $(CFLAGS) $(CLINK) -o bin/A2m2v bin/A2m2v.o -Iinclude

###############################################################################

# Run Test Harness 1
run1: compileHarness1
	cd bin && LD_LIBRARY_PATH=./ ./A1m1 && cd ..

# Run Test Harness 2
run2: compileHarness2
	cd bin && LD_LIBRARY_PATH=./ ./A2m1 && cd ..
	rm -r bin/TEST/WRITECALEXPORTS/

# Run Test Harness 3
run3: compileHarness3
	cd bin && LD_LIBRARY_PATH=./ ./A2m2 && cd ..

# Run Test Harness 4
run4: compileHarness4
	cd bin && LD_LIBRARY_PATH=./ ./A2m2v && cd ..

###############################################################################

# Run Test Harness 1 (Valgrind)
run1v: compileHarness1
	cd bin && LD_LIBRARY_PATH=./ valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all ./A1m1 && cd ..

# Run Test Harness 2 (Valgrind)
run2v: compileHarness2
	cd bin && LD_LIBRARY_PATH=./ valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all ./A2m1 && cd ..
	rm -r bin/TEST/WRITECALEXPORTS/

# Run Test Harness 3 (Valgrind)
run3v: compileHarness3
	cd bin && LD_LIBRARY_PATH=./ valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all ./A2m2 && cd ..

# Run Test Harness 4 (Valgrind)
run4v: compileHarness4
	cd bin && LD_LIBRARY_PATH=./ valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all ./A2m2v && cd ..

###############################################################################

# Cleans up:
# - A1m1, A2m1, A2m2, A2m2v
#   executables in bin
clean:
	rm -rf bin/A1m1.o bin/A2m1.o bin/A2m2.o bin/A2m2v.o
	rm -rf bin/A1m1 bin/A2m1 bin/A2m2 bin/A2m2v

