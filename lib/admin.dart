// ignore_for_file: prefer_const_constructors

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Generate QR'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blueGrey, Colors.white])),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child:
                    // ignore: prefer_const_literals_to_create_immutables
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      color: Colors.indigo.shade900,
                      data: _emailController.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: TextField(
                              controller: _emailController,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Establishment Name',
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        // FloatingActionButton(
                        //   child: Icon(Icons.done, size: 30),
                        //   onPressed: () => setState(() {}),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
