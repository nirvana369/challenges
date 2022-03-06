/**
Author https://github.com/nirvana369
**/
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {
    /**
        Challenge 1 : Write a function add that takes two natural numbers n and m and 
        returns the sum.
    **/
    public func add(n : Nat, m : Nat) : async Nat {
        return n + m;
    };

    /**
        Challenge 2 : Write a function square that takes a natural number n and 
        returns the area of a square of length n.
    **/
    public func square(n : Nat) : async Nat {
        return n * n;
    };

    /**
        Challenge 3 : Write a function days_to_second that takes a number of days n and 
        returns the number of seconds.
    **/
    public func days_to_second(n : Nat) : async Nat {
        return n * 24 * 60 * 60;
    };

    /** 
        Challenge 4 : Write two functions increment_counter & clear_counter .
           + increment_counter returns the incremented value of counter by n.
           + clear_counter sets the value of counter to 0. 
    **/
    private var counter : Nat = 0;

    public func increment_counter(n : Nat) : async Nat {
        counter := counter + n;
        return counter;
    };

    public func clear_counter() : async Nat {
        counter := 0;
        return counter;
    };

    /**
        Challenge 5 : Write a function divide that takes two natural numbers n and m and 
        returns a boolean indicating if n divides m.
    **/
    public func divide(n : Nat, m : Nat) : async Bool {
        if (n == 0 or m == 0) {
            return true;
        };
        if (n % m == 0) {
            return true;
        };
        return false;
    };

    /**
        Challenge 6 : Write a function is_even that takes a natural number n and 
        returns a boolean indicating if n is even.
    **/
    public func is_even(n : Nat) : async Bool {
        if (n % 2 == 0) {
            return true;
        };
        return false;
    };

    /**
        Challenge 7 : Write a function sum_of_array that takes an array of natural numbers and returns the sum.
        This function will returns 0 if the array is empty.
    **/
    public func sum_of_array(array : [Nat]) : async Nat {
        var sum = 0;
        if (array.size() == 0) {
            return sum;
        };
        for (n in array.vals()) {
            sum := sum + n;
        };
        return sum;
    };

    /**
        Challenge 8 : Write a function maximum that takes an array of natural numbers and returns the maximum value in the array.
        This function will returns 0 if the array is empty.
    **/
    public func maximum(array : [Nat]) : async Nat {
        var max = 0;
        if (array.size() == 0) {
            return max;
        };
        for (n in array.vals()) {
            if (n > max) {
                max := n;
            };
        };
        return max;
    };

     /**
        Challenge 9 : Write a function remove_from_array that takes 2 parameters : an array of natural numbers and a natural number n and 
        returns a new array where all occurences of n have been removed (order should remain unchanged).
    **/
    public func remove_from_array(array : [Nat], n : Nat) : async [Nat] {
        var result : [Nat] = [];
        for (num in array.vals()) {
            if (num != n) {
                result := Array.append(result, [num]);
            };
        };
        return result;
    };

    /**
        Challenge 10 : Implement a function selection_sort that takes an array of natural numbers and returns the sorted array .
    **/
    public func selection_sort(array : [Nat]) : async [Nat] {
        if (array.size() <= 1) {
            return array;
        };
        var arraySort : [var Nat] = Array.thaw(array);
        let arraySizeSub2 = array.size() - 2;
        let arraySizeSub1 = array.size() - 1;
        for (i in Iter.range(0, arraySizeSub2)) {
            var minIndex = i;
            for (j in Iter.range(i + 1, arraySizeSub1)) {
                // find min value & index
                if (arraySort[j] < arraySort[minIndex]) {
                    minIndex := j;
                };
            };
            // swap min value & index was found to current index
            if (minIndex != i) {
                let temp = arraySort[i];
                arraySort[i] := arraySort[minIndex];
                arraySort[minIndex] := temp;
            };
        };
        return Array.freeze(arraySort);
    };
};
