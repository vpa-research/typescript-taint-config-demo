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


// #problem: a workaround
type sum_type
    is `<internal>`
    for sum_type
{
}


type object
    is `?`
    for object
{
}


@interface type js_interface
    is `?`
    for object
{
}


@interface type ArrayBuffer
    is `ArrayBuffer:<default>:`
    for js_interface
{
}


typealias number = int64; // #problem: not actually the case
typealias boolean = bool; // #problem: not actually the case

