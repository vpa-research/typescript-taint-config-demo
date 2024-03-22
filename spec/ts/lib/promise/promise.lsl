libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://github.com/microsoft/TypeScript/blob/main/src/lib/es2018.promise.d.ts";

// imports

import js.common;


// primary semantic types


@interface type Promise
    is `Promise:<default>:es2018.promise.d.ts`
    for js_interface
{
}


// global aliases and type overrides

