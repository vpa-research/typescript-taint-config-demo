//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.pasteboard.d.ts";

// imports

import ohos/pasteboard/pasteboard;

import ohos/pasteboard/pasteboard._taint_;  // taint-related marks and CWE groups


// automata

automaton pasteboard
(
)
: pasteboard
{
    initstate Initialized;

    shift Initialized -> self by [
        createPlainTextData,
        getSystemPasteboard,
    ];


    fun *.createPlainTextData (@target self: pasteboard, text: string): PasteData
    {
        action ADD_MARK(result, TM_STORE_SEVERITY_DATA_IN_PASTEBOARD);
    }


    fun *.getSystemPasteboard (@target self: pasteboard): pasteboard_SystemPasteboard
    {

    }

}