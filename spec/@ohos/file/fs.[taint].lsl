...

// #note: taint_mark is internal

val TM_SYSTEMINFO: taint_mark  = action NEW_TAINT_MARK();
val TM_REGISTRY: taint_mark    = action NEW_TAINT_MARK();
val TM_ENVIRONMENT: taint_mark = action NEW_TAINT_MARK();
val TM_PROPERTY: taint_mark    = action NEW_TAINT_MARK();
val TM_VALIDATED_SYSTEM_INFORMATION_LEAK_INTERNAL: taint_mark = action NEW_TAINT_MARK();

...

// #note: taint_group is internal

val CWE_497: taint_group = action NEW_TAINT_GROUP("System Information Leak", [497]);

...

// #pragma target:taint-config

import java/util/Properties;  // #note: can be disjointed/self-contained

automaton Properties_Taint
(
)
: Properties
{
    // #problem: unused but required
    initstate Initialized;
    shift Initialized -> self [];

    proc marked (variable: any, tag: taint_mark): bool { /* hidden */ }

    // #problem: 'applyToOverrides'?
    // #problem: 'functionLabel'?
    // #problem: 'modifier'?
    // #problem: 'exclude'?
    @throws(["java.io.IOException"])
    fun *.store (@target self: Properties, writer: Writer, comments: String): void  // <- #cat: sink
    {
        if (marked(self, TM_SYSTEMINFO)  || marked(comments, TM_SYSTEMINFO)  ||
            marked(self, TM_REGISTRY)    || marked(comments, TM_REGISTRY)    ||
            marked(self, TM_ENVIRONMENT) || marked(comments, TM_ENVIRONMENT))
        {
            if (!(
                marked(self,     TM_VALIDATED_SYSTEM_INFORMATION_LEAK_INTERNAL) ||
                marked(comments, TM_VALIDATED_SYSTEM_INFORMATION_LEAK_INTERNAL)
            ))
            {
                action SINK_ALARM(CWE_497);  // #note: interprets this method as a sink within specified groups
            }
        }
    }


    // same as "store" but flattened
    fun *.save (@target self: Properties, writer: Writer, comments: String): void  // <- #cat: sink
    {
        if ((
                action HAS_MARK(self, TM_SYSTEMINFO)  || action HAS_MARK(comments, TM_SYSTEMINFO)  ||
                action HAS_MARK(self, TM_REGISTRY)    || action HAS_MARK(comments, TM_REGISTRY)    ||
                action HAS_MARK(self, TM_ENVIRONMENT) || action HAS_MARK(comments, TM_ENVIRONMENT)
            ) &&
            !(
                action HAS_MARK(self,     TM_VALIDATED_SYSTEM_INFORMATION_LEAK_INTERNAL) ||
                action HAS_MARK(comments, TM_VALIDATED_SYSTEM_INFORMATION_LEAK_INTERNAL)
            ))
        {
            action SINK_ALARM(CWE_497);
        }
    }

}


//===========================================


automaton System_Taint
(
)
: System
{
    ...

    @static fun *.getProperty (name: String): String  // <- #cat: source
    {
        if (! action VALUE_ANY_OF(name, ["line.separator", "file.separator", "user.dir", "user.home", "os.name"])
            &&
            ! action CALLER_IS("System", "lineSeparator", [/* param-types */]))
        {
            // #problem: group?

            action ADD_MARK(result, TM_PROPERTY);
            action ADD_MARK(result, TM_SYSTEMINFO);  // #note: interprets this method as a source (no expected input markers, only output)
        }
    }

}


//===========================================


automaton Editable_Taint
(
)
: Editable
{
    ...

    @static fun *.checkAccessURL (url: String): boolean  // <- #cat: cleaner
    {
        if (true) // #question: can be flattened?
        {
            // #problem: group?

            action REMOVE_MARKS_ALL(url);  // #note: interprets this method as a cleaner? (expects any input mark, outputs none)
        }
    }


    // https://developer.android.com/reference/android/text/Editable
    fun *.replace (@target self: Editable, st: int, en: int, text: CharSequence): Editable  // <- #cat: pass-through
    {
        // #problem: group?

        action COPY_MARKS_ALL(self, result);  // #note: interprets this method as a pass-through (expects any input mark, outputs any mark)
        action COPY_MARKS_ALL(text, result);
    }

}






// ======================================================================



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


//======================================


automaton ohos_file_fs_Stream
(
    // #note: automata variables are not allowed (simple state only)
)
: ohos_file_fs_Stream
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
