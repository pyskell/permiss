const ChildContract = artifacts.require("ChildContract");
const truffleAssert = require('truffle-assertions');

contract("ChildContract", () => {
    let child;
    let accounts;
    context('child', async function() {
        beforeEach(async function(){
            accounts = await web3.eth.getAccounts();
            await ChildContract.new(accounts[0]).then(function(instance){child = instance});
        })
        it("should return true when called by the contract owner", async () => {
            await child.permitted.call([]).then(result => assert.isTrue(result));     
        });
        it("should throw an error when not called by the contract owner", async () => {
            await truffleAssert.reverts(child.permitted.call([],{from: accounts[1]}), "Permission denied. Not an owner.");
        });
        it("should be enabled on deployment", async () => {
            await child.super.enabled().then(result => assert.isTrue(result));
        });
    });
})