import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'Note.dart';

class NotesServices extends ChangeNotifier{
  List<Note> notes =[];
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
      String abiFile = await rootBundle.loadString('build/contracts/NotesContract.json');
      var jsonAbi = jsonDecode(abiFile);
      abicode = ContractAbi.fromJson(jsonEncode(jsonAbi['abi']),"NotesContract");

      contractAdress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    
  }


  late EthPrivateKey creds;
  Future<void> getCredential() async{
    creds = EthPrivateKey.fromHex(privateKey);
  }


  late DeployedContract  _deployedContract;
  late  ContractFunction _createNote;
  late  ContractFunction _deleteNote;
  late  ContractFunction _notes;
  late  ContractFunction _noteCount;

  Future<void> getDeployedContract() async{
    _deployedContract = DeployedContract(abicode, contractAdress);
    _createNote = _deployedContract.function('createNote');
    _deleteNote = _deployedContract.function('deleteNote');
    _notes = _deployedContract.function('notes');
    _noteCount = _deployedContract.function('noteCount');

    await fetchNotes();
  }


  Future<void> fetchNotes() async{
    List totalTaskList = await web3client.call(
        contract: _deployedContract,
        function: _noteCount,
        params: [],
    );

    int totalTaskLen = totalTaskList[0].toInt();
    notes.clear();

    for(var i =0; i<totalTaskLen; i++){
      var temp = await web3client.call(
          contract: _deployedContract,
          function: _notes,
          params: [BigInt.from(i)]
      );

      if(temp[1] != ""){
        notes.add(
            Note(
              (temp[0] as BigInt).toInt(),
              temp[1],
              temp[2]
            )
        );
      }
    }

    notifyListeners();
  }

  Future<void> addNote(String title, String description) async {
    try {

      final transaction = Transaction.callContract(
        contract: _deployedContract,
        function: _createNote,
        parameters: [title, description],
      );

      final response = await web3client.sendTransaction(creds, transaction);

      if (response != null) {
        print('Transaction successful');
      } else {
        print('Transaction failed: Response is null');
      }
    } catch (e) {
      print('Transaction failed---->>> $e');
    }

    notifyListeners();
    fetchNotes();
  }





  Future<void> addNote2(String title, String description) async {
    await web3client.sendTransaction(
        creds,
        Transaction.callContract(
            contract: _deployedContract,
            function: _createNote,
            parameters: [title, description],
        )
    );

    notifyListeners();
    fetchNotes();

    }


}

