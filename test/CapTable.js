const CapTable = artifacts.require("CapTable");
const VestingSchedule = artifacts.require("VestingSchedule")
const truffleAssert = require('truffle-assertions');

contract("CapTable", () => {
    let ct;
    let accounts;

    describe('basic tests', async function() {
        before(async function(){
            ct = await CapTable.new();
            accounts = await web3.eth.getAccounts();
        })

        it("should deploy", async () => {
            await assert.isNotNull(ct, null)
        })

        it("should add a VestingSchedule", async () => {
            const vestingSchedule = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5)
            await ct.addSchedule(vestingSchedule.address, {from: accounts[0]})

            const storedScheduleAddress = await ct.vestingSchedules.call(accounts[0])

            const storedSchedule = await VestingSchedule.at(storedScheduleAddress)

            const res = await storedSchedule.grantee()
            assert.strictEqual(res, accounts[0])
        })

        it("should delete a VestingSchedule", async () => {
            const vestingSchedule = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5)
            await ct.addSchedule(vestingSchedule.address, {from: accounts[0]})

            await ct.deleteSchedule(accounts[0], {from: accounts[0]})
            const deletedSchedule = await ct.vestingSchedules.call(accounts[0])

            assert.strictEqual(deletedSchedule, `0x${"00".repeat(20)}`)
        })

        it("should replace a VestingSchedule with a new one", async () => {
          const vestingSchedule = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5)
          await ct.addSchedule(vestingSchedule.address, {from: accounts[0]})

          const newSchedule = await VestingSchedule.new(accounts[1], accounts[0], "test_deploy", 1000, 1, 5)
          await ct.replaceSchedule(accounts[0], newSchedule.address, {from: accounts[0]})

          const retrievedSchedule = await VestingSchedule.at(await ct.vestingSchedules.call(accounts[1]))

          const res = await retrievedSchedule.grantee.call()
          assert.strictEqual(res, accounts[1])
        })
    });
})