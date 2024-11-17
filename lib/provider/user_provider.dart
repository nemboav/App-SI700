import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho_01/model/user_profile.dart';

class UserProvider {
  static UserProvider helper = UserProvider._createInstance();

  UserProvider._createInstance();
  final Dio _dio = Dio();

  String prefixUrl =
      "https://trabalho-mobile-2024-f171e-default-rtdb.firebaseio.com/users/";
  String suffixUrl = ".json";

  Future<UserProfile> getUser(cpf) async {
    Response response = await _dio.get(prefixUrl + cpf + "/" + suffixUrl);
    return UserProfile.fromMap(response.data);
  }

  //o response.data é o map

  Future<int> insertUser(UserProfile userProfile) async {
    String localUrl = prefixUrl + userProfile.uid! + "/" + suffixUrl;
    await _dio.put(
      localUrl,
      data: userProfile.toMap(),
    );
    return 42;
  }

  Future<int> deletetUser(cpf) async {
    await _dio.delete(prefixUrl + cpf + "/" + suffixUrl);
    return 42;
  }

  Future<int> updatetUser(cpf, UserProfile userProfile) async {
    await _dio.put(prefixUrl + cpf + "/" + suffixUrl,
        data: userProfile.toMap());
    return 42;
  }

  Future<List<UserProfile>> getUserList() async {
    Response response = await _dio
        .get(prefixUrl + suffixUrl); //responde vai devolver todos os dados

    List<UserProfile> userCollection = [];

    response.data.forEach((key, value) {
      //colocando key passa a iterar sobre um dicionario
      UserProfile userProfile = UserProfile.fromMap(value);
      userProfile.cpf = key;
      //UserCollection.insertUserOfId(value["id"].toString(), User);

      userCollection.add(userProfile);
    });
    return userCollection;
  }

  Future<String?> getNameUserAuthenticated() async {
    User? user = FirebaseAuth.instance.currentUser;

    // Loop enquanto o usuário for nulo
    while (user == null) {
      await Future.delayed(Duration(
          seconds: 1)); // Espera 1 segundo antes de verificar novamente
      user = FirebaseAuth.instance.currentUser;
    }

    // Quando o usuário não for mais nulo, obtemos o nome
    String uid = user.uid;
    String localUrl = prefixUrl + uid + "/" + suffixUrl;
    Response response = await _dio.get(localUrl);
    UserProfile userProfile = UserProfile.fromMap(response.data);
    return userProfile.name;
  }
}
