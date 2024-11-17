import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trabalho_01/bloc/bag_bloc.dart';
import 'package:trabalho_01/provider/user_provider.dart';
import '../../bloc/auth_bloc.dart';
import '../screens/bagpage_screen.dart';
import '../screens/loginpage_screen.dart';
import '../screens/home_screen.dart';
import '../screens/favoritepage_screen.dart';
import '../screens/searchpage_screen.dart';

class BottomNavigationLayout extends StatefulWidget {
  final String? userName;

  const BottomNavigationLayout({Key? key, this.userName}) : super(key: key);

  @override
  State<BottomNavigationLayout> createState() => _BottomNavigationLayoutState();
}

class _BottomNavigationLayoutState extends State<BottomNavigationLayout> {
  int _currentScreen = 0; // indice da tela selecionada
  String? userNameAux;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    String? name = await UserProvider.helper.getNameUserAuthenticated();
    setState(() {
      userNameAux = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        title: Text('Olá, ${widget.userName ?? userNameAux}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag, color: Color(0xffa8a8a8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BagPageScreen()),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: IndexedStack(
          index: _currentScreen, //index: 1 - o numero muda a pagina
          children: const [
            HomePageScreen(),
            SearchPageScreen(),
            FavoritePageScreen(),
            LoginPageScreen(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: '',
          ),
        ],
        onTap: (value) {
          if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoritePageScreen(),
              ),
            );
          } else if (value == 3) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Sair da Conta"),
                  content:
                      const Text("Tem certeza que deseja sair da sua conta?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha a caixa de diálogo
                      },
                      child: const Text("Não"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<AuthBloc>(context).add(Logout());
                        BlocProvider.of<BagBloc>(context)
                            .add(ClearClotheListEvent());
                        BlocProvider.of<BagBloc>(context)
                            .add(ClearFavoriteClotheListEvent());
                      },
                      child: const Text("Sim"),
                    ),
                  ],
                );
              },
            );
          } else {
            setState(() {
              _currentScreen = value;
            });
          }
        },
        currentIndex: _currentScreen,
        unselectedItemColor: const Color(0xffa8a8a8),
        selectedItemColor: const Color(0xFF403487),
      ),
    );
  }
}
