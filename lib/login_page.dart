import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'empresa_home_page.dart'; // Importar la página para la empresa
import 'home_page.dart';
import 'register_selection_page.dart'; // Importa la página de selección de registro

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> login() async {
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();

    if (_email.isEmpty || _password.isEmpty) {
      print('Por favor, completa todos los campos');
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost/beautywave/login.php'),
      body: {
        'correo': _email,
        'contrasena': _password,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      int userId = responseData['id'];
      int tipoUsuario = responseData['tipo_usuario'];
      if (tipoUsuario == 1) {
        print(
            'Iniciaste sesión con éxito. ID del usuario: $userId, Tipo de usuario: Empresa');
      } else {
        print(
            'Iniciaste sesión con éxito. ID del usuario: $userId, Tipo de usuario: Cliente');
      }
      if (userId != 0) {
        // Comprobar si es una cuenta de empresa o cliente
        if (tipoUsuario == 'empresa') {
          // Redirigir a la página de inicio de empresa
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmpresaHomePage(
                empresaId: userId,
              ),
            ),
          );
        } else {
          // Redirigir a la página de inicio de cliente
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                userId: userId,
              ),
            ),
          );
        }
      } else {
        print('Error al iniciar sesión. Verifica tus credenciales.');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content:
                  Text('Error al iniciar sesión. Verifica tus credenciales.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    } else {
      print('Error en la conexión con el servidor: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Iniciar sesión'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingresa tus credenciales',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                onChanged: (value) {
                  // No es necesario agregar código aquí,
                  // la validación de campos se realiza al presionar el botón.
                },
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                onChanged: (value) {
                  // No es necesario agregar código aquí,
                  // la validación de campos se realiza al presionar el botón.
                },
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: '¿No tienes una cuenta? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Regístrate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Redirigir a la página de selección de registro
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterSelectionPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
