import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trabalho_01/model/clothes.dart';
import 'bodypage_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  //static const String routeName = '/home';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int selectedImageIndex = 0;
  final Clothes clothes = Clothes();
  Timer? _timer;

  List<ImageProvider> images = [
    const AssetImage('assets/images/promo1.jpg'),
    const AssetImage('assets/images/promo2.jpg'),
    const AssetImage('assets/images/promo3.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        selectedImageIndex = (selectedImageIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        //crollDirection: Axis.horizontal,
        child: Column(
          children: [
            //mainAxisAlignment: MainAxisAlignment.center,
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: SizedBox(
                //Container
                height: 167.0,
                width: 299.0,
                child: Image(
                  image: images[selectedImageIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(
              height: 20.0,
              width: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < images.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageIndex = i;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          Container(
                            width: 24.3,
                            height: 24.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Opacity(
                              opacity: selectedImageIndex == i ? 0.0 : 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20.0),
            // espaço pros 3 circulos

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildDataTable(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    var selected = clothes.selectedItems;

    return SingleChildScrollView(
      child: Table(
        children: List<TableRow>.generate(
          (selected.length / 3).ceil(),
          (index) => TableRow(
            children: [
              _buildTableRowItem(
                  selected[index * 3]), // garante o primeiro item
              if (index * 3 + 1 < selected.length) // garante o segundo item
                _buildTableRowItem(selected[index * 3 + 1]),
              if (index * 3 + 2 < selected.length) // garante o terceiro item
                _buildTableRowItem(selected[index * 3 + 2]),
              // se tiver menos que 3 itens um terceiro vazio e adicionado
              if (index * 3 + 2 >= selected.length) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableRowItem(Map<String, dynamic> clothe) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(75.0),
                child: Image.asset(
                  clothe["image"],
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0.0, // Adjust positioning as needed
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BodyPageScreen(
                            imagePath: clothe["image"],
                            name: clothe["name"],
                            price: clothe["price"],
                            type: clothe["type"],
                            id: clothe["id"],
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              clothe["type"],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
