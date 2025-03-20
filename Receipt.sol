pragma solidity ^0.8.0;

contract TransactionReceipt {

    struct Receipt {
        uint256 id;
        address payer;
        uint256 amount;
        uint256 timestamp;
    }

    Receipt[] public receipts;
    uint256 public nextId = 1;

    event ReceiptIssued(uint256 id, address payer, uint256 amount, uint256 timestamp);

    function issueReceipt() external payable {
        require(msg.value > 0, "Transaction must have value");
        
        receipts.push(Receipt({
            id: nextId,
            payer: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp
        }));

        emit ReceiptIssued(nextId, msg.sender, msg.value, block.timestamp);
        nextId++;
    }

    function getReceipt(uint256 _id) external view returns (Receipt memory) {
        require(_id > 0 && _id < nextId, "Invalid receipt ID");
        return receipts[_id - 1];
    }
}
