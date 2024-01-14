
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sec/KiralamaSozlesmesi.dart';

import 'EvSahibi.dart';
import 'Kira.dart';
import 'Kiraci.dart';
import 'Mulkiyet.dart';
import 'Ozellikler.dart';
import 'Taraflar.dart';

class CreateContractPage extends StatelessWidget {
  CreateContractPage({super.key});

  TextEditingController evSahibiAdController = TextEditingController();
  TextEditingController evSahibiAdresController = TextEditingController();
  TextEditingController evSahibiTelefonController = TextEditingController();
  TextEditingController kiraciAdController = TextEditingController();
  TextEditingController kiraciAdresController = TextEditingController();
  TextEditingController kiraciTelefonController = TextEditingController();
  TextEditingController mulkiyetAdresController = TextEditingController();
  TextEditingController odaSayisiController = TextEditingController();
  TextEditingController metrekareController = TextEditingController();
  TextEditingController kiraBedelController = TextEditingController();
  TextEditingController odemeSikligiController = TextEditingController();
  TextEditingController odemeSekliController = TextEditingController();
  TextEditingController gecikmeCezaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Sözleşme Oluştur'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Ev Sahibi Adı', evSahibiAdController),
              _buildTextField('Ev Sahibi Adresi', evSahibiAdresController),
              _buildTextField('Ev Sahibi Telefon', evSahibiTelefonController),
              SizedBox(height: 16),
              _buildTextField('Kiracı Adı', kiraciAdController),
              _buildTextField('Kiracı Adresi', kiraciAdresController),
              _buildTextField('Kiracı Telefon', kiraciTelefonController),
              SizedBox(height: 16),
              _buildTextField('Mülkiyet Adresi', mulkiyetAdresController),
              _buildTextField('Oda Sayısı', odaSayisiController),
              _buildTextField('Metrekare', metrekareController),
              SizedBox(height: 16),
              _buildTextField('Kira Bedeli', kiraBedelController),
              _buildTextField('Ödeme Sıklığı', odemeSikligiController),
              _buildTextField('Ödeme Şekli', odemeSekliController),
              _buildTextField('Gecikme Cezası', gecikmeCezaController),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  saveContract();
                  Navigator.pop(context); // Yeni sözleşme oluşturulduktan sonra sayfadan çık
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
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

  void saveContract() {
    KiralamaSozlesmesi newContract = KiralamaSozlesmesi(
      taraflar: Taraflar(
        evSahibi: EvSahibi(
          ad: evSahibiAdController.text,
          adres: evSahibiAdresController.text,
          telefon: evSahibiTelefonController.text,
        ),
        kiraci: Kiraci(
          ad: kiraciAdController.text,
          adres: kiraciAdresController.text,
          telefon: kiraciTelefonController.text,
        ),
      ),
      mulkiyet: Mulkiyet(
        adres: mulkiyetAdresController.text,
        ozellikler: Ozellikler(
          odaSayisi: int.tryParse(odaSayisiController.text) ?? 0,
          metrekare: int.tryParse(metrekareController.text) ?? 0,
        ),
      ),
      kira: Kira(
        bedel: double.tryParse(kiraBedelController.text) ?? 0,
        odemeSikligi: odemeSikligiController.text,
        odemeSekli: odemeSekliController.text,
        gecikmeCeza: double.tryParse(gecikmeCezaController.text) ?? 0,
      ),
    );

    String newContractJson = json.encode(newContract.toJson());
    printWarning("Sözleşme:\n" + newContractJson);
  }

  void printWarning(String message) {
    final yellowColorCode = '\x1B[33m';
    final resetColorCode = '\x1B[0m';
    print('$yellowColorCode$message$resetColorCode');
  }


}