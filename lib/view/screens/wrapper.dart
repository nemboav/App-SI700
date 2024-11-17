import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_bloc.dart';
import '../../provider/user_provider.dart';
import '../navigation/bottomnavigation_layout.dart';
import 'loginpage_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WrapperState();
  }
}

class WrapperState extends State<Wrapper> {
  String? userName;

  Future<void> _loadUserName() async {
    String? name = await UserProvider.helper.getNameUserAuthenticated();
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Erro do Firebase"),
                  content: Text(state.message),
                );
              });
        }
        if (state is Authenticated) {
          _loadUserName();
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return authenticatedWidget(context, userName);
        } else {
          return unauthenticatedWidget(context);
        }
      },
    );
  }
}

Widget authenticatedWidget(BuildContext context, String? userName) {
  return BottomNavigationLayout(userName: userName);
}

Widget unauthenticatedWidget(BuildContext context) {
  return const LoginPageScreen();
}
