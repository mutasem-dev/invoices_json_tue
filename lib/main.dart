import 'package:flutter/material.dart';
import 'details_page.dart';
import 'invoice.dart';
import 'invoices_page.dart';
import 'product.dart';
import 'loading.dart';

void main() {
  runApp(const MyApp());
}

List<Invoice> invoices = [];
List<Product> products = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loading',
      routes: {
        '/': (context) => InvoiceApp(),
        '/invoices_page': (context) => InvoicesPage(),
        '/details_page': (context) => DetailsPage(),
        '/loading': (context) => Loading(),
      },
    );
  }
}

class InvoiceApp extends StatefulWidget {
  const InvoiceApp({super.key});
  static int invoiceNo = 1;
  @override
  State<InvoiceApp> createState() => _InvoiceAppState();
}

TextEditingController cNameController = TextEditingController();
TextEditingController pNameController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController priceController = TextEditingController();

class _InvoiceAppState extends State<InvoiceApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (invoices.isNotEmpty) InvoiceApp.invoiceNo = invoices.last.invoiceNo + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice# ${InvoiceApp.invoiceNo}'),
      ),
      body: Column(
        children: [
          TextField(
            controller: cNameController,
            decoration: InputDecoration(
              labelText: 'Customer Name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Products: ',
                style: TextStyle(fontSize: 22),
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Product Info'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: pNameController,
                                decoration: InputDecoration(
                                  labelText: 'product name',
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: quantityController,
                                decoration: InputDecoration(
                                  labelText: 'quantity',
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                decoration: InputDecoration(
                                  labelText: 'price',
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                try {
                                  setState(() {
                                    products.add(Product(
                                        name: pNameController.text,
                                        quantity:
                                            int.parse(quantityController.text),
                                        price: double.parse(
                                            priceController.text)));
                                  });
                                  pNameController.clear();
                                  quantityController.clear();
                                  priceController.clear();
                                  Navigator.pop(context);
                                } catch (e) {
                                  SnackBar snackBar = SnackBar(
                                      content: Text(
                                          'please fill all fields correctly'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text('add')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('cancel')),
                        ],
                      ),
                    );
                  },
                  child: Text('add product')),
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.blue[200],
                  leading: Text(products[index].name),
                  title: Text('price: ${products[index].price}'),
                  subtitle: Text('quantity: ${products[index].quantity}'),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        products.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete_forever),
                  ),
                ),
              );
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    invoices.add(Invoice(
                        invoiceNo: InvoiceApp.invoiceNo,
                        cName: cNameController.text,
                        products: products));
                    InvoiceApp.invoiceNo++;
                    cNameController.clear();
                    products = [];
                    setState(() {});
                  },
                  child: Text('add invoice')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/invoices_page');
                  },
                  child: Text('show all invoices')),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
