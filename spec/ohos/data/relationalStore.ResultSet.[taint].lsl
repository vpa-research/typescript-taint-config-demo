///#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.data.relationalStore.d.ts#L1733";

// imports

import ohos/data/relationalStore;

// import ohos/file/fs._taint_;  // taint-related marks and CWE groups


// automata

automaton relationalStore_ResultSet
(
    // #note: automata variables are not allowed (simple state only)
)
: relationalStore_ResultSet
{
    initstate Open;
    finishstate Closed;

    shift Open -> self by [
    ];

    shift Open -> Closed by [
        close,
    ];


    /*
    fun *.`<end-of-the-world>` (@target self: relationalStore_ResultSet)  // #question: hidden/auto-generated?
    {
        if (action HAS_MARK(self, TM_RELATIONAL_STORE_RESULT_SET_S_CLOSED))  // finish state(s)
            action SINK_ALARM(ERR_relationalStore_ResultSet_InvalidState);
    }
    */


    fun *.close(@target self: relationalStore_ResultSet): void
    {
        // nothing?
    }

}