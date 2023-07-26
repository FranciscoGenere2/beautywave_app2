import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beautywave/home_page.dart'; // Importa la página de inicio

class ReservacionesPage extends StatefulWidget {
  final int userId;

  const ReservacionesPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ReservacionesPageState createState() => _ReservacionesPageState();
}

class _ReservacionesPageState extends State<ReservacionesPage> {
  final TextEditingController _servicioController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? _selectedService;
  List<String> _services = [
    'Caoba',
    'Fade',
    'Taper',
    'Hightop Fade',
    'Desvanecido con líneas',
    'Boxeador',
    'Long Top Undercut',
    'Corte Dominicano',
  ];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  void dispose() {
    _servicioController.dispose();
    super.dispose();
  }

  Future<void> _submitReservacion() async {
    String servicio = _selectedService ?? '';
    String fechaCita = _selectedDate.toLocal().toString();
    String horaCita = _selectedTime.format(context);

    print('UserId: ${widget.userId}');
    print('Servicio: $servicio');
    print('Fecha Cita: $fechaCita');
    print('Hora Cita: $horaCita');

    final url = Uri.parse('http://localhost/beautywave/reservaciones.php');
    final response = await http.post(
      url,
      body: {
        'action': 'make_reservation',
        'user_id': widget.userId.toString(),
        'service_name': servicio,
        'selected_date': fechaCita,
        'selected_time': horaCita,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        // Reserva exitosa
        print(responseData['message']);
        _showSuccessDialog(); // Mostrar diálogo de éxito
        Future.delayed(Duration(seconds: 2), () {
          // Retraso de 2 segundos antes de redireccionar
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(userId: widget.userId)),
          );
        });
      } else {
        // Error en la reserva
        print(responseData['message']);
        // Agregar aquí cualquier manejo de errores o acciones adicionales que desees realizar en caso de un error en la reserva.
      }
    } else {
      // Error en la comunicación con el servidor
      print('Error en la comunicación con el servidor.');
      // Agregar aquí cualquier manejo de errores o acciones adicionales que desees realizar en caso de un error de comunicación.
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reservación Exitosa'),
          content: Text('Tu reserva ha sido exitosa. ¡Disfruta tu cita!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservaciones'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView to avoid overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedService,
                onChanged: (value) {
                  setState(() {
                    _selectedService = value;
                    _servicioController.text = value ?? '';
                  });
                },
                items: _services.map((String service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Selecciona un servicio',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona un servicio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectDate,
                child: Text('Seleccionar Fecha de Cita'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectTime,
                child: Text('Seleccionar Hora de Cita'),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitReservacion,
                  child: Text('Reservar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
