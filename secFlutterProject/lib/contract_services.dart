import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'Contract.dart';

class NotesServices extends ChangeNotifier{
  List<Contract> contracts =[];
  late Web3Client web3client;
  final String rpcUrl = 'http://10.0.2.2:7545';
  final String wsUrl = 'http://10.0.2.2:7545';
  final String privateKey = '6b9b3ae43af3c362b7636a2d423369a9e1eaaac1b52f39344b4a3ff43a6bbe56';


  NotesServices(){
    init();
  }

  Future<void> init() async{
    web3client = Web3Client(
        rpcUrl,
        http.Client(),
        socketConnector: (){
          return IOWebSocketChannel.connect(wsUrl).cast<String>();
        }
    );

    await getABI();
    await getCredential();
    await getDeployedContract();
  }

  late ContractAbi abicode;
  late EthereumAddress contractAdress;

  Future<void> getABI() async{
      String abiFile = await rootBundle.loadString('build/contracts/Contract.json');
      var jsonAbi = jsonDecode(abiFile);
      abicode = ContractAbi.fromJson(jsonEncode(jsonAbi['abi']),"Contract");

      contractAdress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    
  }
  late EthPrivateKey creds;
  Future<void> getCredential() async{
    creds = EthPrivateKey.fromHex(privateKey);
  }

  late DeployedContract  _deployedContract;
  late  ContractFunction _createContract;
  late  ContractFunction _contracts;
  late  ContractFunction _contractCount;

  Future<void> getDeployedContract() async{
    _deployedContract = DeployedContract(abicode, contractAdress);
    _createContract = _deployedContract.function('createContract');
    _contracts = _deployedContract.function('contracts');
    _contractCount = _deployedContract.function('count');

    await fetchContracts();
  }


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

    notifyListeners();
  }

  Future<void> addContract( String contractJsonString) async {
    final transaction = Transaction.callContract(
      contract: _deployedContract,
      function: _createContract,
      parameters: [contractJsonString],
    );

    final response = await web3client.sendTransaction(creds, transaction);

    if (response != null) {
      print('--- >> Transaction tamalandı');
    } else {
      print('HATAAA: Response is null');
    }

    notifyListeners();
    fetchContracts();
  }





  Future<void> addNote2(String title, String description) async {
    await web3client.sendTransaction(
        creds,
        Transaction.callContract(
            contract: _deployedContract,
            function: _createContract,
            parameters: [title, description],
        )
    );

    notifyListeners();
    fetchContracts();

    }


}

