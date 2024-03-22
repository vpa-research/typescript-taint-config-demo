//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.pasteboard.d.ts";

// imports

import ohos/pasteboard/pasteboard;
import ohos/pasteboard/pasteboard._taint_;  // taint-related marks and CWE groups
import ts/lib/promise/promise;


// automata

automaton pasteboard_SystemPasteboard
(
)
: pasteboard_SystemPasteboard
{
    initstate Initialized;

    shift Initialized -> self by [
        setPasteData,
    ];


    fun *.setPasteData (@target self: pasteboard_SystemPasteboard, data: PasteData): Promise
    {
        // https://capec.mitre.org/data/definitions/637.html
        // https://cwe.mitre.org/data/definitions/267.html
        // #question: I suppose this is CWE 267, but I'm not sure
        if (action HAS_MARK(data, TM_STORE_SEVERITY_DATA_IN_PASTEBOARD))
            action SINK_ALARM(CWE_267);
    }

}