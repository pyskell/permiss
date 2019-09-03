const CapTable = artifacts.require("CapTable");
const truffleAssert = require('truffle-assertions');

contract("CapTable", () => {
    let ct;
    let accounts;
    context('basic tests', async function() {
        beforeEach(async function(){
            ct = await CapTable.new();
            accounts = await web3.eth.getAccounts();
        })
        it("should deploy", async () => {
            await assert.notEqual(ct, null)
            // assert.equal(vs.name(), "test_deploy")
        })
    });
})