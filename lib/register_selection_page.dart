import 'package:flutter/material.dart';
import 'package:beautywave/register_page.dart';
import 'package:beautywave/register_empresa_page.dart';

class RegisterSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: Text('Registrarse como cliente'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterEmpresaPage(),
                  ),
                );
              },
              child: Text('Registrarse como empresa'),
            ),
          ],
        ),
      ),
    );
  }
}
