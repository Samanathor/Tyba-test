import 'package:flutter/material.dart';
import 'package:tyba/src/providers/transactions_provider.dart';
import 'package:tyba/src/widgets/menu.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Transaction> transactions = [];
  TransactionProvider transactionProvider = TransactionProvider();

  @override
  void initState() {
    transactionProvider.getTransactions().then((value) {
      setState(() => {transactions = value});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de transacciones"),
      ),
      drawer: menuWidget(context),
      body: SizedBox(
        height: 800,
        child: Container(
          padding: EdgeInsetsDirectional.all(20),
          child: _getList(),
        ),
      ),
    );
  }

  Widget _getList() {
    return ListView(
        children: transactions
            .map((e) => Card(
                  elevation: 10,
                  child: ListTile(
                    title: Text(e.detail),
                    subtitle: Text(e.date),
                  ),
                ))
            .toList());
  }
}
