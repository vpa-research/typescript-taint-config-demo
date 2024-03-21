///#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://github.com/microsoft/TypeScript/blob/main/src/lib/es5.d.ts";

// imports

import js.common;


// primary semantic types

@interface type ArrayBuffer
    is `ArrayBuffer:<default>:lib/es5`
    for js_interface
{
}


@interface type ArrayBufferConstructor
    is `ArrayBufferConstructor:<default>:lib/es5`
    for js_interface
{
}