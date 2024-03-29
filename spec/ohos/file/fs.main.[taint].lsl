//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.file.fs.d.ts";

// imports

import ohos/file/fs;
import ohos/file/fs._taint_;  // taint-related marks and CWE groups


// automata

automaton fileIo
(
)
: fileIo
{
    initstate Initialized; // required


    static fun *.accessSync (path: string): boolean
    {
        action COPY_MARKS_ALL(path, result);
    }


    static fun *.createStreamSync (path: string, mode: string): fileIo_Stream
    {
        if (mode == "r")                action ADD_MARK(result, TM_FILE_READONLY);
        if (mode == "w" || "a" == mode) action ADD_MARK(result, TM_FILE_WRITEONLY);

        if (action VALUE_CONTAINS(path, "../"))
            action SINK_ALARM(CWE_23);

        action COPY_MARKS_ALL(path, result);

        result = new fileIo_Stream(state = Open);
    }

}

