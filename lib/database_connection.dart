import 'package:mysql1/mysql1.dart';

class DatabaseConnection {
  static String host = 'db4free.net',
      user = 'franwave',
      password = 'franwave',
      db = 'beautywave';
  static int port = 3306;

  DatabaseConnection();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );

    try {
      var connection = await MySqlConnection.connect(settings);
      return connection;
    } catch (e) {
      print('Error de conexión a la base de datos: $e');
      throw 'No se pudo establecer la conexión a la base de datos.';
    }
  }
}
