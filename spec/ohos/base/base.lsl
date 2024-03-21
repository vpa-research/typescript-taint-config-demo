libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.base.d.ts";

// imports

import js.common;


// primary semantic types

@interface type AsyncCallback
    is `AsyncCallback:<default>:@ohos.base`  // #question: what?
    for js_interface
{
}