
:: this is a function defined in C which is directly callable through MyPackage
:: hence, the template specifies the public namespace, and all doc and alternate 
:: evaluations are defined here

:Begin:
:Function:       public_directFunc
:Pattern:        MyPackage`DirectFunc[myArg_Integer]
:Arguments:      { myArg }
:ArgumentTypes:  { Integer }
:ReturnType:     Manual
:End:
:Evaluate: 
    MyPackage`DirectFunc::usage = "DirectFunc[myArg] decides whether myArg is a lovely number. Accepts only positive numbers";
    MyPackage`DirectFunc::error = "`1`";
    MyPackage`DirectFunc[___] := MyPackage`Private`invalidArgs[DirectFunc];




:: this is a function defined in C which is used by another package function, in my_package.m
:: hence, the template uses the Private` namespace, and this function itself should 
:: not throw any errors

:Begin:
:Function:       private_wrappedFunc
:Pattern:        MyPackage`Private`privateWrappedFunc[myArg_Integer]
:Arguments:      { myArg }
:ArgumentTypes:  { Manual }
:ReturnType:     Manual
:End:
:Evaluate: 
    MyPackage`Private`privateWrappedFunc::usage = "privateWrappedFunc[] should be called internally by the package, and returns the square of myArg if even."




:: this is a function which, in co-operating with the caller in my_package.m, attempts 
:: to dynamically update a progress bar

:Begin:
:Function:       private_slowFunc
:Pattern:        MyPackage`Private`privateSlowFunc[]
:Arguments:      { }
:ArgumentTypes:  { }
:ReturnType:     Manual
:End:
:Evaluate: 
    MyPackage`Private`privateSlowFunc::usage = "privateSlowFunc[] should be called internally by the package, and attempts to indicate its progress."