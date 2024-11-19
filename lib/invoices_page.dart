import 'package:flutter/material.dart';
import 'details_page.dart';
import 'main.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});
  static int customerIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All customers'),
      ),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListTile(
              onTap: () {
                InvoicesPage.customerIndex = index;
                Navigator.pushNamed(context, '/details_page');
              },
              tileColor: Colors.blue[100],
              leading: Text(
                invoices[index].cName,
                style: TextStyle(fontSize: 26),
              ),
            ),
          );
        },
      ),
    );
  }
}
