//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.rpc.d.ts";

// imports

import ohos/rpc/rpc;
import ohos/rpc/rpc._taint_;


// automata

automaton rpc_MessageSequence
(
)
: rpc_MessageSequence
{
    initstate Open;

    shift Open -> self by [
        readInt,
    ];


    static fun *.create (): rpc_MessageSequence
    {
        result = new rpc_MessageSequence(state = Open);
    }


    fun *.readInt (@target self: rpc_MessageSequence): number
    {
        action ADD_MARK(result, TM_NOT_CHECKED_RANGE_OF_NUMBER);
    }

}