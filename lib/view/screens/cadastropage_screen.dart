import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trabalho_01/bloc/profile_bloc.dart';
import '../../bloc/auth_bloc.dart';
import '../../model/user_profile.dart';

class CadastroPageScreen extends StatefulWidget {
  const CadastroPageScreen({Key? key}) : super(key: key);

  @override
  State<CadastroPageScreen> createState() => _CadastroPageScreenState();
}

class _CadastroPageScreenState extends State<CadastroPageScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final UserProfile user = UserProfile();

  final List<DropdownMenuItem<String>> _sexOptions = [
    const DropdownMenuItem(value: "Masculino", child: Text("Masculino")),
    const DropdownMenuItem(value: "Feminino", child: Text("Feminino")),
    const DropdownMenuItem(value: "Outros", child: Text("Outros")),
  ];

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Cadastro",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  cpfFormField(),
                  const SizedBox(height: 10.0),
                  emailFormField(),
                  const SizedBox(height: 10.0),
                  nameFormField(),
                  const SizedBox(height: 10.0),
                  phoneFormField(),
                  const SizedBox(height: 10.0),
                  passwordFormField(),
                  const SizedBox(height: 10.0),
                  birthFormField(),
                  const SizedBox(height: 10.0),
                  sexFormField(),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        BlocProvider.of<AuthBloc>(context)
                            .add(RegisterUser(user: user));

                        formkey.currentState!.reset();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF403487),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('CADASTRAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cpfFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'CPF',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira o CPF';
        }
        return null;
      },
      onSaved: (value) {
        user.cpf = value;
      },
    );
  }

// Função de validação para email
  Widget emailFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'E-mail',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira o e-mail';
        }
        return null;
      },
      onSaved: (value) {
        user.email = value;
      },
    );
  }

// Função de validação para nome
  Widget nameFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nome',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira o nome';
        }
        return null;
      },
      onSaved: (value) {
        user.name = value;
      },
    );
  }

// Função de validação para telefone
  Widget phoneFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Telefone',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira o telefone';
        }
        return null;
      },
      onSaved: (value) {
        user.phone = value;
      },
    );
  }

// Função de validação para password
  Widget passwordFormField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Senha',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira a senha';
        }
        return null;
      },
      onSaved: (value) {
        user.password = value;
      },
    );
  }

// Função de validação para data de nascimento
  Widget birthFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText:
            user.birth != null ? user.birth.toString() : 'Data de Nascimento',
        border: const OutlineInputBorder(),
      ),
      readOnly: true, // Impede a edição direta e a abertura do teclado
      onTap: () async {
        // Fecha o teclado virtual, se aberto
        FocusScope.of(context).requestFocus(/*new*/ FocusNode());

        // Chama o DatePickerDialog
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        // Se uma data foi escolhida, atualiza o estado
        if (pickedDate != null) {
          setState(() {
            user.birth = pickedDate;
          });
        }
      },
      validator: (value) {
        if (user.birth == null) {
          return 'Por favor, selecione uma data';
        }
        return null;
      },
    );
  }

// Função de validação para sexo
  Widget sexFormField() {
    return DropdownButtonFormField<String>(
      value: user.sex,
      hint: const Text("Selecione o sexo"),
      onChanged: (value) => setState(() => user.sex = value),
      onSaved: (value) => user.sex = value,
      validator: (value) => value == null ? 'Campo obrigatório' : null,
      items: _sexOptions,
    );
  }
}
