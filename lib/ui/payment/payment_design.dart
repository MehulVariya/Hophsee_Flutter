import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/payment/payment_done.dart';

import '../appointment/appointment_screen.dart';

class PaymentDesign extends StatefulWidget {
  const PaymentDesign({
    super.key,
  });

  @override
  State<PaymentDesign> createState() => _PaymentDesignState();
}

class _PaymentDesignState extends State<PaymentDesign> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft, // Align to the top-left corner
                child: IconButton(
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppointmentScreen(),
                      ),
                    );*/
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.done,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Enter at least 5 characters';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Amount',
                          labelText: 'Amount',
                          prefixIcon: Icon(
                            Icons.currency_rupee_sharp,
                            color: Colors.green,
                          ),
                          errorStyle: TextStyle(fontSize: 14.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return PaymentBottomSheet(
                                  formKey: _formKey,
                                  cardNumberController: _cardNumberController,
                                  expiryDateController: _expiryDateController,
                                  cvvController: _cvvController);
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'PAY NOW',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;

  const PaymentBottomSheet({
    super.key,
    required this.formKey,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cvvController,
  });

  bool isCreditCardNumberValid(String input) {
    // Define a regex pattern for a valid credit card number.
    // This example assumes a 16-digit credit card number.
    final RegExp regex = RegExp(r'^\d{16}$');

    // Use the regex pattern to check if the input matches.
    return regex.hasMatch(input);
  }

  bool isExpiryDateValid(String input) {
    // Define a regex pattern for a valid expiry date in MM/YY format.
    final RegExp regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');

    // Use the regex pattern to check if the input matches.
    return regex.hasMatch(input);
  }

  bool isCVVValid(String input) {
    // Define a regex pattern for a valid CVV number (3 digits).
    final RegExp regex = RegExp(r'^\d{3}$');

    // Use the regex pattern to check if the input matches.
    return regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Portal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the card number';
                  }
                  if (!isCreditCardNumberValid(value)) {
                    return 'Invalid credit card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiry date';
                  }
                  if (!isExpiryDateValid(value)) {
                    return 'Invalid expiry date format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the CVV';
                  }
                  if (!isCVVValid(value)) {
                    return 'Invalid CVV number (3 digits required)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentDoneDesign(),
                      ),
                    );
                  }
                },
                child: const Text('Submit Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
