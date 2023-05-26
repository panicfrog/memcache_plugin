
# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.9.0)


project("memcache_plugin")

find_package(MemCache REQUIRED CONFIG)

add_library( # Sets the name of the library.
             memcache_plugin

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             memcache_plugin.cpp )


find_library( # Sets the name of the path variable.
              log-lib
              log )


target_link_libraries( # Specifies the target library.
                       memcache_plugin
                       MemCache::MemCache
                       ${log-lib} )
