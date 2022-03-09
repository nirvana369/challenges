/**
Author : https://github.com/nirvana369
**/
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Char "mo:base/Char";

actor {
    /*
       Challenge 1 : Write a private function swap that takes 3 parameters : a mutable array , an index j and an index i and returns the same array but where value at index i and index j have been swapped.
    */
    private func swap<T>(array : [var T], i : Nat, j : Nat) : [var T] {
        if (i < array.size() and j < array.size()) {
            let temp : T = array[i];
            array[i] := array[j];
            array[j] := temp;
        };
        return array;
    };

    /*
       Challenge 2 : Write a function init_count that takes a Nat n and returns an array [Nat] where value is equal to it's corresponding index.
    */
    public func init_count(n : Nat) : async [Nat] {
        let result = Array.tabulate<Nat>(n, func (index : Nat) : Nat {
            return index;
        });
        return result;
    };

    /*
       Challenge 3 : Write a function seven that takes an array [Nat] and returns "Seven is found" if one digit of ANY number is 8. Otherwise this function will return "Seven not found".
    */
    public func seven(array : [Nat]) : async Text {
        let returnSignal = Char.fromNat32(56);
        for (num in array.vals()) {
            let t = Nat.toText(num);
            for (digit in t.chars()) {
                if (digit == returnSignal) {
                    return "Seven is found";
                };
            };
        };
        return "Seven not found";
    };

    /*
       Challenge 4 : Write a function nat_opt_to_nat that takes two parameters : n of type ?Nat and m of type Nat . This function will return the value of n if n is not null and if n is null it will default to the value of m.
    */
    public func nat_opt_to_nat(n : ?Nat, m : Nat) : async Nat {
        switch (n) {
            case (?num) {
                return num;
            };
            case (null) return m;
        };
    };

    /*
       Challenge 5 : Write a function day_of_the_week that takes a Nat n and returns a Text value corresponding to the day. If n doesn't correspond to any day it will return null .
    */
    public func day_of_the_week(n : Nat) : async ?Text {
        switch (n) {
            case (1) return ?"Monday";
            case (2) return ?"Tuesday";
            case (3) return ?"Wednesday";
            case (4) return ?"Thursday";
            case (5) return ?"Friday";
            case (6) return ?"Saturday";
            case (7) return ?"Sunday";
            case (_) return null;
        };
    };

    /*
       Challenge 6 : Write a function populate_array that takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0.
    */
    public func populate_array(array : [?Nat]) : async [Nat] {
        let result = Array.map(array, func (n : ?Nat) : Nat {
            switch (n) {
                case (?num) return num;
                case (null) return 0;
            };
        });
        return result;
    };

    /*
       Challenge 7 : Write a function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
    */
    public func sum_of_array(array : [Nat]) : async Nat {
        let sum = Array.foldLeft<Nat, Nat>(array, 0, func (s : Nat, num : Nat) : Nat {
            return s + num;
        });
        return sum;
    };

    /*
       Challenge 8 : Write a function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
    */
    public func squared_array(array : [Nat]) : async [Nat] {
         let result = Array.map(array, func (n : Nat) : Nat {
            return n**n;
        });
        return result;
    };

    /*
       Challenge 9 : Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
    */
    public func increase_by_index(array : [Nat]) : async [Nat] {
        let result = Array.tabulate(array.size(), func (index : Nat) : Nat {
            return array[index] + index;
        });
        return result;
    };

    /*
       Challenge 10 : Write a higher order function contains<A> that takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
        This function should return a boolean indicating whether or not a is present in the array.
    */
    private func contains<A>(array : [A], a : A, f : (A, A) -> Bool) : Bool {
        var i = 0;
        while (i < array.size()) {
            if (f(array[i], a)) {
                return true;
            };
            i += 1;
        };
        return false;
    };

    // public func test1(arr : [Nat], i : Nat, j : Nat) : async [Nat] {
    //     let x = swap<Nat>(Array.thaw(arr), i, j);
    //     Array.freeze(x);
    // };

    // public func test10(arr : [Nat], n : Nat) : async Bool {
    //     return contains<Nat>(arr, n, func (arri : Nat, a : Nat) {
    //         if (arri == a) {
    //             return true;
    //         };
    //         return false;
    //     });
    // };
};