import 'package:flutter/material.dart';
import '../navigation/bottomnavigation_layout.dart';

class ConfirmationPayment extends StatefulWidget {
  const ConfirmationPayment({Key? key}) : super(key: key);

  @override
  State<ConfirmationPayment> createState() => _ConfirmationPaymentState();
}

class _ConfirmationPaymentState extends State<ConfirmationPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/confirmacaopagamento.png',
                height: 300, width: 300),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // voltar para o pedido
                Navigator.pop(context); // fecha o bottom sheet
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF403487)),
              child: const Text('VER DETALHES DO PEDIDO'),
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () {
                // voltar para a pagina com as roupas
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigationLayout()),
                ); // fecha o bottom sheet
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF403487),
                  foregroundColor: Colors.white),
              child: const Text(
                'CONTINUAR COMPRANDO',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
