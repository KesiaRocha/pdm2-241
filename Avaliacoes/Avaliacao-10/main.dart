import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validação de Formulário',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Formulario(),
    );
  }
}

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dateController = TextEditingController();
  final _valueController = TextEditingController();

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) return 'Informe uma data';
    try {
      final date = DateFormat('dd-MM-yyyy').parseStrict(value);
      if (date == null) return 'Data inválida';
    } catch (e) {
      return 'Formato inválido. Use dd-MM-aaaa';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe um email';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  String? _validateCPF(String? value) {
    if (value == null || value.isEmpty) return 'Informe o CPF';
    final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}\-\d{2}$');
    if (!cpfRegex.hasMatch(value)) return 'CPF no formato xxx.xxx.xxx-xx';
    if (!_isValidCPF(value)) return 'CPF inválido';
    return null;
  }

  bool _isValidCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^\d]'), '');

    if (cpf.length != 11 || RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    List<int> numbers = cpf.split('').map(int.parse).toList();
    int sum = 0;

    for (int i = 0; i < 9; i++) sum += numbers[i] * (10 - i);
    int firstCheckDigit = sum % 11 < 2 ? 0 : 11 - (sum % 11);
    if (firstCheckDigit != numbers[9]) return false;

    sum = 0;
    for (int i = 0; i < 10; i++) sum += numbers[i] * (11 - i);
    int secondCheckDigit = sum % 11 < 2 ? 0 : 11 - (sum % 11);
    if (secondCheckDigit != numbers[10]) return false;

    return true;
  }

  String? _validateValue(String? value) {
    if (value == null || value.isEmpty) return 'Informe um valor';
    final valueRegex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!valueRegex.hasMatch(value)) return 'Valor inválido';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Validação de Formulário',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[50], // Fundo azul claro
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildTextFormField(
                    controller: _dateController,
                    labelText: 'Data (dd-mm-aaaa)',
                    keyboardType: TextInputType.datetime,
                    validator: _validateDate,
                  ),
                  SizedBox(height: 16.0),
                  _buildTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16.0),
                  _buildTextFormField(
                    controller: _cpfController,
                    labelText: 'CPF (xxx.xxx.xxx-xx)',
                    keyboardType: TextInputType.number,
                    validator: _validateCPF,
                  ),
                  SizedBox(height: 16.0),
                  _buildTextFormField(
                    controller: _valueController,
                    labelText: 'Valor (Ex: 3968.71)',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: _validateValue,
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Formulário válido!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.blue[300], // Cor do texto do botão
                      elevation: 8,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]!),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[400]!, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.all(16.0),
        labelStyle: TextStyle(color: Colors.blue[700]),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
