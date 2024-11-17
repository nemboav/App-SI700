import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/roupas.dart';

class ClothesProvider {
  static ClothesProvider helper = ClothesProvider._createInstance();

  ClothesProvider._createInstance();
  Dio _dio = Dio();

  String prefixUrl =
      "https://trabalho-mobile-2024-f171e-default-rtdb.firebaseio.com/bag/";
  String favoriteUrl =
      "https://trabalho-mobile-2024-f171e-default-rtdb.firebaseio.com/favorites/";
  String suffixUrl = ".json";

  //PÁGINA SACOLA
  Future<int> insertClothe(StoredClothes clothe) async {
    String? uid = await getUserUid();
    if (uid == null) throw Exception("User not authenticated");
    await _dio.post(
      prefixUrl + uid + "/" + suffixUrl,
      data: clothe.toMap(),
    );
    return 42;
  }

  Future<int> deleteClothe(id) async {
    String? uid = await getUserUid();
    if (uid == null) throw Exception("User not authenticated");
    await _dio.delete(prefixUrl + uid + "/" + id + "/" + suffixUrl);
    return 42;
  }

  Future<int> updateClotheAmount(String id, int newAmount) async {
    String? uid = await getUserUid();
    if (uid == null) throw Exception("User not authenticated");
    Map<String, dynamic> updatedData = {
      "amount": newAmount,
    };
    await _dio.patch(prefixUrl + uid + "/" + id + "/" + suffixUrl,
        data: updatedData);
    return 42; // Simulação de confirmação
  }

  Future<List<StoredClothes>> getClotheList() async {
    String? uid = await getUserUid();
    if (uid == null) throw Exception("User not authenticated");
    String localUrl = prefixUrl + uid + "/" + suffixUrl;
    Response response =
        await _dio.get(localUrl); //response vai devolver todos os dados

    List<StoredClothes> clotheCollection = [];
    response.data.forEach((key, value) {
      StoredClothes clothe = StoredClothes.fromMap(value);
      clothe.id = key;
      clotheCollection.add(clothe);
    });
    return clotheCollection;
  }

  /// PÁGINA FAVORITOS
  Future<int> insertFavoriteClothe(StoredClothes clothe) async {
    String? uid = await getUserUid();
    if (uid == null) throw Exception("User not authenticated");
    String localUrl = favoriteUrl + uid + "/" + suffixUrl;
    await _dio.post(
      localUrl,
      data: clothe.toMap(),
    );
    return 42;
  }

  Future<int> deleteFavoriteClothe(id) async {
    await _dio.delete(favoriteUrl + id + "/" + suffixUrl);
    return 42;
  }

  Future<List<StoredClothes>> getFavoriteClotheList() async {
    String? uid = await getUserUid();
    if (uid == null) throw Exception("User not authenticated");
    String localUrl = favoriteUrl + uid + "/" + suffixUrl;
    print(localUrl);
    Response response = await _dio.get(localUrl);

    List<StoredClothes> clotheFavoriteCollection = [];
    response.data.forEach((key, value) {
      StoredClothes clothe = StoredClothes.fromMap(value);
      clothe.id = key;
      clotheFavoriteCollection.add(clothe);
    });
    return clotheFavoriteCollection;
  }

  //Pegar o uid do usuário autenticado
  Future<String?> getUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      print(uid);
      return uid;
    }
    return null;
  }
}
