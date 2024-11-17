import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trabalho_01/bloc/profile_bloc.dart';
import 'package:trabalho_01/view/screens/wrapper.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/bag_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAiWPQiB7WaxmulOjpKaTiqKrE6utP9NkY",
      authDomain: "trabalho-mobile-2024-f171e.firebaseapp.com",
      projectId: "trabalho-mobile-2024-f171e",
      storageBucket: "trabalho-mobile-2024-f171e.appspot.com",
      messagingSenderId: "653430748614",
      appId: "1:653430748614:web:8167b30e6163b390546ec7",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ProfileBloc()..add(GetUserListEvent())),
        BlocProvider(
          create: (context) => BagBloc()..add(GetClotheListEvent()),
        ),
        BlocProvider(
          create: (context) => BagBloc()..add(GetFavoriteClotheListEvent()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Trabalho Mobile 2024',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wrapper(),
        //home: const Wrapper(),
      ),
    );
  }
}
