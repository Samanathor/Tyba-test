import 'package:flutter/material.dart';
import 'package:tyba/src/providers/user_provider.dart';
import 'package:tyba/src/utils/alerts.dart';
import 'package:tyba/src/utils/validators.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userProvider = UserProvider();
  final formKey = GlobalKey<FormState>();
  String user = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(225, 240, 250, 1),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Container(
            height: 390,
            alignment: Alignment.center,
            child: Form(
              key: formKey,
              child: Card(
                child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    children: [
                      _title(),
                      SizedBox(height: 20),
                      _userTextInput(),
                      SizedBox(height: 20),
                      _passwordTextInput(),
                      SizedBox(height: 20),
                      _buttonSubmit(context),
                      SizedBox(height: 20),
                      _register(context)
                    ]),
              ),
            ),
          ),
        ));
  }

  Center _title() {
    return Center(
      child: Text(
        "Iniciar Sesión",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    userProvider.login(user, password).then((response) => {
          if (response['ok'])
            {Navigator.pushReplacementNamed(context, '/')}
          else
            {showAlert(context, response['message'])}
        });
  }

  Widget _userTextInput() {
    return TextFormField(
      onChanged: (value) => setState(() {
        user = value;
      }),
      validator: (value) =>
          !isEmailValid(value) ? "Por favor ingrese un correo válido" : null,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Escribe Tu correo electrónico",
          helperText: "ej: correo@dominio.com",
          icon: Icon(Icons.account_circle)),
    );
  }

  Widget _passwordTextInput() {
    return TextFormField(
      onChanged: (value) => setState(() {
        password = value;
      }),
      validator: (value) =>
          value!.isEmpty ? "Por favor ingrese su contraseña" : null,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Escribe Tu contraseña",
          helperText: "Ten en cuenta las mayusculas",
          icon: Icon(Icons.lock)),
    );
  }

  Widget _buttonSubmit(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
        child: Text(
          "Iniciar Sesión",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => {_submitForm(context)});
  }

  Widget _register(context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "register");
      },
      child: Row(
        children: [
          Text(
            "No tienes usuario aún?",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 10),
          Text("Registrate aquí"),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
