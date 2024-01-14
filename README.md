
# Blok Evim

# Flutter Truffle Ganache Rental Contract Management App

A Flutter application for managing rental contracts, integrated with Ethereum using Truffle and Ganache. 
The application allows users to view existing contracts, create new contracts, and store contract details on the Ethereum blockchain.

## Features

- View a list of existing rental contracts.
- Create new rental contracts and store them on the Ethereum blockchain.
- Save contract details in JSON format.
- Retrieve contract details from the Ethereum blockchain.
- User-friendly interface for seamless contract management.

## Ethereum Smart Contract

The project includes a simple Ethereum smart contract written in Solidity. The smart contract, named `Contract`, allows the creation and deletion of rental contracts. When a contract is created, its details are recorded as a JSON string on the Ethereum blockchain.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.17;

contract Contract {
  uint256 public noteCount = 0;
  struct Contract {
    uint256 id;
    string contractDetailJSON;
  }

  mapping(uint256 => Contract) public notes;


  event ContractCreated(uint256 id, string contractDetail);


  function createContract(string memory _title, string memory contractDetail) public {
    notes[noteCount] = Contract(noteCount,contractDetail);
    emit ContractCreated(noteCount,contractDetail);
    noteCount++;
  }

}

## Screenshots

![Contract List](screenshots/contract_list.png) ![Create Contract](screenshots/create_contract.png) ![Contract Detail](screenshots/contract_detail.png)



