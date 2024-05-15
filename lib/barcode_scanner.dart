import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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

    DocumentSnapshot documentSnapshot = await _firestore.collection('Swift').doc("Products").collection("ProductDetails").doc(barcodeScanResult).get();

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
      ),
      body: Center(
        //After UI is ready fetch data field by field and print
        child: documentData != {}
          ?(documentData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Name: ${documentData['Name']}'),
                  Text('Description: ${documentData['Description']}'),
                  Text('Price: ${documentData['Price']}'),
                ],
              )
            : Text('Item was not found'))
          :Text(""),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcode,
        child: Icon(Icons.camera),
      ),
    );
  }
}