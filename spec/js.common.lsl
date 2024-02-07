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
    is `<something:js_package>`
    for js_package
{
}

type js_interface
    is `<something:js_interface>`
    for js_interface
{
}

