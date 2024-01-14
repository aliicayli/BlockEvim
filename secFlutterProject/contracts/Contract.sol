// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.17;

contract Contract {
  uint256 public count = 0;
  struct ContractStruct {
    uint256 id;
    string contractDetailJSON;
  }

  mapping(uint256 => ContractStruct) public contracts;


  event ContractCreated(uint256 id, string contractDetailJSON);


  function createContract(string memory contractDetailJSON) public {
    contracts[count] = ContractStruct(count,contractDetailJSON);
    emit ContractCreated(count,contractDetailJSON);
    count++;
  }
}
