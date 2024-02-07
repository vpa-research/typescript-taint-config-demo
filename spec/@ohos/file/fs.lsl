libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.file.fs.d.ts";

// imports

import js.common;


// primary semantic types

@package type ohos_file_fs
    is `@ohos.file.fs`  // #question: what?
    for js_package
{
}


@interface type ohos_file_fs_Stream
    is `@ohos.file.fs.Stream`  // #question: what?
    for js_interface
{
}


// global aliases, type overrides, taint marks and groups

val TM_FILE_READONLY: taint_mark  = action NEW_TAINT_MARK();
val TM_FILE_WRITEONLY: taint_mark = action NEW_TAINT_MARK();

