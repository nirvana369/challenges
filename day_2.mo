/**
Author : https://github.com/nirvana369
**/
import Nat8 "mo:base/Nat8";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Blob "mo:base/Blob";

actor {
    /*
        Challenge 1 : Write a function nat_to_nat8 that converts a Nat n to a Nat8.
        Make sure that your function never trap.
    */
    public func nat_to_nat8(n : Nat) : async Nat8 {
        if (n < 256) {
            return Nat8.fromNat(n);
        };
        return 0;
    };

    /*
        Challenge 2 : Write a function max_number_with_n_bits that takes a Nat n and 
        returns the maximum number than can be represented with only n-bits.
    */
    public func max_number_with_n_bits(n : Nat) : async Nat {
        return 2**n - 1;
    };

    /*
        Challenge 3 : Write a function decimal_to_bits that takes a Nat n and
        returns a Text corresponding to the binary representation of this number.
        Note : decimal_to_bits(255) -> "11111111".
    */
    public func decimal_to_bits(n : Nat) : async Text {
        if (n == 0) {
            return "0";
        };
        var res : Text = "";
        var num : Nat = n;
        while (num != 1) {
            let m = num % 2;
            num := num / 2;
            res := Nat.toText(m) # res;
        };
        res := "1" # res;
        return res;
    };

    /*
        Challenge 4 : Write a function capitalize_character that takes a Char c and
        returns the capitalized version of it.
    */
    public func capitalize_character(c : Char) : async Char {
        let n : Nat32 = Char.toNat32(c);
        if (n > 96 and n < 123) {
            return Char.fromNat32(n - 32);
        };
        return c;
    };

    /*
        Challenge 5 :  Write a function capitalize_text that takes a Text t and
        returns the capitalized version of it.
    */
    public func capitalize_text(t : Text) : async Text {
        // #1
        // var array : [var Char] = Array.thaw(Iter.toArray(t.chars()));
        // for (i in array.size()) {
        //     let n : Nat32 = Char.toNat32(array[i]);
        //     if (n > 96 and n < 123) {
        //         array[i] := Char.fromNat32(n - 32);
        //     };
        // };
        // return Text.fromIter(Iter.fromArray(Array.freeze(array)));

        // #2
        let rs = Text.map(t, func(c : Char) : Char {
            let n : Nat32 = Char.toNat32(c);
            if (n > 96 and n < 123) {
                return Char.fromNat32(n - 32);
            };
            return c;
        });

        // #3
        // return Text.map(t , Prim.charToUpper);
    };

    /*
        Challenge 6 : Write a function is_inside that takes two arguments : a Text t and a Char c and
        returns a Bool indicating if c is inside t .
    */
    public func is_inside(t : Text, c : Char) : async Bool {
        // for (char in t.chars()) {
        //     if (c == char) {
        //         return true;
        //     };
        // };
        // return false;
        return Text.contains(t, #char(c));
    };

    /*
        Challenge 7 : Write a function trim_whitespace that takes a text t and
        returns the trimmed version of t.
        Note : Trim means removing any leading and trailing spaces from the text : trim_whitespace(" Hello ") -> "Hello".
    */
    public func trim_whitespace(t : Text) : async Text {
        return Text.trim(t, #text(" "));
    };

    /*
        Challenge 8 : Write a function duplicated_character that takes a Text t and
        returns the first duplicated character in t converted to Text.
        Note : The function should return the whole Text if there is no duplicate character : 
        duplicated_character("Hello") -> "l" & duplicated_character("World") -> "World".
    */
    public func duplicated_character(t : Text) : async Text {
        let array : [Char] = Iter.toArray(t.chars());
        for (i in Iter.range(0, array.size() - 2)) {
            for (j in Iter.range(i + 1, array.size() - 1)) {
                if (array[i] == array[j]) {
                    return Text.fromChar(array[i]);
                }
            };
        };
        return t;
    };

    /*
        Challenge 9 : Write a function size_in_bytes that takes Text t and
        returns the number of bytes this text takes when encoded as UTF-8.
    */
    public func size_in_bytes(t : Text) : async Nat {
        return Blob.toArray(Text.encodeUtf8(t)).size();
    };

    /*
        Challenge 10 : Implement a function bubble_sort that takes an array of natural numbers and returns the sorted array .
    */
    public func bubble_sort(array : [Nat]) : async [Nat] {
        var rs : [var Nat] = Array.thaw(array);
        for (i in Iter.range(0, rs.size() - 2)) {
            for (j in Iter.range(0, rs.size() - i - 2)) {
                if (rs[j] > rs[j + 1]) {
                    let temp = rs[j];
                    rs[j] := rs[j + 1];
                    rs[j + 1] := temp;
                };
            };
        };
        return Array.freeze(rs);
    };
};