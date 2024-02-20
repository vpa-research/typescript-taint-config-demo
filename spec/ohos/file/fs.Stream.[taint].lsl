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

automaton fileIo_Stream
(
    // #note: automata variables are not allowed (simple state only)
)
: fileIo_Stream
{
    initstate Open;
    finishstate Closed;

    shift Open -> self by [
        flushSync,
        readSync,
        writeSync,
    ];

    shift Open -> Closed by [
        closeSync,
    ];


    /*
    fun *.`<end-of-the-world>` ()  // #question: hidden/auto-generated?
    {
        if (action HAS_MARK(self, TM_FILEIO_STREAM_S_CLOSED))  // finish state(s)
            action SINK_ALARM(ERR_fileIo_Stream_InvalidState);
    }
    */


    fun *.closeSync(@target self: fileIo_Stream): void
    {
        // nothing?
    }


    fun *.flushSync(@target self: fileIo_Stream): void
    {
        // nothing?
    }


    fun *.readSync(@target self: fileIo_Stream,
                       buffer: ArrayBuffer,
                       @nullable options: ReadOptions  // #problem: nullability
                   ): number
    {
        if (action HAS_MARK(self, TM_FILE_WRITEONLY))
            action SINK_ALARM(ERR_READ_FROM_WRITEONLY);

        action COPY_MARKS_ALL(buffer, result);
    }


    fun *.writeSync(@target self: fileIo_Stream,
                        buffer: sum_type<ArrayBuffer, string>,    // #problem: no sum-types
                        @nullable options: WriteOptions
                    ): number
    {
        if (action HAS_MARK(self, TM_FILE_READONLY))
            action SINK_ALARM(ERR_WRITE_TO_READONLY);

        if (action HAS_MARK(buffer, TM_SYSTEM_INFO))
            action SINK_ALARM(CWE_497);

        action COPY_MARKS_ALL(buffer, result);
    }

}
