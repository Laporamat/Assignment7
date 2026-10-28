# Assignment7

🏦 Bank Smart Contract DApp (Sepolia Testnet)

เว็บแอปพลิเคชันกระจายศูนย์ (DApp) สำหรับปฏิสัมพันธ์กับ Smart Contract ระบบธนาคาร บนเครือข่าย Ethereum Sepolia Testnet พัฒนาด้วย HTML, Tailwind CSS และ Ethers.js v5

👨‍🎓 ข้อมูลผู้จัดทำ (Student Information)

รหัสนักศึกษา: [66063709]

ชื่อ-นามสกุล: [ปรมัตถ์ เอี่ยมองค์]

วิชา: Smart Contract and Decentralized Application Development

ระบบส่งงาน: dlearning

📌 คุณสมบัติของระบบ (Features)

MetaMask Integration: รองรับการเชื่อมต่อและสลับบัญชี MetaMask อัตโนมัติ แสดงยอดเหรียญ SepoliaETH ในกระเป๋าปัจจุบัน

Smart Contract Binding: เชื่อมต่อกับ Smart Contract ธนาคารผ่าน Address และ ABI ที่กำหนด

Deposit (ฝากเงิน): ฝากเหรียญ SepoliaETH เข้าสู่ Smart Contract (ฟังก์ชัน payable)

Withdraw (ถอนเงิน): ถอนเหรียญออกจาก Smart Contract คืนเข้ากระเป๋าผู้ใช้โดยจัดการค่า Value เป็น 0 เพื่อป้องกันข้อผิดพลาด Transaction Reverted

Check Balance (เช็คยอดเงิน): ตรวจสอบยอดเงินสะสมส่วนตัวในสัญญาผ่านฟังก์ชัน checkBlance()

Real-time Event Listener & Console Log: แสดงประวัติการทำรายการและตรวจจับ Event (Deposit, Withdraw) จากบล็อกเชนแบบ Real-time

Responsive & Dynamic UI: ดีไซน์ด้วยสไตล์ Glassmorphism รองรับทั้งคอมพิวเตอร์และมือถือ

🛠 Smart Contract Details

Contract Address: 0xB9124f9b3bC86C7356742d74F836c720c38CE0a5

Network: Sepolia Testnet

Solidity Code Structure:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank {
    mapping (address => uint) _balances;
    event Deposit(address indexed owner, uint amount);
    event Withdraw(address indexed owner, uint amount);

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
