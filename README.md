
# Blok Evim

# Flutter Truffle Ganache Rental Contract Management App

A Flutter application for managing rental contracts, integrated with Ethereum using Truffle and Ganache. 
The application allows users to view existing contracts, create new contracts, and store contract details on the Ethereum blockchain.

## Features

- View a list of existing rental contracts.
- Create new rental contracts and store them on the Ethereum blockchain.
- Save contract details in  JSON string format.
 EXAMPLE : {"taraflar":{"evSahibi":{"ad":"Ali ","adres":"Kötekli Mah. Kyk Erkek Yurdu ","telefon":"05441414445"},"kiraci":{"ad":"Enes","adres":"Pamukkale Mahallesi, 24. Sok. DENIZLI","telefon":"0577874566"}},"mulkiyet":{"adres":"amukkale Mahallesi, 24. Sok. DENIZLI","ozellikler":{"odaSayisi":4,"metrekare":130}},"kira":{"bedel":12000.0,"odemeSikligi":"ay","odemeSekli":"nakit","gecikmeCeza":200.0}}
- Retrieve contract details from the Ethereum blockchain.
- User-friendly interface for seamless contract management.

- ## Screenshots
Caption: Screenshot of the result of `truffle migrate` command.
![Contract List](https://drive.usercontent.google.com/download?id=1dNBJ-jdw-dNG04-agsUKds15C4KcK3cr&export=download&authuser=0&confirm=t&uuid=07c99a2b-e8c5-42e0-97dd-d5e2270f805a&at=APZUnTWU6bEI1k_WGSVeNiVsgBQ4:1705237150946)

Caption: Screenshot of pages.
![Create Contract](https://drive.usercontent.google.com/download?id=123YQ3vp6SixklMtA997W5NHgYWvbRFOq&export=download&authuser=0&confirm=t&uuid=68851331-27ad-4b51-a5e7-30b5db30585f&at=APZUnTUlE-89guBTSWEXIUVCVD56:1705237152084)


## Solidity Smart Contract

The project includes a simple Ethereum smart contract written in Solidity. The smart contract, named `Contract`, allows the creation and deletion of rental contracts. When a contract is created, its details are recorded as a JSON string on the Ethereum blockchain.

```solidity
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
```

## Dart methods to get and set contract

```dart
  Future<void> addContract(String title, String description) async {
    try {

      final transaction = Transaction.callContract(
        contract: _deployedContract,
        function: _createContract,
        parameters: [title, description],
      );

      final response = await web3client.sendTransaction(creds, transaction);

      if (response != null) {
        print('--- >> Transaction tamalandı');
      } else {
        print('HATAAA: Response is null');
      }
    } catch (e) {
      print('Transaction failed---->>> $e');
    }

    notifyListeners();
    fetchContracts();
  }

# -----------------------------------------------------------
Future<void> fetchContracts() async{
    List totalTaskList = await web3client.call(
        contract: _deployedContract,
        function: _contractCount,
        params: [],
    );

    print(" gelen veri ------ >>> "+totalTaskList[0].toString());
    int totalTaskLen = totalTaskList[0].toInt();
    contracts.clear();
    for(var i =0; i<totalTaskLen; i++){
      var temp = await web3client.call(
          contract: _deployedContract,
          function: _contracts,
          params: [BigInt.from(i)]
      );
      if(temp[1] != ""){
        contracts.add(
            Contract(
              (temp[0] as BigInt).toInt(),
              temp[1],
              temp[2]
            )
        );
      }
    }
  }
```

## EXTRA

ekstra eklenecek şeyler


