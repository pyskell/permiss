const ChildContract = artifacts.require("ChildContract");

contract("ChildContract", accounts => {
    it("should return true when called by the contract owner", () => 
        ChildContract.new(accounts[0])
        .then(instance =>{
            assert(instance.permitted(), true);
        })
    );
})