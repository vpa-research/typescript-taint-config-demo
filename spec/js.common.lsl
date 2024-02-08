libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "-";

// imports

import js.annotations;
import js.actions._taint_;


// primary semantic types

type js_package
    is `?`
    for js_package
{
}

@interface type js_interface
    is `?`
    for js_interface
{
}


@interface type ArrayBuffer
    is `ArrayBuffer:<default>:`  // #question: what?
    for js_interface
{
}

