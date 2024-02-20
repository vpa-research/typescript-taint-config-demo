libsl "1.1.0";

library std
    version "?"
    language "arkts"
    url "-";

// imports

import js.actions._taint_;


// vulnerability/error definitions

val CWE_23: taint_group  = action NEW_TAINT_GROUP("Relative Path Traversal", [23]);
val CWE_497: taint_group = action NEW_TAINT_GROUP("System Information Leak", [497]);

val ERR_READ_FROM_WRITEONLY: taint_group = action NEW_TAINT_GROUP("Reading from a source in write-only mode", []);
val ERR_WRITE_TO_READONLY: taint_group   = action NEW_TAINT_GROUP("Writing to a destination in read-only mode", []);

val TM_SYSTEM_INFO: taint_mark = action NEW_TAINT_MARK();
