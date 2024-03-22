///#! pragma: target=taint-config-json
// WARNING: unused
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.data.relationalStore.d.ts#L1733";

// imports

import ohos/data/relationalStore;


// automata

automaton relationalStore_ResultSet
(
)
: relationalStore_ResultSet
{
    initstate Open;
    finishstate Closed;

    shift Open -> Closed by [
        close,
    ];


    fun *.close(@target self: relationalStore_ResultSet): void
    {
        // nothing
    }

}