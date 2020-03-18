
BeginPackage["MyPackage`"]

    WrappedFunc::usage = "WrappedFunc[myArg] squares myArg."
    WrappedFunc::error = "`1`"
    
    SlowFunc::usage = "SlowFunc[] does something slow, but tries to look good doing it."
    SlowFunc::error = "`1`"
    
    Begin["`Private`"]
    
        (*
         * called by WSTP templated functions which otherwise go unevaluated
         *)
         
        invalidArgs[func_Symbol] := (
            Message[func::error, "Invalid arguments. See ?" <> ToString[func]];
            $Failed
        )
        
        
        WrappedFunc[myArg_Integer] := With[
            {num=privateWrappedFunc[myArg]},
            If[
                num === $Failed,
                $Failed,
                Style[num, Directive[Green, Large]]
            ]
        ]
        WrappedFunc[___] := 
            invalidArgs[WrappedFunc]


        SlowFunc[] := Monitor[
            i=0; privateSlowFunc[],
            ProgressIndicator[i,{0,10}]
        ]
        
        
    End[ ]
                                       
EndPackage[]