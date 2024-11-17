import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_bloc.dart';
import 'cadastropage_screen.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _loginController;
  late TextEditingController _senhaController;
  bool _isLoginButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _senhaController = TextEditingController();

    // Adicionar um listener para verificar quando os campos de texto são alterados
    _loginController.addListener(_verifyLoginButtonEnabled);
    _senhaController.addListener(_verifyLoginButtonEnabled);
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  // Função para verificar se os campos de texto estão preenchidos
  void _verifyLoginButtonEnabled() {
    setState(() {
      _isLoginButtonEnabled =
          _loginController.text.isNotEmpty && _senhaController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(image: AssetImage('assets/images/logo.png')),
                    const Text(
                      "NATCAT",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _loginController,
                      decoration: const InputDecoration(
                        hintText: 'Usuário',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Digite um nome de usuário";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      controller: _senhaController,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.length < 6) {
                          return "A senha deve ter pelo menos 6 caracteres";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF403487),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: _isLoginButtonEnabled
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState!.save();
                                  BlocProvider.of<AuthBloc>(context).add(
                                      LoginUser(
                                          username: _loginController.text,
                                          password: _senhaController.text));
                                }
                              }
                            : null, // Desabilitar o botão se os campos não estiverem preenchidos
                        child: const Text('LOGIN'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            alignment:
                Alignment.bottomCenter, // Posicionamento no rodapé da tela
            height: 60.0, // Altura do retângulo
            decoration: const BoxDecoration(
              color: Color(0xFF403487), // Cor de fundo roxo
              borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(20.0), // Bordas arredondadas apenas no topo
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: 'Não tem conta? ',
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: 'Cadastre-se!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navegar para a tela de cadastro
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CadastroPageScreen()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
