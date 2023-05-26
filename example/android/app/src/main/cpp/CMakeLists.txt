
# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.9.0)

find_package(MemCache REQUIRED CONFIG)

project("memcache_plugin_example")

add_library(
             memcache_plugin_example
             SHARED
             memcache_plugin_example.cpp )

find_library(
            log-lib
            log )

target_link_libraries(
                       memcache_plugin_example
                       MemCache::MemCache
                       ${log-lib} )
