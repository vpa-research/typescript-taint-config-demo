libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "-";

// imports

import js.common;
import vulnerabilities/js;


// global taint marks and groups
val TM_STORE_SEVERITY_DATA_IN_PASTEBOARD: taint_mark  = action NEW_TAINT_MARK();