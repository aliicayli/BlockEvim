class Ozellikler {
  int odaSayisi;
  int metrekare;

  Ozellikler({required this.odaSayisi, required this.metrekare});

  factory Ozellikler.fromJson(Map<String, dynamic> json) {
    return Ozellikler(
      odaSayisi: json['odaSayisi'],
      metrekare: json['metrekare'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'odaSayisi': odaSayisi,
      'metrekare': metrekare,
    };
  }
}