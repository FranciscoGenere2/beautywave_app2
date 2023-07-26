import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  final int userId; // Agregar esta línea para almacenar el userId

  const SettingsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}
 
class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Español';
  List<String> _languages = ['Español', 'Inglés', 'Francés'];
  String? _userName; // Variable para almacenar el nombre del usuario

  final TextEditingController _newNameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  // Nueva función para obtener el nombre del usuario desde el servidor
  Future<String> _getUserName() async {
    var url = Uri.parse('http://localhost/beautywave/configuraciones.php');
    var response = await http.post(url, body: {
      'action': 'get_user_name',
      'user_id': widget.userId.toString(),
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Vuelva a iniciar sesion";
    }
  }

  @override
  void initState() {
    super.initState();
    // Llamar a _getUserName al iniciar la página
    _getUserName().then((userName) {
      setState(() {
        _userName = userName;
      });
    });
  }

  Future<void> _updateAccount() async {
    if (_formKey.currentState!.validate()) {
      // Si el formulario es válido (campos no vacíos), procede con la actualización
      String newName = _newNameController.text;
      String newPassword = _newPasswordController.text;

      // Realizar la solicitud HTTP POST al archivo PHP (configuraciones.php)
      var url = Uri.parse('http://localhost/beautywave/configuraciones.php');
      var response = await http.post(url, body: {
        'action': 'update_account',
        'user_id':
            widget.userId.toString(), // Usar el userId almacenado en widget
        'new_name': newName,
        'new_password': newPassword,
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cuenta actualizada con éxito'),
          ),
        );
        _newNameController.clear();
        _newPasswordController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Error al actualizar la cuenta. Inténtalo nuevamente.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userName != null ? '$_userName' : 'Cargando',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                const Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  title: const Text('Activar notificaciones'),
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: _toggleNotifications,
                  ),
                ),
                const Divider(),
                const Text(
                  'Idioma',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: const Text('Seleccionar Idioma'),
                  subtitle: Text(_selectedLanguage),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Seleccionar Idioma'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: _languages.map((language) {
                                return ListTile(
                                  title: Text(language),
                                  onTap: () {
                                    _changeLanguage(language);
                                    Navigator.of(context).pop();
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const Divider(),
                const Text(
                  'Otras configuraciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                ListTile(
                  title: const Text('Cambiar Nombre'),
                  subtitle: TextFormField(
                    controller: _newNameController,
                    decoration: const InputDecoration(
                      hintText: 'Nuevo nombre',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un nombre';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Cambiar Contraseña'),
                  subtitle: TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Nueva contraseña',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa una contraseña';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _updateAccount,
                    child: const Text('Guardar Cambios'),
                  ),
                ),
                const Divider(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text('Cerrar sesión'),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
