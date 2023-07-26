import 'package:flutter/material.dart';

class EmpresaHomePage extends StatefulWidget {
  final int empresaId; // Agregar esta línea para almacenar el empresaId

  const EmpresaHomePage({Key? key, required this.empresaId}) : super(key: key);

  @override
  _EmpresaHomePageState createState() => _EmpresaHomePageState();
}

class _EmpresaHomePageState extends State<EmpresaHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de inicio de empresa'),
      ),
      body: Center(
        child: Text('ID de la empresa: ${widget.empresaId}'),
      ),
    );
  }
}
