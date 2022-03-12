/**
Author : https://github.com/nirvana369
**/
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor {

    /**
        Challenge 1 : Create an actor in main.mo and declare the following types.
            + TokenIndex of type Nat.
            + Error which is a variant type with multiples tags :
    **/
    type TokenIndex = Nat;
    type Error = {
        #Failed : Text;
        #PermissionInvalid : Text;
        #NotFound : Text;
        #TransferFailed : Text;
    };

    /**
        Challenge 2 : Declare an HashMap called registry with Key of type TokenIndex and value of type Principal. This will keeep track of which principal owns which TokenIndex.
    **/
    private stable var registryState : [(TokenIndex, Principal)] = [];
    private var registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.fromIter(registryState.vals(), 0, Nat.equal, Hash.hash);
    
    /**
       Challenge 3 : Declare a variable of type Nat called nextTokenIndex, initialized at 0 that will keep track of the number of minted NFTs.
        Write a function called mint that takes no argument.
        This function should :
            + Returns a result of type Result and indicate an error in case the caller is anonymous.
            + If the user is authenticated : associate the current TokenIndex with the caller (use the HashMap we've created) and increase nextTokenIndex.
    **/
    private stable var nextTokenIndex : Nat = 0;
    public shared(msg) func mint() : async Result.Result<(), Error> {
        registry.put(nextTokenIndex, msg.caller);
        if (_isOwner(nextTokenIndex, msg.caller) == false) {
            return #err(#Failed(""));
        };
        nextTokenIndex += 1;
        return #ok(());
    };

    private func _isOwner(tokenIndex: Nat, owner : Principal) : Bool {
        switch (registry.get(nextTokenIndex)) {
            case (?p) {
                if (p == owner) {
                    return true;
                };
                return false;
            };
            case (null) return false;
        };
    };
    /**
       Challenge 4 : Write a function called transfer that takes two arguments :
            + to of type Principal.
            + tokenIndex of type Nat.
        This function will transfer ownership of tokenIndex to the specified principal. You will check for eventuals errors and returns a result of type Result.
    **/
    public shared(msg) func transfer(to : Principal, tokenIndex : Nat) : async Result.Result<(), Error> {
        switch (registry.get(tokenIndex)) {
            case (?p) {
                if (p != msg.caller) {
                    return #err(#PermissionInvalid(""));
                };
                if (_isOwner(nextTokenIndex, to) == false) {
                    return #err(#TransferFailed(""));
                };
                #ok(());
            };
            case (null) return #err(#NotFound(""));
        };
    };

    /**
       Challenge 5 : Write a function called balance that takes no arguments but returns a list of tokenIndex owned by the called.
    **/

    public query(msg) func balance() : async [TokenIndex] {
        let entries = registry.entries();
        var result : [TokenIndex] = [];
        for ((k, v) in entries) {
            if (v == msg.caller) {
                result := Array.append(result, [k]);
            };
        };
        return result;
    };

    /**
    Challenge 6 : Write a function called http_request that should return a message indicating the number of nft minted so far and the principal of the latest minter. (Use the section on http request in the daily guide).   
    **/

    public type HeaderField = (Text, Text);

    public type Token = {};

    public type StreamingCallbackHttpResponse = {
        body : Blob;
        token : Token;
    };

    public type StreamingStrategy = {
        #Callback : {
            callback : shared Token -> async StreamingCallbackHttpResponse;
            token : Token;
        };
    };

    public type HttpRequest = {
        method : Text;
        url : Text;
        headers : [HeaderField];
        body : Blob;
    };

    public type HttpResponse = {
        status_code : Nat16;
        headers : [HeaderField];
        body : Blob;
        streaming_strategy : ?StreamingStrategy;
    };

    public query func http_request(request : HttpRequest) : async HttpResponse {
        var lastMinter : Text = "No one";

        if (nextTokenIndex > 0) {
            switch (registry.get(nextTokenIndex-1)) {
                case (?p) {
                    lastMinter := Principal.toText(p);
                };
                case (null) {};
            };
        };
        
        let body : Text = "NFT minted:   " # Nat.toText(nextTokenIndex) # "T\nLatest minter:   " # lastMinter;
        {
            status_code = 200;
            headers = [("content-type", "text/plain")];
            
            body = Text.encodeUtf8 (body);
            streaming_strategy = null;
        };
    };

    /**
        Challenge 7 : Modify the actor so that you can safely upgrade it without loosing any state.
    **/
    system func preupgrade() {
        registryState := Iter.toArray(registry.entries());
    };
    system func postupgrade() {
        registryState := [];
    };

    /**
        Challenge 8 : day_6_challenge_8.mo
    **/

    /**
        Challenge 9 + 10: day_6_challenge_9_10.mo
    **/
};