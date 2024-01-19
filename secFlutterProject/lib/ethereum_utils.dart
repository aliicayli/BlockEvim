
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class EthereumUtils {
  late Web3Client web3client;
  late http.Client httpClient;
  final contractAddress = dotenv.env['CONTRACT_ADDRESS'];

  void initial() {
    httpClient = http.Client();
    String infuraApi = "https://sepolia.infura.io/v3/afa3d8e2028041beb51cb6421a259074";
    web3client = Web3Client(infuraApi, httpClient);
  }

  Future getRentalInfo() async {
    final contract = await getDeployedContract();
    final etherFunction = contract.function("getRentalInfo");
    final result = await web3client.call(contract: contract, function: etherFunction, params: []);
    List<dynamic> res = result;
    return res[0];
  }

  Future<String> setRentalInfo({
    required String ownerName,
    required String tenantName,
    required String propertyAddress,
    required String propertyFeature,
    required String roomCount,
    required String squareMeters,
    required String rentAmount,
  }) async {
    EthPrivateKey privateKeyCred = EthPrivateKey.fromHex(dotenv.env['METAMASK_PRIVATE_KEY']!);
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("setRentalInfo");

    final result = await web3client.sendTransaction(
      privateKeyCred,
      Transaction.callContract(
        contract: contract,
        function: etherFunction,
        parameters: [
          ownerName,
          tenantName,
          propertyAddress,
          propertyFeature,
          roomCount,
          squareMeters,
          rentAmount,
        ],
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
}