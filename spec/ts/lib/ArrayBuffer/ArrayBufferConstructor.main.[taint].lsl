///#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://github.com/microsoft/TypeScript/blob/main/src/lib/es5.d.ts";

// imports

import ts/lib/ArrayBuffer/es5;
import ohos/rpc/rpc._taint_;


// automata

automaton ArrayBufferConstructor
(
)
: ArrayBufferConstructor
{
    // states and shifts

    initstate Initialized;

    shift Initialized -> self by [
        constructorWithReturnType,
    ];


    // constructors

    fun *.constructorWithReturnType (@target self: ArrayBufferConstructor, byteLength: number): ArrayBuffer
    {
        if (action HAS_MARK(byteLength, TM_NOT_CHECKED_RANGE_OF_NUMBER))
            action SINK_ALARM(CWE_789);
    }
}