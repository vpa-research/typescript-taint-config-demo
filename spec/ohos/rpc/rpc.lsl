libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.rpc.d.ts";

// imports

import js.common;


// primary semantic types

@package type rpc
    is `:rpc:@ohos.rpc`
    for js_package
{
}


@class type rpc_MessageSequence
    is `MessageSequence:rpc:@ohos.rpc`
    for js_class
{
}