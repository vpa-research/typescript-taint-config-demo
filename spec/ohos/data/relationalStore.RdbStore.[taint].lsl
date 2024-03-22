///#! pragma: target=taint-config-json
// WARNING: unused
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.data.relationalStore.d.ts#L2276";

// imports

import js.common;
import ohos/data/relationalStore;
import ts/lib/promise/promise;


// automata

automaton relationalStore_RdbStore
(
)
: relationalStore_RdbStore
{
    initstate Initialized;

    shift Initialized -> self by [
        query,
    ];


    fun *.query (@target self: relationalStore_RdbStore, predicates: RdbPredicates, @nullable columns: Array<string>): Promise
    {
        result = new relationalStore_ResultSet(state = Open);
    }
}