" @env-config-doc * vim: Scala support
au BufNewFile,BufRead *.scala setf scala
" @env-config-doc * vim: Gradle support
au BufNewFile,BufRead *.gradle setf groovy
" @env-config-doc * vim: Swift support
au BufNewFile,BufRead *.swift setf swift
" @env-config-doc * vim: Objective-C support
au BufNewFile,BufRead *.mm setf objc
" @env-config-doc * vim: CMake support
au BufNewFile,BufRead CMakeLists.txt,*.cmake,*.cmake.in,*.ctest,*.ctest.in setf cmake
" @env-config-doc * vim: BitBake support
au BufNewFile,BufRead *.bb,*.bbappend,*.bbclass setf bitbake
