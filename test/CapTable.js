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
        })
        it("should add a VestingSchedule", async () => {
            let vestingSchedule = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5)
            await ct.addSchedule(vestingSchedule.address, {from: accounts[0]})

            let storedScheduleAddress = await ct.vestingSchedules.call(accounts[0])

            let storedSchedule = await VestingSchedule.at(storedScheduleAddress)

            await storedSchedule.grantee().then(result => assert.equal(result, accounts[0]))
        })
        it("should delete a VestingSchedule", async () => {
            let vestingSchedule = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5)
            await ct.addSchedule(vestingSchedule.address, {from: accounts[0]})

            await ct.deleteSchedule(accounts[0])
            let deletedSchedule = await ct.vestingSchedules.call(accounts[0])

            await assert.equal(deletedSchedule, 0x0)
        })
        it("should replace a VestingSchedule with a new one", async () => {
            let vestingSchedule = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5)
            await ct.addSchedule(vestingSchedule.address, {from: accounts[0]})
            
            let newSchedule = await VestingSchedule.new(accounts[1], ct.address, "test_deploy", 1000, 1, 5)
            await ct.replaceSchedule(accounts[0], newSchedule.address, {from: accounts[0]})

            let retrievedSchedule = await VestingSchedule.at(await ct.vestingSchedules.call(accounts[1]))

            await retrievedSchedule.grantee.call().then(result => assert.equal(result, accounts[1]))
        })
    });
})