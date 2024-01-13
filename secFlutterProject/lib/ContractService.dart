import 'KiralamaSozlesmesi.dart';

class ContractService {
  // JSON verileri listesi
  final List<Map<String, dynamic>> jsonContracts = [
    {
      "taraflar": {
        "evSahibi": {"ad": "Ahmet Yılmaz", "adres": "Örnek Mahalle, Örnek Sokak No: 123", "telefon": "5551234567"},
        "kiraci": {"ad": "Ayşe Demir", "adres": "Başka Mahalle, Başka Sokak No: 456", "telefon": "5557654321"}
      },
      "mulkiyet": {"adres": "Örnek Mahalle, Örnek Sokak No: 123", "ozellikler": {"odaSayisi": 2, "metrekare": 75}},
      "kira": {"bedel": 1500.0, "odemeSikligi": "aylik", "odemeSekli": "bankaHavalesi", "gecikmeCeza": 50.0},
    },

    {
      "taraflar": {
        "evSahibi": {"ad": "Zehra Karahan", "adres": "Merkez Mahalle, Ana Cadde No: 789", "telefon": "5559876543"},
        "kiraci": {"ad": "Mehmet Yıldırım", "adres": "Yeni Mahalle, Yeni Sokak No: 321", "telefon": "5554567890"}
      },
      "mulkiyet": {"adres": "Merkez Mahalle, Ana Cadde No: 789", "ozellikler": {"odaSayisi": 1, "metrekare": 50}},
      "kira": {"bedel": 1200.0, "odemeSikligi": "haftalik", "odemeSekli": "nakit", "gecikmeCeza": 30.0},
    },

    {
      "taraflar": {
        "evSahibi": {"ad": "Hüseyin Aksoy", "adres": "Orman Mahalle, Orman Sokak No: 555", "telefon": "5551112233"},
        "kiraci": {"ad": "Fatma Aydın", "adres": "Dağ Mahalle, Dağ Sokak No: 777", "telefon": "5553344556"}
      },
      "mulkiyet": {"adres": "Orman Mahalle, Orman Sokak No: 555", "ozellikler": {"odaSayisi": 3, "metrekare": 90}},
      "kira": {"bedel": 1800.0, "odemeSikligi": "aylik", "odemeSekli": "bankaHavalesi", "gecikmeCeza": 60.0},
    },
  ];

  List<KiralamaSozlesmesi> getContracts() {
    List<KiralamaSozlesmesi> contracts = [];

    for (var jsonContract in jsonContracts) {
      contracts.add(KiralamaSozlesmesi.fromJson(jsonContract));
    }

    return contracts;
  }
}
