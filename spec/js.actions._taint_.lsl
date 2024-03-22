libsl "1.1.0";

library std
    version "*"
    language "any"
    url "-";

// imports

// -none-


/// primary actions

define action NEW_TAINT_MARK (
    ): taint_mark;


define action NEW_TAINT_GROUP (
        note: string,           // a literal!
        cweList: array<int32>   // a literal!
    ): taint_group;


define action SINK_ALARM (
        err: taint_group   // a variable!
    ): void;


/// taint tag/mark validation actions

define action HAS_MARK (
        v: any,            // a variable!
        mark: taint_mark   // a variable!
    ): bool;


/// taint mark/tag management actions

define action ADD_MARK (
        v: any,             // a variable!
        mark: taint_mark    // a variable!
    ): void;


define action COPY_MARK (
        from: any,          // a variable!
        to: any,            // a variable!
        mark: taint_mark    // a variable!
    ): void;


define action COPY_MARKS_ALL (
        from: any,          // a variable!
        to: any             // a variable!
    ): void;


define action REMOVE_MARK (
        v: any,             // a variable!
        mark: taint_mark    // a variable!
    ): void;


define action REMOVE_MARKS_ALL (
        v: any              // a variable!
    ): void;


/// misc actions

define action VALUE_CONTAINS (
        v: any,             // a variable!
        substring: string   // a literal!
    ): bool;


define action VALUE_MATCHES (
        v: any,             // a variable!
        regex: string       // a literal!
    ): bool;

