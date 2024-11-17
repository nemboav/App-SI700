// Classe user
class UserProfile {
  String? cpf;
  String? email;
  String? name;
  String? phone;
  String? password;
  DateTime? birth; // usado para representar datas e horas
  String? sex;
  String? uid;

  // Construtor da classe user
  UserProfile({
    this.cpf,
    this.email,
    this.name,
    this.phone,
    this.password,
    this.birth,
    this.sex,
    this.uid,
  });

  UserProfile.fromMap(Map<String, dynamic> map)
      : cpf = map['cpf'],
        email = map['email'],
        name = map['name'],
        phone = map['phone'],
        password = map['password'],
        birth = map['birth'] != null ? DateTime.parse(map['birth']) : null,
        sex = map['sex'];

  toMap() {
    var map = <String, dynamic>{};
    map["cpf"] = cpf;
    map["email"] = email;
    map["name"] = name;
    map["phone"] = phone;
    map["password"] = password;
    map["birth"] = birth?.toIso8601String();
    map["sex"] = sex;
    return map;
  }
}
