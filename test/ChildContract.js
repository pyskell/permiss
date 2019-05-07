const ChildContract = artifacts.require("ChildContract");

contract("ChildContract", accounts => {
    it("should return true when called by the contract owner", () => {
        let permitted;
        ChildContract.new(accounts[0]) // The contract owner.
        .then(instance =>{
            permitted = instance.permitted.call([]);
        })
        assert(permitted, true);
    });
    it("should throw when called by another address", () => {
        let permitted;
        ChildContract.new(accounts[1]) // Not the contract owner.
        .then(instance =>{
            permitted = instance.permitted.call([]);
        })
        assert.instanceOf(permitted, Error);
    });
})