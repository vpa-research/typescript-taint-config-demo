libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.file.fs.d.ts";

// imports

import js.common;


// primary semantic types

@package type fileIo
    is `:fileIo:@ohos.file.fs`  // #question: what?
    for js_package
{
}


@interface type fileIo_Stream
    is `Stream:fileIo:@ohos.file.fs`  // #question: what?
    for js_interface
{
}


@interface type ReadOptions
    is `ReadOptions:<default>:@ohos.file.fs`  // #question: what?
    for js_interface
{
}


// global aliases and type overrides

