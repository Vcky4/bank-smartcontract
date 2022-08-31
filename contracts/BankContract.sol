// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

contract BankContract{
    address public bankOwner;
    string public bankName;

    mapping (address => uint) public customerBalance;

    constructor(){
        bankOwner = msg.sender;
    }

    //function to deposit some money
    function depositMoney() public payable {
        require(msg.value != 0, "You need to deposit some amount of money!");

        customerBalance[msg.sender] += msg.value;
    }

    //function to set bank name
    function setBankName(string memory _name) external{
        require(msg.sender == bankOwner, "You must be owner to set bank name!");
        bankName = _name;
    }

    //function to withdraw money
    function withdraw(address payable _to, uint _total) public{
        require(_total <= customerBalance[msg.sender], "you have insuffient funds to withdraw!");
        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);

    }

    //function to check current balance
    function checkCurrentBalance() external view returns (uint){
        return customerBalance[msg.sender];
    }

    //function to check bank balance
    function checkBankBalance() public view returns (uint){
        require(msg.sender == bankOwner, "you must be bank owner to see all balances!");
        return address(this).balance;
    }

}