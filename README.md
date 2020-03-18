# WSTP demo

This repo demonstrates an architecture for WSTP Mathematica packages.

It includes demos of
- a minimum build (for MacOS)
- directly-callable C functions
- C functions callable from within the package
- reporting runtime errors from C using [`Message`](https://reference.wolfram.com/language/ref/Message.html)
- updating a [`ProgressIndicator`](https://reference.wolfram.com/language/ref/ProgressIndicator.html) from a C function (as per Szabolcs's [advice](https://mathematica.stackexchange.com/questions/216494/progressindicator-during-a-wstp-c-function))
