libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "-";

// imports

import js.actions._taint_;


// vulnerability/error definitions

val CWE_23: taint_group = action NEW_TAINT_GROUP("Relative Path Traversal", [23]);

