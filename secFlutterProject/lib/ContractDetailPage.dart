import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'KiralamaSozlesmesi.dart';

class ContractDetailPage extends StatelessWidget {
  final KiralamaSozlesmesi contract;

  ContractDetailPage({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sözleşme Detayı'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ev Sahibi: ${contract.taraflar.evSahibi.ad}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Kiracı: ${contract.taraflar.kiraci.ad}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Mülk Bilgileri', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            Text('Adres: ${contract.mulkiyet.adres}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Oda Sayısı: ${contract.mulkiyet.ozellikler.odaSayisi}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Metrekare: ${contract.mulkiyet.ozellikler.metrekare} m²', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Kira Bilgileri', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            Text('Kira Bedeli: ${contract.kira.bedel} TL', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Ödeme Sıklığı: ${contract.kira.odemeSikligi}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Ödeme Şekli: ${contract.kira.odemeSekli}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Gecikme Cezası: ${contract.kira.gecikmeCeza} TL', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Taraflar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            Text('Ev Sahibi Adı: ${contract.taraflar.evSahibi.ad}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Ev Sahibi Adresi: ${contract.taraflar.evSahibi.adres}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Ev Sahibi Telefon: ${contract.taraflar.evSahibi.telefon}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text('Kiracı Adı: ${contract.taraflar.kiraci.ad}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Kiracı Adresi: ${contract.taraflar.kiraci.adres}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Kiracı Telefon: ${contract.taraflar.kiraci.telefon}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}