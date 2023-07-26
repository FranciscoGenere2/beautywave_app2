import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RegisterEmpresaPage extends StatefulWidget {
  @override
  _RegisterEmpresaPageState createState() => _RegisterEmpresaPageState();
}

class _RegisterEmpresaPageState extends State<RegisterEmpresaPage> {
  final TextEditingController nombreEmpresaController = TextEditingController();
  final TextEditingController correoEmpresaController = TextEditingController();
  final TextEditingController contrasenaEmpresaController =
      TextEditingController();
  final TextEditingController confirmarContrasenaEmpresaController =
      TextEditingController();
  final TextEditingController direccionEmpresaController =
      TextEditingController();

  // Expresión regular para validar el correo electrónico
  final _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
  );

  // Expresión regular para validar la contraseña
  final _passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{6,}$');

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> register(BuildContext context) async {
    String nombreEmpresa = nombreEmpresaController.text;
    String correoEmpresa = correoEmpresaController.text;
    String contrasenaEmpresa = contrasenaEmpresaController.text;
    String confirmarContrasenaEmpresa =
        confirmarContrasenaEmpresaController.text;
    String direccionEmpresa = direccionEmpresaController.text;

    if (nombreEmpresa.isEmpty ||
        correoEmpresa.isEmpty ||
        contrasenaEmpresa.isEmpty ||
        confirmarContrasenaEmpresa.isEmpty ||
        direccionEmpresa.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Por favor, completa todos los campos',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (!_emailRegExp.hasMatch(correoEmpresa)) {
      Fluttertoast.showToast(
        msg: 'Por favor, ingresa un correo electrónico válido',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (contrasenaEmpresa != confirmarContrasenaEmpresa) {
      Fluttertoast.showToast(
        msg: 'Las contraseñas no coinciden',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (!_passwordRegExp.hasMatch(contrasenaEmpresa)) {
      Fluttertoast.showToast(
        msg:
            'La contraseña debe contener al menos una mayúscula, un número y tener al menos 6 caracteres',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    // Realizar la solicitud HTTP POST al archivo PHP
    var url = Uri.parse('http://localhost/beautywave/register_empresa.php');
    var response = await http.post(url, body: {
      'nombre_empresa': nombreEmpresa,
      'correo_empresa': correoEmpresa,
      'contrasena_empresa': contrasenaEmpresa,
      'direccion_empresa': direccionEmpresa,
    });

    if (response.statusCode == 200) {
      // Registro exitoso

      // Mostrar el Toast de registro exitoso
      Fluttertoast.showToast(
        msg: 'Registro exitoso. Inicia sesión con tu nueva cuenta de empresa.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pushReplacementNamed(context, '/');
      // No redirijas a la página de inicio de sesión (LoginPage) aquí
      // El usuario permanecerá en la página de registro después de mostrar el mensaje
    } else {
      // Error en el registro
      Fluttertoast.showToast(
        msg: 'Error en el registro. Inténtalo nuevamente.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Registro de Empresa'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.business,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Completa el formulario de registro de empresa',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nombreEmpresaController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Empresa',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: correoEmpresaController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico de la Empresa',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contrasenaEmpresaController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: confirmarContrasenaEmpresaController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: direccionEmpresaController,
                decoration: const InputDecoration(
                  labelText: 'Dirección de la Empresa',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  register(context);
                },
                child: const Text('Registrarse como empresa'),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: '¿Ya tienes una cuenta? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Inicia sesión',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/');
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
