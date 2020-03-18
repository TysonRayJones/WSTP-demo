
#include "wstp.h"
#include <unistd.h>

/* the Message tag bound to each function, with which we tag error messages */
#define ERROR_TAG "error"



/* 
 * reporting errors to the Mathematica kernel 
 */
 
void internal_putErrorMessage(char* funcName, char* errMsg) {

    // prepare new expression for Mathematica
    WSPutFunction(stdlink, "EvaluatePacket", 1);

    // send Message[myFunc::errormsg, err], where...
    WSPutFunction(stdlink, "Message", 2);

        // myFunc::errormsg = MessageName[myFunc, "errormsg"]
        WSPutFunction(stdlink, "MessageName", 2);
        WSPutSymbol(stdlink, funcName);
        WSPutString(stdlink, ERROR_TAG);
        
        // err
        WSPutString(stdlink, errMsg);

    // send expression, and prepare another
    WSEndPacket(stdlink);
    WSNextPacket(stdlink);
    WSNewPacket(stdlink);

    // a new packet is now expected; caller MUST send something else
}



void public_directFunc(int myArg) {
    
    // throw an error, using DirectFunc::error defined in my_templates.tm
    if (myArg < 0) {
        internal_putErrorMessage("DirectFunc", "Only positive integers accepted.");
        WSPutSymbol(stdlink, "$Failed");
        return;
    }
    
    // no matter what, we MUST send something back to the kernel
    if (myArg == 42)
        WSPutString(stdlink, "That's a lovely number indeed");
    else 
        WSPutString(stdlink, "That's a terrible number");
}



void private_wrappedFunc(void) {
    
    // fetch the arg from the link
    int myArg;
    WSGetInteger(stdlink, &myArg);
    
    // throw error using WrappedFunc::error defined in my_package.m
    if (myArg%2) {
        internal_putErrorMessage("WrappedFunc", "Only even numbers accepted.");
        WSPutSymbol(stdlink, "$Failed");
        return;
    }
    
    WSPutInteger(stdlink, myArg*myArg);
}




/*
 * dynamic kernel updating during C execution 
 */

void internal_updateProgress(int val) {

    WSPutFunction(stdlink, "EvaluatePacket", 1);

    // i = val
    WSPutFunction(stdlink, "Set", 2);
    WSPutSymbol(stdlink, "i");
    WSPutInteger(stdlink, val);

    WSEndPacket(stdlink);
    WSNextPacket(stdlink);
    WSNewPacket(stdlink);

    // a new packet is now expected; caller MUST send something else
}

void private_slowFunc(void) {
    
    int i=0;
    for (int i=0; i<10; i++) {
        
        sleep(1);
        internal_updateProgress(i);
    }
    
    WSPutString(stdlink, "hello");
}




/*
 * setup WSTP 
 */

int main(int argc, char* argv[]) {
    return WSMain(argc, argv);
}
