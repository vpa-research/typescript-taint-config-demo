libsl "1.1.0";

library std
    version "*"
    language "any"
    url "-";

// imports

// -none-


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
        v: any,             // a variable!
    ): void;


/// misc actions


define action

