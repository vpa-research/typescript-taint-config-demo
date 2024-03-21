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
        // create,
        readInt,
    ];


    fun *.readInt (@target self: rpc_MessageSequence): number
    {
        // Can we close MessageSequence object ?
        //if (action HAS_MARK(self, TM_OHOS_MESSAGE_SEQUENCE_CLOSED))
        //    action SINK_ALARM(ERR_ohos_message_sequence_InvalidState);

        action ADD_MARK(result, TM_NOT_CHECKED_RANGE_OF_NUMBER);
    }


    // Do we need to add original type MessageSequence for return type of this method ?
    /* static fun *.create (@target self: rpc_MessageSequence): MessageSequence
    {
        action ADD_MARK(result, TM_OHOS_MESSAGE_SEQUENCE_OPENED);
    }
    */
}