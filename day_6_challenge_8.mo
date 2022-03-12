import Result "mo:base/Result";

actor {

    type Error = {
        #Failed : Text;
        #PermissionInvalid : Text;
        #NotFound : Text;
        #TransferFailed : Text;
    };
    type MintActor = actor {mint : shared() -> async Result.Result<(), Error>};

    public func mint() : async Text {
        // run command [dfx canister create day_6] to get principal
        let nft : MintActor = actor("rno2w-sqaaa-aaaaa-aaacq-cai");
        let rs = await nft.mint();
        switch (rs) {
            case (#ok(_)) return "mint successfully!";
            case (#err(err)) {
                return "mint failed!";
            };
        };
    };
};