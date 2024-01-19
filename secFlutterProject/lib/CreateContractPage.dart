
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sec/ethereum_utils.dart';

class CreateContractPage extends StatefulWidget {
  const CreateContractPage({super.key});

  @override
  State<CreateContractPage> createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {

  EthereumUtils ethUtils = EthereumUtils();

  @override
  void initState() {
    ethUtils.initial();
    super.initState();
  }

  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController propertyAddressController = TextEditingController();
  final TextEditingController propertyFeatureController = TextEditingController();
  final TextEditingController roomCountController = TextEditingController();
  final TextEditingController squareMetersController = TextEditingController();
  final TextEditingController rentAmountController = TextEditingController();



  String getRentalInfo() {
    String ownerName = ownerNameController.text;
    String tenantName = tenantNameController.text;
    String propertyAddress = propertyAddressController.text;
    String propertyFeature = propertyFeatureController.text;
    String roomCount = roomCountController.text;
    String squareMeters = squareMetersController.text;
    String rentAmount = rentAmountController.text;

    String result =
        "$ownerName, $tenantName, $propertyAddress, $propertyFeature, $roomCount, $squareMeters, $rentAmount";

    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff165997),
        title: Text('Rental Information Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField('Owner Name', ownerNameController),
            _buildTextField('Tenant Name', tenantNameController),
            _buildTextField('Property Address', propertyAddressController),
            _buildTextField('Property Feature', propertyFeatureController),
            _buildTextField('Room Count', roomCountController),
            _buildTextField('Square Meters', squareMetersController),
            _buildTextField('Rent Amount', rentAmountController),
            SizedBox(height: 16),
            GestureDetector(
              onTap: (){
                ethUtils.setRentalInfo(
                  ownerName: ownerNameController.text,
                  tenantName: tenantNameController.text,
                  propertyAddress: propertyAddressController.text,
                  propertyFeature: propertyFeatureController.text,
                  roomCount: roomCountController.text,
                  squareMeters: squareMetersController.text,
                  rentAmount: rentAmountController.text,
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Set rounded corners
                  color: Color(0xff03a8d2), // Set dark green color
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  'Kaydet',
                  style: TextStyle(
                    color: Colors.white, // Set text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
