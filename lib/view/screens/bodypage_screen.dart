import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trabalho_01/bloc/bag_bloc.dart';

import '../../model/roupas.dart';
import '../navigation/bottomnavigation_layout.dart';

class BodyPageScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final double price;
  final String type;
  final String id;

  const BodyPageScreen({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.type,
    required this.id,
  }) : super(key: key);

  @override
  State<BodyPageScreen> createState() => _BodyPageScreenState();
}

class _BodyPageScreenState extends State<BodyPageScreen> {
  int _selectedIndex = -1;
  int _counter = 0;
  final List<String> sizes = ['S', 'M', 'L'];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BagBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.asset(
                      widget.imagePath,
                      height: 400.0,
                      width: 450.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavigationLayout(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(50.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          StoredClothes newClothe = StoredClothes(
                            id: widget.id,
                            name: widget.name,
                            image: widget.imagePath,
                            price: widget.price,
                            type: widget.type,
                            amount: _counter,
                          );
                          BlocProvider.of<BagBloc>(context)
                              .add(SubmitFavoriteEvent(clothe: newClothe));
                          BlocProvider.of<BagBloc>(context)
                              .add(GetFavoriteClotheListEvent());

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: const Color(0xff8461c5),
                              duration: const Duration(seconds: 5),
                              content: const Text(
                                  'O produto foi adicionado aos favoritos.'),
                              action: SnackBarAction(
                                onPressed: () {},
                                label: '',
                              )));
                        },
                        borderRadius: BorderRadius.circular(30.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Text(
                      'R\$ ${widget.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Cor', style: TextStyle(fontSize: 16.0)),
                  SizedBox(width: 100.0),
                  SizedBox(height: 20.0),
                  Text(
                    'Tamanho',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 30.0),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = i;
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
                                opacity: _selectedIndex == i ? 0.0 : 1.0,
                              ),
                            ),
                            if (i == 0)
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle),
                              ),
                            if (i == 1)
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    color: Color(0xff8e1b13),
                                    shape: BoxShape.circle),
                              ),
                            if (i == 2)
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              )
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(width: 50.0),
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = i;
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
                                opacity: _selectedIndex == i ? 0.0 : 1.0,
                              ),
                            ),
                            if (i == 0)
                              Container(
                                width: 25,
                                height: 22,
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'S',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            if (i == 1)
                              Container(
                                width: 25,
                                height: 22,
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'M',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            if (i == 2)
                              Container(
                                width: 25,
                                height: 22,
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'L',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    style:
                        ElevatedButton.styleFrom(shape: const CircleBorder()),
                    child: const Text('-'),
                  ),
                  Text(
                    '$_counter',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  ElevatedButton(
                      onPressed: _incrementCounter,
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      child: const Text('+')),
                  const SizedBox(width: 60.0),
                  ElevatedButton(
                    onPressed: _counter > 0
                        ? () {
                            StoredClothes newClothe = StoredClothes(
                              id: widget
                                  .id, // Firebase irá gerar um ID automático
                              name: widget.name,
                              image: widget.imagePath,
                              price: widget.price,
                              type: widget.type,
                              amount: _counter,
                            );
                            BlocProvider.of<BagBloc>(context)
                                .add(SubmitEvent(clothe: newClothe));

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: const Color(0xff8461c5),
                              duration: const Duration(seconds: 5),
                              content: const Text(
                                  'O produto foi adicionado à sacola.'),
                              action: SnackBarAction(
                                onPressed: () {},
                                label: '',
                              ),
                            ));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _counter > 0 ? const Color(0xff400d93) : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('ADICIONAR'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
