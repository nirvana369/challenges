import Array "mo:base/Array";

module list = {
    // Here's how one would define a linked list in Motoko.
    public type List<T> = ?(T, List<T>);

    /*
        Challenge 7 : Write a function is_null that takes l of type List<T> and returns a boolean indicating if the list is null . Tips : Try using a switch/case.
    */
    public func is_null<T>(l : List<T>) : Bool {
        switch (l) {
            case (?(_)) return false;
            case (null) return true;
        };
    };

    /*
        Challenge 8 : Write a function last that takes l of type List<T> and returns the optional last element of this list.
    */

    public func last<T>(l : List<T>) : ?T {
        var x = l;
        while (is_null<T>(x) == false) {
            switch (x) {
                case (null) return null;
                case (?(last, null)) {return ?last};
                case (?(_, r)) {x := r};
            };
        };
        return null;
    };

    /*
        Challenge 9 : Write a function size that takes l of type List<T> and returns a Nat indicating the size of this list.
        Note : If l is null , this function will return 0.
    */

    public func size<T>(l : List<T>) : Nat {
        var x = l;
        var index : Nat = 0;
        while (is_null<T>(x) == false) {
            switch (x) {
                case (null) return index;
                case (?(last, null)) {
                    index += 1;
                    return index;
                };
                case (?(_, r)) {
                    x := r;
                    index += 1;
                };
            };
        };
        return index;
    };

     /*
        Challenge 10 : Write a function get that takes two arguments : l of type List<T> and n of type Nat this function should return the optional value at rank n in the list.
    */

    public func get<T>(l : List<T>, n : Nat) : ?T {
        var x = l;
        var index : Nat = 0;
        while (is_null<T>(x) == false) {
            switch (x) {
                case (null) return null;
                case (?(last, null)) {
                    if (index == n) {
                        return ?last;
                    };
                    x := null;
                };
                case (?(val, r)) {
                    if (index == n) {
                        return ?val;
                    };
                    x := r;
                    index += 1;
                };
            };
        };
        return null;
    };

    /*
        Challenge 11 : Write a function reverse that takes l of type List and returns the reversed list.
    */

    public func reverse<T>(l : List<T>) : List<T> {
        var x = l;
        var result : List<T> = null;
        var elements : [T] = [];

        while (is_null<T>(x) == false) {
            switch (x) {
                case (null) x := null;
                case (?(val, r)) {
                    x := r;
                    elements := Array.append(elements, [val]);
                };
            };
        };
        var index : Nat = 0;
        while (index < elements.size()) {
            result := ?(elements[index], result);
            index += 1;
        };
        return result;
    };
};