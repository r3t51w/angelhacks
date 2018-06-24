pragma solidity ^0.4.17;

contract Will {

  address owner;
  address lawyer;

  event Refund(address _owner, uint _amount);
  event ethSended(address _reciever, uint _amount);
  uint totalAmount = 0;

  struct Beneficiary{
    uint id;
    string name;
    string relationship;
    address walletAddress;
    uint ethAmount;
  }

  mapping(uint => Beneficiary) public beneficiaries;
  uint public beneficiaryCount = 0;

  constructor () public {
    owner = msg.sender;
  }



  function addBeneficiary (string _name, string _relationship, address _walletAddress, uint _ethAmount) public {
    require(msg.sender == owner);
    beneficiaries[beneficiaryCount] = Beneficiary(beneficiaryCount, _name, _relationship, _walletAddress, _ethAmount);
    beneficiaryCount++;
  }

  function rollBack (uint amount) public returns(int flag)
  {
      require(msg.sender == owner);
      if (amount > totalAmount){return 1;}
      else
      {
          owner.transfer(amount);
          totalAmount-=amount;
          emit Refund(owner,amount);
          return 0;
      }
    }

/*should include a private function to deal with lawer address, should use this as a wrapper*/
  function apointLawer (address _lawerAddress) public
  {
      require(msg.sender == owner);
      lawyer = _lawerAddress;
  }

  function distributeMoney () public
  {
      if (msg.sender == owner || msg.sender == owner)
      {
        for (uint i=0; i<beneficiaryCount; i++)
        {
          require(totalAmount>beneficiaries[i].ethAmount);
          beneficiaries[i].walletAddress.transfer(beneficiaries[i].ethAmount);
          totalAmount-=beneficiaries[i].ethAmount;
          emit ethSended(beneficiaries[i].walletAddress,beneficiaries[i].ethAmount);
        }
      }
  }


  function addFund () payable public{
    totalAmount += msg.value;
  }


}
