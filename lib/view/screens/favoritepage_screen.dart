import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bag_bloc.dart';
import '../../model/roupas.dart';

class FavoritePageScreen extends StatefulWidget {
  const FavoritePageScreen({Key? key}) : super(key: key);

  @override
  _FavoritePageScreenState createState() => _FavoritePageScreenState();
}

class _FavoritePageScreenState extends State<FavoritePageScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BagBloc>(context).add(GetFavoriteClotheListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favoritos",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<BagBloc, BagState>(
        builder: (context, state) {
          if (state is InsertState) {
            List<StoredClothes> favoriteClothes = state.favoriteClotheList;
            if (favoriteClothes.isEmpty) {
              return const Center(
                child: Text('Sem roupas favoritas'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: favoriteClothes.length,
              itemBuilder: (context, index) {
                StoredClothes clothes = favoriteClothes[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  title: Text(clothes.name),
                  subtitle: Text(clothes.price.toString()),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: const Color(0xFFEDECEC),
                    ),
                    height: 100,
                    width: 90,
                    child: Image.asset(
                      clothes.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF403487),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 8.0),
                    ),
                    onPressed: () {
                      StoredClothes newClothe = StoredClothes(
                        id: clothes.id,
                        name: clothes.name,
                        image: clothes.image,
                        price: clothes.price,
                        type: clothes.type,
                        amount: 1, // Defina a quantidade conforme necessário
                      );
                      BlocProvider.of<BagBloc>(context)
                          .add(SubmitEvent(clothe: newClothe));

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: const Color(0xff8461c5),
                        duration: const Duration(seconds: 5),
                        content:
                            const Text('O produto foi adicionado à sacola.'),
                        action: SnackBarAction(
                          onPressed: () {},
                          label: '',
                        ),
                      ));
                    },
                    child: const Text("ADICIONAR"),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
