
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sec/ContractService.dart';
import 'package:sec/contract_services.dart';
import 'ContractDetailPage.dart';
import 'CreateContractPage.dart';
import 'EvSahibi.dart';
import 'Kira.dart';
import 'Kiraci.dart';
import 'KiralamaSozlesmesi.dart';
import 'Mulkiyet.dart';
import 'Ozellikler.dart';
import 'Taraflar.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
      ChangeNotifierProvider(
        create: (context)=> NotesServices(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kira Sözleşmeleri'),
        ),
        body: ContractList(),
      ),
    );
  }
}

class ContractList extends StatefulWidget {
  @override
  _ContractListState createState() => _ContractListState();
}

class _ContractListState extends State<ContractList> {
  List<KiralamaSozlesmesi> contracts = ContractService().getContracts();
  TextEditingController _newContractController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var noteServices = context.watch<NotesServices>();


    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                return ContractCard(contract: contracts[index]);
              },
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newContractController,
                    decoration: InputDecoration(
                      hintText: 'Yeni sözleşme ekleyin',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateContractPage()));
                    await noteServices.addContract( "Example JSON data");
                  },
                  child: Text('Ekle'),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }


}


class ContractCard extends StatelessWidget {
  final KiralamaSozlesmesi contract;

  ContractCard({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.house_outlined, size: 40, color: Colors.blue),
        title: Text('Ev Sahibi: ${contract.taraflar.evSahibi.ad}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('Kiracı: ${contract.taraflar.kiraci.ad}', style: TextStyle(fontSize: 14)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContractDetailPage(contract: contract)),
          );
        },
      ),
    );
  }
}





class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true; // This is where you define the logic for handling the certificate validation
      };
  }
}

