import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bag_bloc.dart';
import '../../model/roupas.dart';
import '../navigation/bottomnavigation_layout.dart';
import 'payment_confirmation.dart';

class BagPageScreen extends StatefulWidget {
  const BagPageScreen({Key? key}) : super(key: key);

  @override
  _BagPageScreenState createState() => _BagPageScreenState();
}

class _BagPageScreenState extends State<BagPageScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BagBloc>(context)
        .add(GetClotheListEvent()); // Disparar evento para carregar roupas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sacola",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<BagBloc, BagState>(
        builder: (context, state) {
          if (state is InsertState) {
            List<StoredClothes> clothes = state.clotheList;
            if (clothes.isEmpty) {
              return const Center(child: Text("Nenhuma roupa na sacola"));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: clothes.length,
              itemBuilder: (context, index) {
                String nomeRoupa = clothes[index].name;
                double price = clothes[index].price;
                String imageUrl = clothes[index].image;
                int quantidade = clothes[index].amount;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  title: Text(nomeRoupa),
                  subtitle: Text(price.toString()),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: const Color(0xFFEDECEC),
                    ),
                    height: 100,
                    width: 90,
                    child: Image(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantidade > 1) {
                            setState(() {
                              quantidade--;
                            });
                            clothes[index].amount = quantidade;
                            BlocProvider.of<BagBloc>(context)
                                .add(UpdateAmountEvent(clothe: clothes[index]));
                          }
                        },
                      ),
                      Text('$quantidade'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantidade++;
                          });
                          clothes[index].amount = quantidade;
                          BlocProvider.of<BagBloc>(context)
                              .add(UpdateAmountEvent(clothe: clothes[index]));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<BagBloc>(context)
                              .add(DeleteEvent(id: clothes[index].id));
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Lógica para quando o item é clicado
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BagBloc, BagState>(
        builder: (context, state) {
          if (state is InsertState) {
            double totalPrice = state.clotheList
                .fold(0, (sum, item) => sum + item.price * item.amount);
            return IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text(
                      totalPrice.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF403487),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ConfirmationPayment()),
                        );
                      },
                      child: const Text("FINALIZAR COMPRA"),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF403487),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavigationLayout(),
                          ),
                        );
                      },
                      child: const Text("CONTINUAR COMPRANDO"),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
