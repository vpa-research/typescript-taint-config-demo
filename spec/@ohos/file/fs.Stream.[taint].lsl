//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.file.fs.d.ts";

// imports

import @ohos/file/fs;

import @ohos/file/fs._taint_;  // taint-related marks and CWE groups


// automata

automaton fileIo_Stream
(
    // #note: automata variables are not allowed (simple state only)
)
: fileIo_Stream
{
    initstate Open;
    finishstate Closed;

    shift Open -> self [
        flushSync,
        readSync,
        writeSync,
    ];

    shift Open -> Closed [
        closeSync,
    ];


    fun *.`<end-of-the-world>` ()  // #question: hidden?
    {
        if (action HAS_MARK(self, TM_OHOS_FILE_FS_STREAM_S_CLOSED))  // finish state
            action SINK_ALARM(ERR_ohos_file_fs_Stream_InvalidState);
    }


    fun *.closeSync(@target self: ohos_file_fs_Stream): void
    {
        // <- before everything: (hidden)
        if (action HAS_MARK(self, TM_OHOS_FILE_FS_STREAM_S_CLOSED))
            action SINK_ALARM(ERR_ohos_file_fs_Stream_InvalidState);

        {
            // nothing?
        }

        // <- after everything: (hidden)
        action REMOVE_MARK(self, TM_OHOS_FILE_FS_STREAM_S_OPEN);
        action ADD_MARK(self, TM_OHOS_FILE_FS_STREAM_S_CLOSED);
    }


    fun *.flushSync(@target self: ohos_file_fs_Stream): void
    {
        // <- before everything: (hidden)
        if (action HAS_MARK(self, TM_OHOS_FILE_FS_STREAM_S_CLOSED) || action HAS_MARK(self, TM_OHOS_FILE_FS_STREAM_S_CLOSED))
            action SINK_ALARM(ERR_ohos_file_fs_Stream_InvalidState);

        {
            // nothing?
        }

        // <- after everything: (hidden)
        action REMOVE_MARK(self, TM_OHOS_FILE_FS_STREAM_S_OPEN);
        action ADD_MARK(self, TM_OHOS_FILE_FS_STREAM_S_OPEN);
        // #note: same state - can do nothing
    }


    fun *.readSync(@target self: ohos_file_fs_Stream,
                       buffer: ArrayBuffer,
                       @nullable options: ReadOptions  // #problem: nullability
                   ): number
    {
        // <- before everything: (hidden)
        if (action HAS_MARK(self, TM_OHOS_FILE_FS_STREAM_S_CLOSED))
            action SINK_ALARM(ERR_ohos_file_fs_Stream_InvalidState);

        {
            if (action HAS_MARK(self, TM_WRITEONLY))
                action SINK_ALARM(...);

            action COPY_MARKS(buffer, result);
        }

        // <- after everything: (hidden)
        // #note: same state - no transition
    }


    fun *.writeSync(@target self: ohos_file_fs_Stream,
                        buffer: ArrayBuffer | string,    // #problem: no sum-types
                        @nullable options: WriteOptions
                    ): number
    {
        // <- before everything: (hidden)
        if (action HAS_MARK(self, TM_OHOS_FILE_FS_STREAM_S_CLOSED))
            action SINK_ALARM(ERR_ohos_file_fs_Stream_InvalidState);

        // user code here
        {
            if (action HAS_MARK(self, TM_READONLY))
                action SINK_ALARM(...);

            if (action HAS_MARK(buffer, TM_SYSTEM_INFO))
                action SINK_ALARM(...);

            action COPY_MARKS(buffer, result);
        }

        // <- after everything: (hidden)
        // #note: same state - no transition
    }

}
