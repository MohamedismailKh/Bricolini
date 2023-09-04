const TransactionManagement = artifacts.require("TransactionManagement");
contract("TransactionManagement", (accounts) => {
  let transactionManagement;

  beforeEach(async () => {
    transactionManagement = await TransactionManagement.new();
  });

  it("should add a transaction for a recycling center", async () => {
    const date = 1234567890;
    const wasteType = "Plastic";
    const quantity = 100;
    const price = 500;

    await transactionManagement.addTransaction(date, wasteType, quantity, price, { from: accounts[0] });

    const transactions = await transactionManagement.getTransactions({ from: accounts[0] });

    assert.equal(transactions.length, 1, "Transaction not added successfully");
    assert.equal(transactions[0].date, date, "Incorrect date");
    assert.equal(transactions[0].wasteType, wasteType, "Incorrect waste type");
    assert.equal(transactions[0].quantity, quantity, "Incorrect quantity");
    assert.equal(transactions[0].price, price, "Incorrect price");
  });

  it("should get all transactions for a recycling center", async () => {
    // Add some transactions for the recycling center
    await transactionManagement.addTransaction(1234567890, "Plastic", 100, 500, { from: accounts[0] });
    await transactionManagement.addTransaction(1234567891, "Metal", 50, 1000, { from: accounts[0] });
    await transactionManagement.addTransaction(1234567892, "Glass", 75, 800, { from: accounts[0] });

    const transactions = await transactionManagement.getTransactions({ from: accounts[0] });

    assert.equal(transactions.length, 3, "Incorrect number of transactions");
    assert.equal(transactions[0].wasteType, "Plastic", "Incorrect waste type");
    assert.equal(transactions[1].wasteType, "Metal", "Incorrect waste type");
    assert.equal(transactions[2].wasteType, "Glass", "Incorrect waste type");
  });
});
