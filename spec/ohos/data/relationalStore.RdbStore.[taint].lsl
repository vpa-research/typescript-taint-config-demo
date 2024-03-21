//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.data.relationalStore.d.ts#L2276";

// imports

import ohos/data/relationalStore;
import ts/lib/promise/promise;

// import ohos/file/fs._taint_;  // taint-related marks and CWE groups


// automata

automaton relationalStore_RdbStore
(
    // #note: automata variables are not allowed (simple state only)
)
: relationalStore_RdbStore
{
    initstate Initialized;

    shift Initialized -> self by [
        query,
    ];


    // how correctly describe "columns?" ?
    fun *.query (@target self: relationalStore_RdbStore, predicates: RdbPredicates, @nullable columns: array<string>): Promise
    {
        result = new relationalStore_ResultSet(state = Open);
    }
}