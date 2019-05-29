const SingleOwner = artifacts.require("SingleOwner");
const truffleAssert = require('truffle-assertions');

contract("SingleOwner", () => {
    let so;
    let accounts;
    context('so', async function() {
        beforeEach(async function(){
            accounts = await web3.eth.getAccounts();
            await SingleOwner.new(accounts[0], 128).then(function(instance){so = instance});
        })
        it("should revert when deployed with too large of a limit", async () => {
            await truffleAssert.reverts(SingleOwner.new(accounts[0], 512), "limit must be less than 256")
        })
        it("should return true when called by the contract owner with a recent blockhash", async () => {
            let latest_block = await web3.eth.getBlock("latest");
            let recent_block = await web3.eth.getBlock(latest_block.number - 10);

            await so.permitted.call(recent_block.hash).then(result => assert.isTrue(result));
        });
        it("should return false when called by the contract owner with an old blockhash", async () => {
            let latest_block = await web3.eth.getBlock("latest");
            let old_block = await web3.eth.getBlock(latest_block.number - 128);

            await so.permitted.call(old_block.hash).then(result => assert.isFalse(result));
        });
        it("should return false when not called by the contract owner", async () => {
            await so.permitted.call([],{from: accounts[1]}).then(result => assert.isFalse(result));
        });
        it("should be enabled on deployment", async () => {
            await so.enabled().then(result => assert.isTrue(result));
        });
        it("should have upgrade_address deployed as 0x0", async () =>{
            await so.upgrade_address().then(result => assert.equal(result, 0x0));
        })
    });
})