import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:map_project/homepage.dart';
import 'package:map_project/models/cartModel.dart';
import 'package:map_project/models/productModel.dart';
import 'package:map_project/services/toast.dart';
import 'package:provider/provider.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BarcodeScanner extends StatefulWidget {
  @override
  _BarcodeScanner createState() => _BarcodeScanner();
}

class _BarcodeScanner extends State<BarcodeScanner> {
  String barcode = '';
  Map<String, dynamic> documentData = {};

  Future<void> scanBarcode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    DocumentSnapshot documentSnapshot = await _firestore
        .collection('Swift')
        .doc("Products")
        .collection("ProductDetails")
        .doc(barcodeScanResult)
        .get();

    if (documentSnapshot.exists) {
      setState(() {
        documentData = documentSnapshot.data() as Map<String, dynamic>;
      });
    } else {
      setState(() {
        documentData = {'Error': 'Document does not exist'};
      });
    }

    setState(() {
      barcode = barcodeScanResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          },
        ),
        backgroundColor: Colors.orange, // Set the AppBar color to orange
        centerTitle: true, // Center the title
        elevation: 10.0, // Add some shadow
      ),
      body: Column(
        children: [
          Center(
            //After UI is ready fetch data field by field and print
            child: documentData != {}
                ? (documentData.isNotEmpty
                    ? Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              // Set the height of the image
                              width:
                                  double.infinity, // Set the width of the image
                              child: Image.network(
                                documentData['imageUrl'],
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to maintain the aspect ratio of the image
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Name: ${documentData['Name']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Description: ${documentData['Description']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Price: ${documentData['Price']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('Available: ${documentData['inStock']}'),
                            ),
                          ],
                        ),
                      )
                    : Text('Item was not found'))
                : Text(""),
          ),
          ElevatedButton(
            onPressed: () {
              final product = Product(
                name: documentData['Name'],
                description: documentData['Description'],
                price: documentData['Price'],
                imageUrl: documentData['imageUrl'],
              );
              Provider.of<Cart>(context, listen: false).addProduct(product);
              showToast(message: "Product added to the cart.");
            },
            child: Text('Add to cart'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcode,
        child: Icon(Icons.camera),
      ),
    );
  }
}
