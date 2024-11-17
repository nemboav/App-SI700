class StoredClothes {
  String id;
  String name;
  String image;
  double price;
  String type;
  int amount;

  StoredClothes(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.type,
      required this.amount});

  factory StoredClothes.fromMap(Map<String, dynamic> map) {
    return StoredClothes(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      type: map['type'],
      amount: map['amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'type': type,
      'amount': amount,
    };
  }
}
