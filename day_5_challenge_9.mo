/**
Author : https://github.com/nirvana369
**/
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

actor {
    /*
        Challenge 9 : In a new file, copy and paste the functionnalities you've created in challenges 2 to 5. This time the hashmap and all records should be preserved accross upgrades.
    */
    private stable var _state : [(Principal, Nat)] = [];

    system func preupgrade() {
        _state := Iter.toArray(favoriteNumber.entries());
    };
    system func postupgrade() {
        _state := [];
    };
    /*
        Challenge 2 : Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
    */
    var favoriteNumber : HashMap.HashMap<Principal, Nat> = HashMap.fromIter(_state.vals(), 0, Principal.equal, Principal.hash);

    /*
        Challenge 3 : Write two functions :
            + add_favorite_number that takes n of type Nat and stores this value in the HashMap where the key is the principal of the caller. This function has no return value.
            + show_favorite_number that takes no argument and returns n of type ?Nat, n is the favorite number of the person as defined in the previous function or null if the person hasn't registered.
    */

    // dupplicate func with challenge 4
    public shared (msg) func add_favorite_number(n : Nat) : async () {
        favoriteNumber.put(msg.caller, n);
    };

    public query (msg) func show_favorite_number() : async ?Nat {
        favoriteNumber.get(msg.caller);
    };

    /*
        Challenge 4 : Rewrite your function add_favorite_number so that if the caller has already registered his favorite number, the value in memory isn't modified. This function will return a text of type Text that indicates "You've already registered your number" in that case and "You've successfully registered your number" in the other scenario.
    */
    public shared (msg) func add_favorite_number(n : Nat) : async Text {
        let fNum = favoriteNumber.get(msg.caller);
        switch (fNum) {
            case (null) {
                favoriteNumber.put(msg.caller, n);
                return "You've successfully registered your number";
            };
            case (?n) return "You've already registered your number";
        };
    };

    /*
        Challenge 5 : Write two functions
            + update_favorite_number
            + delete_favorite_number
    */
    public shared (msg) func update_favorite_number(n : Nat) : async () {
        favoriteNumber.put(msg.caller, n);
    };

    public shared (msg) func delete_favorite_number() : async () {
        let fNum = favoriteNumber.get(msg.caller);
        switch (fNum) {
            case (?n) favoriteNumber.delete(msg.caller);
            case (null) {};
        };
    };
};