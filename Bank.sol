// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank {
    mapping (address => uint) _balances;
    event Deposit(address indexed owner, uint amount);
    event Withdraw(address indexed owner, uint amount);

    // ฟังก์ชันรับเหรียญอัตโนมัติเมื่อมีการส่ง ETH เข้าสัญญาโดยตรง
    receive() external payable {
        _balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit money is zero");
        _balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(amount > 0 && amount <= _balances[msg.sender], "not enough money");
        
        _balances[msg.sender] -= amount;
        
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed.");

        emit Withdraw(msg.sender, amount);
    }

    function checkBlance() public view returns (uint balance) {
        return _balances[msg.sender];
    }
}