libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.data.relationalStore.d.ts";

// imports

import js.common;


// primary semantic types

@package type relationalStore
    is `:relationalStore:@ohos.data.relationalStore`
    for js_package
{
}


@interface type relationalStore_ResultSet
    is `ResultSet:relationalStore:@ohos.data.relationalStore`
    for js_interface
{
}


@interface type relationalStore_RdbStore
    is `RdbStore:relationalStore:@ohos.data.relationalStore`
    for js_interface
{
}


@class type RdbPredicates
    is `RdbPredicates:relationalStore:@ohos.data.relationalStore`
    for js_class
{
}