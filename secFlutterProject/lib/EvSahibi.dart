class EvSahibi {
  String ad;
  String adres;
  String telefon;

  EvSahibi({required this.ad, required this.adres, required this.telefon});

  factory EvSahibi.fromJson(Map<String, dynamic> json) {
    return EvSahibi(
      ad: json['ad'],
      adres: json['adres'],
      telefon: json['telefon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ad': ad,
      'adres': adres,
      'telefon': telefon,
    };
  }
}