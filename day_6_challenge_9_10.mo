import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat64 "mo:base/Nat64";
import SHA224 "./SHA224";
import CRC32 "./CRC32";
import Hex "./Hex";
import L "./ledger_types";

actor day6 {

    let pre : [Nat8] = [10, 97, 99, 99, 111, 117, 110, 116, 45, 105, 100]; //b"\x0Aaccount-id"
    private let subaccount_zero : [Nat8] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

    /**
        Challenge 9 : In a new actor implement a function called default_account that returns the address of the subbacount 0 for the canister.
    **/
    public func default_account() : async Text {
        let p = Principal.fromActor(day6);
        let blob = Principal.toBlob(p);
        let byteArr = Blob.toArray(blob);
        var hash : [Nat8] = SHA224.sha224(Array.append(Array.append(pre, byteArr), subaccount_zero));
        var crc : [Nat8] = CRC32.crc32(hash);
        return Hex.encode(Array.append(crc, hash));
    };

    private func default_account_as_bytes(p : Principal) : Blob {
        let blob = Principal.toBlob(p);
        let byteArr = Blob.toArray(blob);
        var hash : [Nat8] = SHA224.sha224(Array.append(Array.append(pre, byteArr), subaccount_zero));
        var crc : [Nat8] = CRC32.crc32(hash);
        let account = Blob.fromArray(Array.append(crc, hash));
        return account;
    };

    public func get_principal() : async Text {
        let p = Principal.fromActor(day6);
        return Principal.toText(p);
    };

    /**
        Challenge 10 : Challenge 10 : Write two functions :
            + balance : takes no arguments and returns the balance of icps of the canister defaul account.
            + transfer : takes
    **/

    public func balance() : async L.Tokens {
        let byteArr : Blob = default_account_as_bytes(Principal.fromActor(day6));
        let arg = {
            account = byteArr
        };
        let ledger : L.LedgerCanister = actor("rdmx6-jaaaa-aaaaa-aaadq-cai");
        let result = await ledger.account_balance(arg);
        return result;
    };

    public shared(msg) func transfer() : async L.TransferResult {
        let accountTo : Blob = default_account_as_bytes(msg.caller); 
        let arg : L.TransferArgs = {
            memo = 0;
            amount = {
                e8s = 555555555;
            };
            fee = {
                e8s = 10000;
            };
            from_subaccount = ?Blob.fromArray([0]);
            to = accountTo;
            created_at_time = ?{
                timestamp_nanos = Nat64.fromNat(0);
            };
        };
        let ledger : L.LedgerCanister = actor("rdmx6-jaaaa-aaaaa-aaadq-cai");
        let result = await ledger.transfer(arg);
        return result;
    };
};