import 'Ozellikler.dart';

class Mulkiyet {
  String adres;
  Ozellikler ozellikler;

  Mulkiyet({required this.adres, required this.ozellikler});

  factory Mulkiyet.fromJson(Map<String, dynamic> json) {
    return Mulkiyet(
      adres: json['adres'],
      ozellikler: Ozellikler.fromJson(json['ozellikler']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adres': adres,
      'ozellikler': ozellikler.toJson(),
    };
  }
}