
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'RentalInfo.dart';
import 'Taraflar.dart';
import 'ethereum_utils.dart';

Future<void> main() async {

  await dotenv.load(fileName: ".env");
  runApp(
      ChangeNotifierProvider(
        create: (context)=> ContractServices(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
  List<RentalInfo> propertyList = [];
  String _data = "";
  EthereumUtils ethUtils = EthereumUtils();

  @override
  void initState() {
    ethUtils.initial();
    super.initState();
  }


  void _handleButtonTap() {
    ethUtils.getRentalInfo().then((value) {
      RentalInfo propertyInfo = _parseDataList(value);
      propertyList.add(propertyInfo);
      setState(() {});
    });
  }

  RentalInfo _parseDataList(List dataList) {
    return RentalInfo(
      ownerName: dataList[0],
      tenantName: dataList[1],
      propertyAddress: dataList[2],
      propertyFeature: dataList[3],
      roomCount: dataList[4],
      squareMeters: dataList[5],
      rentAmount: dataList[6],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blok Evim',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff165997),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateContractPage()));
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xff165997),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white, // Set border color
                  width: 1, // Set border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Yeni Sözleşme',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),



      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var property in propertyList)
                Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Color(0xffeeeff4), // Background color for the card
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Owner', property.ownerName, Icons.person, Colors.blue),
                        _buildInfoRow('Tenant', property.tenantName, Icons.person, Colors.green),
                        _buildInfoRow('Address', property.propertyAddress, Icons.location_on, Colors.red),
                        _buildInfoRow('Feature', property.propertyFeature, Icons.home, Colors.orange),
                        _buildInfoRow('Room Count', property.roomCount.toString(), Icons.hotel, Colors.purple),
                        _buildInfoRow('Square Meters', property.squareMeters.toString(), Icons.crop_square, Colors.teal),
                        _buildInfoRow('Rent Amount', ' ${property.rentAmount}', Icons.attach_money, Colors.indigo),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      floatingActionButton: GestureDetector(
        onTap: _handleButtonTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Set rounded corners
            color: Color(0xff03a8d2), // Set dark green color
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            'Get Last Contract',
            style: TextStyle(
              color: Colors.white, // Set text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor), // Set icon color
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}




