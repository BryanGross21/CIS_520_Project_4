cmake_minimum_required (VERSION 2.8)
project(hw4)

include_directories("${PROJECT_SOURCE_DIR}/include")

add_library(pthread ${PROJECT_SOURCE_DIR}/src/pthread.c)

add_executable(pthread_exe ${PROJECT_SOURCE_DIR}/src/pthread.c)
