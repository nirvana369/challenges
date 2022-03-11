/**
Author : https://github.com/nirvana369
**/
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";

actor {
    /*
        Challenge 1 : Write a function is_anonymous that takes no arguments but returns true is the caller is anonymous and false otherwise.
    */
    public query(msg) func is_anonymous() : async Bool {
        if (Principal.toText(msg.caller) == "2vxsx-fae") {
            return true;
        };
        return false;
    };

    /*
        Challenge 2 : Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
    */
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

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

    /*
        Challenge 6 : Write a function deposit_cycles that allow anyone to deposit cycles into the canister. This function takes no parameter but returns n of type Nat corresponding to the amount of cycles deposited by the call.
    */
    public func deposit_cycles() : async Nat {
        let available = Cycles.available();
        let accepted = Cycles.accept(available);
        return accepted;
    };

    /*
        Challenge 7 (hard warning) : Write a function withdraw_cycles that takes a parameter n of type Nat corresponding to the number of cycles you want to withdraw from the canister and send it to caller asumming the caller has a callback called deposit_cycles()
        Note : You need two canisters.
    */
    type CallbackCycles = actor {deposit_cycles : shared () -> async ()}; // Notify to another canister deposit cycle to this canister ?

    public shared(msg) func withdraw_cycles(n : Nat, notifyCanister : Principal) : async () {
        let callbackActor : CallbackCycles = actor(Principal.toText(notifyCanister));
        await send_cycles(n, callbackActor.deposit_cycles);
    };

    private func send_cycles(n : Nat, callback : shared () -> async ()) : async () {
        await callback();   // wait to another canister send cycles
        Cycles.add(n);
        let refund = Cycles.refunded();
    };

    /*
        Challenge 8 : Rewrite the counter (of day 1) but this time the counter will be kept accross ugprades. Also declare a variable of type **Nat¨¨ called version_number that will keep track of how many times your canister has been upgraded.
    */
    private stable var version_number : Nat = 0;

    system func preupgrade() {
        version_number += 1;
    };

    public func get_version() : async Nat {
        return version_number;
    };

    /*
        Challenge 9 : day_5_challenge_9.mo
    */
};