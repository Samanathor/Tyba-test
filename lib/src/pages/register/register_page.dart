import 'package:flutter/material.dart';
import 'package:tyba/src/providers/user_provider.dart';
import 'package:tyba/src/utils/alerts.dart';
import 'package:tyba/src/utils/validators.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userProvider = new UserProvider();
  String email = "";
  String password = "";
  String confirmation = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(225, 240, 250, 1),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Container(
            height: 500,
            alignment: Alignment.center,
            child: Form(
              key: formKey,
              child: Card(
                child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    children: [
                      _title(),
                      SizedBox(height: 40),
                      _emailField(),
                      SizedBox(height: 10),
                      _passwordField(),
                      SizedBox(height: 10),
                      _confirmationField(),
                      SizedBox(height: 10),
                      _buttonSubmit(context),
                      SizedBox(height: 10),
                      _login(context)
                    ]),
              ),
            ),
          ),
        ));
  }

  Center _title() {
    return Center(
      child: Text(
        "Registrate",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      onChanged: (value) => setState(() => email = value),
      validator: (value) =>
          !isEmailValid(value) ? "Por favor ingrese un email valido" : null,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Escribe Tu email",
          helperText: "ej: correo@dominio.com",
          icon: Icon(Icons.mail)),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      onChanged: (value) => setState(() => password = value),
      validator: (value) => !isPasswordValid(value)
          ? "Ingrese una contraseña válida. (Minimo 6 caracteres)"
          : null,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Escribe Tu contraseña",
          helperText: "Minimo 6 caracteres",
          icon: Icon(Icons.lock)),
    );
  }

  Widget _confirmationField() {
    return TextFormField(
      onChanged: (value) => setState(() => confirmation = value),
      validator: (value) =>
          value != password ? "Las contraseñas no coinciden" : null,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Repite Tu contraseña",
          helperText: "Escribe la contraseña anterior",
          icon: Icon(Icons.lock)),
    );
  }

  Widget _login(context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "login");
      },
      child: Row(
        children: [
          Text(
            "Ya tienes un usuario?",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 10),
          Text("Ingresa aquí"),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget _buttonSubmit(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
        child: Text(
          "Registrarme",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => {_submit(context)});
  }

  void _submit(context) async {
    if (!formKey.currentState!.validate()) return;
    await userProvider
        .newUser(email: email, password: password)
        .then((response) => {
              if (response['ok'])
                {Navigator.pushReplacementNamed(context, '/')}
              else
                {showAlert(context, response['message'])}
            });
  }
}
