cmake_minimum_required (VERSION 2.8)
project(hw4)

include_directories("${PROJECT_SOURCE_DIR}/include")

add_library(MPI ${PROJECT_SOURCE_DIR}/src/MPI.c)

add_executable(MPI_exe ${PROJECT_SOURCE_DIR}/src/MPI.c)
