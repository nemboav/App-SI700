class Clothes {
  final _clothes = [
    {
      "name": "Body",
      "image": "assets/images/body1.webp",
      "price": 10.0,
      "type": "Body",
      "id": "0"
    },
    {
      "name": "Calça 1",
      "image": "assets/images/calca1.webp",
      "price": 20.0,
      "type": "Calças",
      "id": "1"
    },
    {
      "name": "Calça 2",
      "image": "assets/images/calca2.webp",
      "price": 25.0,
      "type": "Calças",
      "id": "2"
    },
    {
      "name": "Calça 3",
      "image": "assets/images/calca3.webp",
      "price": 25.0,
      "type": "Calças",
      "id": "3"
    },
    {
      "name": "Calça 4",
      "image": "assets/images/calca4.webp",
      "price": 10.0,
      "type": "Calças",
      "id": "4"
    },
    {
      "name": "Camiseta 1",
      "image": "assets/images/camiseta1.webp",
      "price": 10.0,
      "type": "Camisetas",
      "id": "5"
    },
    {
      "name": "Camiseta 2",
      "image": "assets/images/camiseta2.webp",
      "price": 10.0,
      "type": "Camisetas",
      "id": "6"
    },
    {
      "name": "Camiseta 3",
      "image": "assets/images/camiseta3.webp",
      "price": 10.0,
      "type": "Camisetas",
      "id": "7"
    },
    {
      "name": "Moletom 1",
      "image": "assets/images/moletom1.webp",
      "price": 10,
      "type": "Moletons",
      "id": "8"
    },
    {
      "name": "Moletom 2",
      "image": "assets/images/moletom2.webp",
      "price": 10.0,
      "type": "Moletons",
      "id": "9"
    },
    {
      "name": "Saia 1",
      "image": "assets/images/saia1.webp",
      "price": 10.0,
      "type": "Saias",
      "id": "10"
    },
    {
      "name": "Saia 2",
      "image": "assets/images/saia2.webp",
      "price": 10.0,
      "type": "Saias",
      "id": "11"
    },
    {
      "name": "Top 1",
      "image": "assets/images/top1.webp",
      "price": 10.0,
      "type": "Tops",
      "id": "12"
    },
    {
      "name": "Top 2",
      "image": "assets/images/top2.webp",
      "price": 10.0,
      "type": "Tops",
      "id": "13"
    },
    {
      "name": "Top 3",
      "image": "assets/images/top3.webp",
      "price": 10.0,
      "type": 'Tops',
      "id": "14"
    },
    {
      "name": "Vestido 1",
      "image": "assets/images/vestido1.webp",
      "price": 10.0,
      "type": "Vestidos",
      "id": "15"
    },
    {
      "name": "Vestido 2",
      "image": "assets/images/vestido2.webp",
      "price": 10.0,
      "type": "Vestidos",
      "id": "16"
    },
  ];

  List<Map<String, dynamic>> get deck {
    return _clothes;
  }

  String getImagePath(int index) {
    return _clothes[index]["image"] as String;
  }

  double getPrice(int index) {
    return _clothes[index]["price"] as double;
  }

  String getName(int index) {
    return _clothes[index]["name"] as String;
  }

  String getImageType(int index) {
    return _clothes[index]["type"] as String;
  }

  String getId(int index) {
    return _clothes[index]["id"] as String;
  }

  List<Map<String, dynamic>> get selectedItems {
    var filteredList = _clothes.where((item) => [
          "Body",
          "Moletons",
          "Calças",
          "Vestidos",
          "Camisetas",
          "Tops",
          //"Saias",
        ].contains(item["type"]));

    var selected = <Map<String, dynamic>>[];

    for (var item in filteredList) {
      if (selected
          .any((selectedItem) => selectedItem["type"] == item["type"])) {
        continue;
      }
      selected.add(item);
    }

    return selected;
  }
}
