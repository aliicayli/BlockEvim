class Kira {
  double bedel;
  String odemeSikligi;
  String odemeSekli;
  double gecikmeCeza;

  Kira({required this.bedel, required this.odemeSikligi, required this.odemeSekli, required this.gecikmeCeza});

  factory Kira.fromJson(Map<String, dynamic> json) {
    return Kira(
      bedel: json['bedel'],
      odemeSikligi: json['odemeSikligi'],
      odemeSekli: json['odemeSekli'],
      gecikmeCeza: json['gecikmeCeza'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bedel': bedel,
      'odemeSikligi': odemeSikligi,
      'odemeSekli': odemeSekli,
      'gecikmeCeza': gecikmeCeza,
    };
  }
}