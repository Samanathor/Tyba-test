import 'package:flutter/material.dart';
import 'package:tyba/src/providers/user_provider.dart';

Widget menuWidget(BuildContext context) {
  final userProvider = UserProvider();

  void _closeSession(BuildContext context) {
    userProvider.logoutAuth();
    Navigator.pushReplacementNamed(context, 'login');
  }

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Container(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
        ),
        ListTile(
          leading: Icon(Icons.search, color: Colors.blue),
          title: Text('Buscador de restaurantes'),
          onTap: () => {Navigator.pushReplacementNamed(context, '/')},
        ),
        ListTile(
          leading: Icon(Icons.history, color: Colors.blue),
          title: Text('Historial de transacciones'),
          onTap: () => {Navigator.pushReplacementNamed(context, 'history')},
        ),
        ListTile(
          leading: Icon(Icons.pages, color: Colors.blue),
          title: Text('Cerrar sesión'),
          onTap: () => {_closeSession(context)},
        )
      ],
    ),
  );
}
