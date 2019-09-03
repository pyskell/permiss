const CapTable = artifacts.require("CapTable");
const VestingSchedule = artifacts.require("VestingSchedule")
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
        it("should add a VestingSchedule", async () => {
          let vestingSchedule = await VestingSchedule.new(accounts[0], "test_deploy", 1000, 1, 5)
          await ct.addSchedule(vestingSchedule.address, {from: accounts[0]})

          let storedScheduleAddress = await ct.vestingSchedules.call(accounts[0])
          console.log(storedScheduleAddress)

          let storedSchedule = await VestingSchedule.at(storedScheduleAddress)

          await storedSchedule.grantee().then(result => assert.equal(result, accounts[0]))
        })
    });
})