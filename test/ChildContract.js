const ChildContract = artifacts.require("ChildContract");

contract("ChildContract", () => {
    let child;
    let accounts;
    context('child', async function() {
        beforeEach(async function(){
            accounts = await web3.eth.getAccounts();
            child = await ChildContract.new(accounts[0]);
        })
        it("should return true when called by the contract owner", () => {
            child.permitted().then(result =>
                    assert.isFalse(result)
                );
            child.permitted().then(result =>
                assert.isTrue(result)
            );                
            child.permitted.call().then(result =>
                assert.isFalse(result)
            );
            child.permitted.call().then(result =>
                assert.isTrue(result)
            );      
        });
    });
    // it("should throw when called by another address", () => {
    //     let permitted;
    //      // Not the contract owner.
    //     await child.then(instance =>{
    //         permitted = instance.permitted.call([]);
    //     })
    //     assert.instanceOf(permitted, Error);
    // });
})