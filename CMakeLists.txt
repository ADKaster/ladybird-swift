cmake_minimum_required(VERSION 3.25)

project(swift-test LANGUAGES Swift CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)

find_package(Threads REQUIRED)
find_package(Lagom REQUIRED)

add_library(lagom INTERFACE)
target_include_directories(lagom INTERFACE Sources/lagom/include)
target_compile_definitions(lagom INTERFACE "AK_DONT_REPLACE_STD")
target_compile_options(lagom INTERFACE "SHELL:$<$<COMPILE_LANGUAGE:Swift>:-Xcc -std=c++20>")
target_compile_features(lagom INTERFACE cxx_std_20)

add_executable(View
    Sources/View/App.swift
    Sources/View/AppDelegate.swift
    Sources/View/ContentView.swift
)
target_compile_options(View PRIVATE -cxx-interoperability-mode=default -parse-as-library)
target_link_libraries(View PRIVATE lagom Lagom::WebView)
add_custom_command(TARGET View POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Sources/View/Resources $<TARGET_FILE_DIR:View>/Resources
  COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/Sources/View/Info.plist $<TARGET_FILE_DIR:View>/Info.plist)
