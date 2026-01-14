# cmake/FindCorex.cmake  equal to `find_package(COREX QUIET)`

# Default Corex install prefix; user can override via -DCOREX_PATH=/opt/corex
set(COREX_PATH "" CACHE PATH "Path to Corex installation (optional)")

# If the user does not specify the Corex path, try to find it from environment variables or common locations
if(NOT COREX_PATH)
    if(DEFINED ENV{COREX_HOME})
        set(COREX_PATH $ENV{COREX_HOME})
    elseif(EXISTS /usr/local/corex)
        set(COREX_PATH /usr/local/corex)
    endif()
endif()

find_packages(CUDA)
message(STATUS "CUDA_FOUND=${CUDA_FOUND}")
message(STATUS "CUDA_PATH=${CUDA_PATH}")
message(STATUS "CUDA_INCLUDE_DIRS=${CUDA_INCLUDE_DIRS}")
message(STATUS "CUDA_CUDART_LIBRARY=${CUDA_CUDART_LIBRARY}")
message(STATUS "CUDA_NVCC_EXECUTABLE=${CUDA_NVCC_EXECUTABLE}")
message(STATUS "CUDA_VERSION=${CUDA_VERSION}")
message(STATUS "CUDA_LIBRARIES=${CUDA_LIBRARIES}")
message(STATUS "CUDA_COMPILE_OPTIONS=${CUDA_COMPILE_OPTIONS}")

if(COREX_FOUND)
    # 设置COREX版本
    execute_process(COMMAND ${COREX_NVCC_EXECUTABLE} --version
        OUTPUT_VARIABLE COREX_VERSION_OUTPUT
        ERROR_QUIET
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    string(REGEX MATCH "[0-9]+\\.[0-9]+" COREX_VERSION "${COREX_VERSION_OUTPUT}")

    set(COREX_LIBRARIES ${COREX_CUDART_LIBRARY})
    set(COREX_COMPILE_OPTIONS "-Xcompiler -fPIC")
    mark_as_advanced(COREX_INCLUDE_DIRS COREX_LIBRARIES COREX_NVCC_EXECUTABLE)
endif()