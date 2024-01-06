import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class LifeMeaningProvider extends ChangeNotifier{

  static const String contractName ="LifeMeaning";
  static const String ip ="192.168.243.168";
  static const String port ="7545";
  static const String rpcUrl ="http://$ip:$port";
  static const String wsUrl ="ws://$ip:$port";
  static const String privateKey ="0x391a28f5fc5dc9571180c2016e040bece86716b36f563cfb2617090a74993d8c";


  late Web3Client client;
  late Credentials credentials;
  late DeployedContract contract;

  late ContractFunction getLifeMeaning;
  late ContractFunction setLifeMeaning;

  BigInt? lifeMeaning;
  bool loading =true;

  LifeMeaningProvider(context){
    initialize(context);
  }

  initialize(context) async{
    client = Web3Client(rpcUrl, http.Client(),socketConnector: (){
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    final abiStringFile = await DefaultAssetBundle.of(context)
        .loadString("build/contracts/LifeMeaning.json");
    
    final abiJson = jsonDecode(abiStringFile);
    final abi = jsonEncode(abiJson["abi"]);
    
    final contractAdress = EthereumAddress.fromHex(abiJson["networks"]["5777"]["address"]);
    credentials = EthPrivateKey.fromHex(privateKey);
    contract = DeployedContract(ContractAbi.fromJson(abi, contractName), contractAdress);
    getLifeMeaning = contract.function("get");
    setLifeMeaning = contract.function("set");
    getMeaning();
  }
  
  Future<void> getMeaning() async{
    final result = await client.call(
        contract: contract,
        function: getLifeMeaning,
        params: []
    );
    lifeMeaning = result[0];
    loading =false;
    notifyListeners();
  }

  Future<void> setMeaning(BigInt value) async{
    loading =true;
    notifyListeners();
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: setLifeMeaning,
            parameters: [value]
        )
    );

    getMeaning();
  }



}