const ChildContract = artifacts.require("ChildContract");
const truffleAssert = require('truffle-assertions');

contract("ChildContract", () => {
    let child;
    let accounts;
    context('child', async function() {
        beforeEach(async function(){
            accounts = await web3.eth.getAccounts();
            await ChildContract.new(accounts[0], 128).then(function(instance){child = instance});
        })
        it("should revert when deployed with too large of a limit", async () => {
            await truffleAssert.reverts(ChildContract.new(accounts[0], 512), "limit must be less than 256")
        })
        it("should return true when called by the contract owner with a recent blockhash", async () => {
            let latest_block = await web3.eth.getBlock("latest");
            let recent_block = await web3.eth.getBlock(latest_block.number - 10);

            await child.permitted.call(recent_block.hash).then(result => assert.isTrue(result));
        });
        it("should return false when called by the contract owner with an old blockhash", async () => {
            let latest_block = await web3.eth.getBlock("latest");
            let old_block = await web3.eth.getBlock(latest_block.number - 128);

            await child.permitted.call(old_block.hash).then(result => assert.isFalse(result));
        });
        it("should throw an error when not called by the contract owner", async () => {
            await truffleAssert.reverts(child.permitted.call([],{from: accounts[1]}), "Permission denied. Not an owner");
        });
        it("should be enabled on deployment", async () => {
            await child.enabled().then(result => assert.isTrue(result));
        });
        it("should have upgrade_address deployed as 0x0", async () =>{
            await child.upgrade_address().then(result => assert.equal(result, 0x0));
        })
    });
})