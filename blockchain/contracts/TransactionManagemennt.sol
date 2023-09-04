
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract TransactionManagement {

    struct Transaction {
        uint256 date;
        string wasteType;
        uint256 quantity;
        uint256 price;
    }

    // Mapping to store transactions for each recycling center
    mapping(address => Transaction[])  private recyclingCenterTransactions;
    mapping(address => uint256)  private recyclingCenterTotalQuantity;
     // Mapping to store badge status for each recycling center
    mapping(address => string) private recyclingCenterBadges;
    event TransactionAdded(address rc,uint256 date,string wasteType,uint256 quantity,uint256 price);
    // Function to add a transaction for a recycling center
    function addTransaction(
        uint256 date,
        string memory wasteType,
        uint256 quantity,
        uint256 price
    ) public {
        Transaction memory newTransaction = Transaction(date, wasteType, quantity, price);
        recyclingCenterTransactions[msg.sender].push(newTransaction);
        emit TransactionAdded(msg.sender, date, wasteType, quantity, price);
        recyclingCenterTotalQuantity[msg.sender]+=quantity;
    }
    // Function to get all transactions for a recycling center
    function getTransactions() public view returns (Transaction[] memory) {
         Transaction[] memory transactions = recyclingCenterTransactions[msg.sender];
         return transactions;
    }

     function updateBadgeStatus(address recyclingCenter) internal {
        uint256 totalQuantity = recyclingCenterTotalQuantity[recyclingCenter];
        if (totalQuantity >= 1000) {
            recyclingCenterBadges[recyclingCenter] = "Gold";
        } else if (totalQuantity >= 500) {
            recyclingCenterBadges[recyclingCenter] = "Silver";
        } else if (totalQuantity >= 100) {
            recyclingCenterBadges[recyclingCenter] = "Bronze";
        }
        else {
            recyclingCenterBadges[recyclingCenter] = "No Badge";
        }
    }

    // Function to get the badge status for a recycling center
    function getBadgeStatus() public  returns (string memory) {
        updateBadgeStatus(msg.sender);
        return recyclingCenterBadges[msg.sender];
    }
}