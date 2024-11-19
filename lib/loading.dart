import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'invoice.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

Future<List<Invoice>> fetchInvoices(BuildContext context) async {
  var response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/TT8U'));
  if (response.statusCode == 200) {
    var jsonArray = jsonDecode(response.body)['invoices'] as List;
    return invoices = jsonArray.map((e) => Invoice.fromJson(e)).toList();
  }
  return [];
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchInvoices(context).then((value) {
      invoices = value;
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
