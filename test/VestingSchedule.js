const VestingSchedule = artifacts.require("VestingSchedule");
const CapTable = artifacts.require("CapTable");
const truffleAssert = require('truffle-assertions');

contract("VestingSchedule", () => {
    let vs;
    let ct;
    let accounts;
    context('basic tests', async function() {
        beforeEach(async function(){
            ct = await CapTable.new();
            accounts = await web3.eth.getAccounts();
        })
        it("should deploy", async () => {
            let vs = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5);
            await vs.name().then(result => assert.equal(result, "test_deploy"));
            // assert.equal(vs.name(), "test_deploy")
        })
        it("should return a vestedPercent of 20", async () => {
            let vs = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5);
            let result = await vs.vestedPercent()
            await assert.equal(result.valueOf(), 20)
        })
        it("should return a vestedPercent of 100", async () => {
            let vs = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 5, 5);
            let result = await vs.vestedPercent()
            await assert.equal(result.valueOf(), 100)
        })
        it("should have testDivLiteral() result in 20", async () => {
            let vs = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 5, 5);
            let resultLiteral = await vs.testDivLiteral()
            await assert.equal(resultLiteral.valueOf(), 20)
        })
        it("should have testDivCast() result in 20", async () => {
            let vs = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 5, 5);
            let resultCast = await vs.testDivCast()
            await assert.equal(resultCast.valueOf(), 20)
        })
        it("should vest 20% per day over a period of 5 days", async () => {
            let vs = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5);
            let result = await vs.vested()
            await assert.equal(result.valueOf(), 200)
            // await vs.vested().then(result => assert.equal(result.valueOf(), 200))
        })
    });

    context("adjusting vesting schedule", async () => {
        beforeEach(async () => {
            ct = await CapTable.new();
            accounts = await web3.eth.getAccounts();
            vs = await VestingSchedule.new(accounts[0], ct.address, "test_deploy", 1000, 1, 5)
        })
        it("should increase vesting year", async () => {
            await vs.increaseYear(1, {from: accounts[0]})
            await assert(vs.year(), 2)
        })
        it("should be 40% vested (400)", async () => {
            await vs.increaseYear(1, {from: accounts[0]})
            let result = await vs.vested()
            await assert.equal(result.valueOf(), 400)
        })
    })
})