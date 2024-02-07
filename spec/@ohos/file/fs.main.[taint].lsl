//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.file.fs.d.ts";

// imports

import @ohos/file/fs;


// automata

automaton ohos_file_fs
(
)
: ohos_file_fs // #problem: this is a namespace "type"
{

    // #question: how to put/associate this with "@ohos.file.fs::accessSync" ?
    static fun *.accessSync (path: string): boolean
    {
        action COPY_MARKS(path, result);
    }


    static fun *.createStreamSync (path: string, mode: string): ohos_file_fs_Stream
    {
        if (mode == "r")                action ADD_MARK(result, TM_READONLY);
        if (mode == "w" || mode == "a") action ADD_MARK(result, TM_WRITEONLY);

        if (action VALUE_CONTAINS(path, "../")) // #note: shorthand for regex match
            action SINK_ALARM(...); // potential path escape?

        action COPY_MARKS(path, result);

        // #question: where to put state assignment on the result
    }

}

