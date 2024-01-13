import 'Kira.dart';
import 'Mulkiyet.dart';
import 'Taraflar.dart';

class KiralamaSozlesmesi {
  Taraflar taraflar;
  Mulkiyet mulkiyet;
  Kira kira;

  KiralamaSozlesmesi({required this.taraflar, required this.mulkiyet, required this.kira});

  factory KiralamaSozlesmesi.fromJson(Map<String, dynamic> json) {
    return KiralamaSozlesmesi(
      taraflar: Taraflar.fromJson(json['taraflar']),
      mulkiyet: Mulkiyet.fromJson(json['mulkiyet']),
      kira: Kira.fromJson(json['kira']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taraflar': taraflar.toJson(),
      'mulkiyet': mulkiyet.toJson(),
      'kira': kira.toJson(),
    };
  }
}