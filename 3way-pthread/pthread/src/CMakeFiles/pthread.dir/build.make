# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.23

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/software/software/CMake/3.23.1-GCCcore-11.3.0/bin/cmake

# The command to remove a file.
RM = /opt/software/software/CMake/3.23.1-GCCcore-11.3.0/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src

# Include any dependencies generated for this target.
include CMakeFiles/pthread.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/pthread.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/pthread.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/pthread.dir/flags.make

CMakeFiles/pthread.dir/pthread.c.o: CMakeFiles/pthread.dir/flags.make
CMakeFiles/pthread.dir/pthread.c.o: pthread.c
CMakeFiles/pthread.dir/pthread.c.o: CMakeFiles/pthread.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/pthread.dir/pthread.c.o"
	/opt/software/software/GCCcore/11.3.0/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/pthread.dir/pthread.c.o -MF CMakeFiles/pthread.dir/pthread.c.o.d -o CMakeFiles/pthread.dir/pthread.c.o -c /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src/pthread.c

CMakeFiles/pthread.dir/pthread.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/pthread.dir/pthread.c.i"
	/opt/software/software/GCCcore/11.3.0/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src/pthread.c > CMakeFiles/pthread.dir/pthread.c.i

CMakeFiles/pthread.dir/pthread.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/pthread.dir/pthread.c.s"
	/opt/software/software/GCCcore/11.3.0/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src/pthread.c -o CMakeFiles/pthread.dir/pthread.c.s

# Object files for target pthread
pthread_OBJECTS = \
"CMakeFiles/pthread.dir/pthread.c.o"

# External object files for target pthread
pthread_EXTERNAL_OBJECTS =

libpthread.a: CMakeFiles/pthread.dir/pthread.c.o
libpthread.a: CMakeFiles/pthread.dir/build.make
libpthread.a: CMakeFiles/pthread.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library libpthread.a"
	$(CMAKE_COMMAND) -P CMakeFiles/pthread.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pthread.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/pthread.dir/build: libpthread.a
.PHONY : CMakeFiles/pthread.dir/build

CMakeFiles/pthread.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/pthread.dir/cmake_clean.cmake
.PHONY : CMakeFiles/pthread.dir/clean

CMakeFiles/pthread.dir/depend:
	cd /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src /homes/bryangross21/CIS_520_Project_4/hw4/3way-pthread/pthread/src/CMakeFiles/pthread.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/pthread.dir/depend

