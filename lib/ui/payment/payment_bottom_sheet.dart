import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/payment/payment_done.dart';

class PaymentBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final int amount;

  const PaymentBottomSheet({
    super.key,
    required this.formKey,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cvvController,
    required this.amount,
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
                    Navigator.pushNamed(context, PaymentDoneDesign.route,
                        arguments: amount);
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
