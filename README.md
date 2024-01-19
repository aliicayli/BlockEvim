
# Blok Evim

# Flutter Truffle Ganache Rental Contract Management App

A Flutter application for managing rental contracts, integrated with Ethereum using Truffle and Ganache. 
The application allows users to view existing contracts, create new contracts, and store contract details on the Ethereum blockchain.

## Features

- View a list of existing rental contracts.
- Create new rental contracts and store them on the Ethereum blockchain.
- Save contract details in string format.
 EXAMPLE : "Aylin Uysal, Barış Tekin ,Göktürk Mahallesi/123.Sokak/No: 45/Kat:3/Daire: 12, Modern Bahçeli Villa, 5+2, 350, 9000TL"
- Retrieve contract details from the Ethereum blockchain.
- User-friendly interface for seamless contract management.

- ## Screenshots
Caption: Screenshot of the result of `truffle migrate` command.
![Contract List](https://drive.usercontent.google.com/download?id=1dNBJ-jdw-dNG04-agsUKds15C4KcK3cr&export=download&authuser=0&confirm=t&uuid=07c99a2b-e8c5-42e0-97dd-d5e2270f805a&at=APZUnTWU6bEI1k_WGSVeNiVsgBQ4:1705237150946)

Caption: Screenshot of pages.
![Create Contract](https://github.com/aliicayli/BlockEvim/blob/main/secFlutterProject/ScreenShots2.png)


## Solidity Smart Contract

The project includes a simple Ethereum smart contract written in Solidity. The smart contract, named `Contract`, allows the creation and deletion of rental contracts. When a contract is created, its details are recorded as a JSON string on the Ethereum blockchain.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.17;

contract basicDapp {
    struct RentalInfo {
        string ownerName;
        string tenantName;
        string propertyAddress;
        string propertyFeatures;
        string roomCount;
        string squareMeters;
        string rentAmount;
    }

    RentalInfo public rentalInfo;

    function setRentalInfo(
        string memory _ownerName,
        string memory _tenantName,
        string memory _propertyAddress,
        string memory _propertyFeature,
        string memory _roomCount,
        string memory _squareMeters,
        string memory _rentAmount
    ) public {
        rentalInfo = RentalInfo(
            _ownerName,
            _tenantName,
            _propertyAddress,
            _propertyFeature,
            _roomCount,
            _squareMeters,
            _rentAmount
        );
    }

    function getRentalInfo() public view returns (RentalInfo memory) {
        return rentalInfo;
    }
}
```

## Dart methods to get and set contract

```dart
   Future getRentalInfo() async {
    final contract = await getDeployedContract();
    final etherFunction = contract.function("getRentalInfo");
    final result = await web3client.call(contract: contract, function: etherFunction, params: []);
    List<dynamic> res = result;
    return res[0];
  }

  Future<String> setRentalInfo({required String ownerName, required String tenantName, required String propertyAddress,
    required String propertyFeature, required String roomCount, required String squareMeters, required String rentAmount,
  }) async {
    EthPrivateKey privateKeyCred = EthPrivateKey.fromHex(dotenv.env['METAMASK_PRIVATE_KEY']!);
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("setRentalInfo");

    final result = await web3client.sendTransaction(
      privateKeyCred,
      Transaction.callContract(
        contract: contract,
        function: etherFunction,
        parameters: [ownerName, tenantName, propertyAddress, propertyFeature, roomCount, squareMeters, rentAmount,],
        maxGas: 100000,
      ),
      chainId: 4,
      fetchChainIdFromNetworkId: false,
    );
    return result;
  }


  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "BasicDapp"), EthereumAddress.fromHex(contractAddress!));
    return contract;
  }
```


