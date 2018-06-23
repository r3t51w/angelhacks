pragma solidity ^0.4.17;

contract Will {

  address owner;
  address lawyer;
  
  uint totalAmount = 0;

  struct Beneficiary {
    uint id;
    string name;
    string relationship;
    address walletAddress;
  }

  mapping(uint => Beneficiary) public beneficiaries;
  uint public beneficiaryCount;

  constructor () public {
    owner = msg.sender; 
  }

  function addBeneficiary (string _name, string _relationship, address _walletAddress) public {
    require(msg.sender == owner);
    beneficiaries[beneficiaryCount] = Beneficiary(beneficiaryCount, _name, _relationship, _walletAddress);
    beneficiaryCount++;
  }
}