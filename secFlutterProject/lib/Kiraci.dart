class Kiraci {
  String ad;
  String adres;
  String telefon;

  Kiraci({required this.ad, required this.adres, required this.telefon});

  factory Kiraci.fromJson(Map<String, dynamic> json) {
    return Kiraci(
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