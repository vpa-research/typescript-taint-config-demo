//#! pragma: target=taint-config-json
libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "https://gitee.com/openharmony/interface_sdk-js/blob/master/api/@ohos.commonEventManager.d.ts";

// imports

import ohos/commonEventManager/commonEventManager;
import ohos/base/base;
import ohos/commonEvent/commonEventData;
import ohos/commonEventManager/commonEventManager._taint_;


// primary semantic types

// automata

automaton commonEventManager
(
)
: commonEventManager
{
    initstate Initialized;

    shift Initialized -> self by [
        publish,
    ];

    fun *.publish (@target self: commonEventManager, event: string, options: CommonEventPublishData, callback: AsyncCallback): void
    {
        // This is CWE_360 ? (I don't sure, I only suppose)
        if (action HAS_MARK(options, TM_NOT_CHECKED_PERMISSION))
            action SINK_ALARM(CWE_360);
    }
}