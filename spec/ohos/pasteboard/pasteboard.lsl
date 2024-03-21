libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.pasteboard.d.ts";

// imports

import js.common;


// primary semantic types

@package type pasteboard
    is `:pasteboard:@ohos.pasteboard.d.ts`  // #question: what?
    for js_package
{
}


@interface type PasteData
    is `PasteData:pasteboard:@ohos.pasteboard.d.ts`  // #question: what?
    for js_interface
{
}


@interface type pasteboard_SystemPasteboard
    is `SystemPasteboard:pasteboard:@ohos.pasteboard.d.ts`  // #question: what?
    for js_interface
{
}


// global aliases and type overrides

