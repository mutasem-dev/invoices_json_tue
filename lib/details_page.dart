import 'package:flutter/material.dart';
import 'invoices_page.dart';
import 'main.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(invoices[InvoicesPage.customerIndex].cName),
      ),
      body: Column(children: [
        Text(
          'Products: ',
          style: TextStyle(fontSize: 25),
        ),
        Text(invoices[InvoicesPage.customerIndex].toString()),
      ]),
    );
  }
}
