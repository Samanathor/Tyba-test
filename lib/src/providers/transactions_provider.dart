import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:tyba/src/settings/settings.dart';

class Transaction {
  final String date;
  final String detail;
  final String userId;

  const Transaction(
      {required this.date, required this.detail, required this.userId});

  Map<String, dynamic> toJson() => {
        "date": date,
        "detail": detail,
        "userId": userId,
      };
  factory Transaction.fromJson(Map<String, dynamic> json) => new Transaction(
      date: json['date'], detail: json['detail'], userId: json['userId']);
}

class TransactionProvider {
  final userSettings = UserSettings();
  final String url =
      'https://logintest-ce392-default-rtdb.firebaseio.com/transactions.json';

  Future<Map<String, dynamic>> uploadTransaction(
      Transaction transaction) async {
    final data = {
      "date": transaction.date,
      "detail": transaction.detail,
      "userId": userSettings.userId
    };
    final response = await http.post(Uri.parse(url), body: json.encode(data));
    Map<String, dynamic> decodedResponse = json.decode(response.body);

    return {"ok": true};
  }

  Future<List<Transaction>> getTransactions() async {
    List<Transaction> responses = [];
    final response =
        await http.get(Uri.parse('$url?userId=${userSettings.userId}'));
    print('$url?userId=${userSettings.userId}');
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    if (decodedResponse == null) return [];
    decodedResponse.forEach((key, value) {
      final transactionTemp = Transaction.fromJson(value);
      if (transactionTemp.userId == userSettings.userId) {
        responses.add(transactionTemp);
      }
    });
    return responses;
  }
}
