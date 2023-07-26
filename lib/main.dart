import 'package:flutter/material.dart';
//import 'package:beautywave/home_page.dart';
import 'package:beautywave/login_page.dart';
import 'package:beautywave/register_page.dart';
import 'package:beautywave/reservaciones.dart'; // Importa la página de reservaciones

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'BeautyWave';

  @override
  Widget build(BuildContext context) {
    // Define tu color personalizado
    const Color myCustomColor = Color.fromARGB(255, 230, 195, 2);

    // Crea un MaterialColor a partir del color personalizado
    final MaterialColor myCustomSwatch = MaterialColor(
      myCustomColor.value,
      const <int, Color>{
        50: myCustomColor,
        100: myCustomColor,
        200: myCustomColor,
        300: myCustomColor,
        400: myCustomColor,
        500: myCustomColor,
        600: myCustomColor,
        700: myCustomColor,
        800: myCustomColor,
        900: myCustomColor,
      },
    );

    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:
            myCustomSwatch, // Usa el MaterialColor personalizado aquí
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const LoginPage(),
        '/register': (context) => RegisterPage(),
        '/reservaciones': (context) => const ReservacionesPage(
            userId: 0), // Actualiza el userId aquí al valor real del usuario
      },
    );
  }
}
