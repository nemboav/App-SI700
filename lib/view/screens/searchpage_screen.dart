import 'package:flutter/material.dart';
import 'package:trabalho_01/model/clothes.dart';
import 'bodypage_screen.dart';

class SearchPageScreen extends StatefulWidget {
  const SearchPageScreen({Key? key}) : super(key: key);

  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  final Clothes clothes = Clothes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDECEC),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      // Implementar ação do botão de login aqui
                    },
                    child: const Text('Tudo'),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDECEC),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      // Implementar ação do botão de login aqui
                    },
                    child: const Text('Tops'),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDECEC),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      // Implementar ação do botão de login aqui
                    },
                    child: const Text('Saias'),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDECEC),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      // Implementar ação do botão de login aqui
                    },
                    child: const Text('Calças'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildDataTable(),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    var deck = clothes.deck;
    return Expanded(
      child: ListView.builder(
        itemCount: (deck.length / 2)
            .ceil(), // Dividido por 2 para mostrar 2 itens por linha
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(child: _buildTableRowItem(deck, index * 2)),
              if (index * 2 + 1 < deck.length)
                Expanded(child: _buildTableRowItem(deck, index * 2 + 1)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTableRowItem(List<Map<String, dynamic>> deck, int index) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BodyPageScreen(
                      imagePath: deck[index]["image"],
                      name: deck[index]["name"],
                      price: deck[index]["price"],
                      type: deck[index]["type"],
                      id: deck[index]["id"],
                    ),
                  ),
                );
              });
            },
            child: Image.asset(
              deck[index]["image"],
              width: 150,
              height: 150,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            deck[index]["name"],
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            deck[index]["price"].toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SearchPageScreen(),
  ));
}
