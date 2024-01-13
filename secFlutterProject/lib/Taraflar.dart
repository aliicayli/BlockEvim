import 'EvSahibi.dart';
import 'Kiraci.dart';

class Taraflar {
  EvSahibi evSahibi;
  Kiraci kiraci;

  Taraflar({required this.evSahibi, required this.kiraci});

  factory Taraflar.fromJson(Map<String, dynamic> json) {
    return Taraflar(
      evSahibi: EvSahibi.fromJson(json['evSahibi']),
      kiraci: Kiraci.fromJson(json['kiraci']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'evSahibi': evSahibi.toJson(),
      'kiraci': kiraci.toJson(),
    };
  }
}