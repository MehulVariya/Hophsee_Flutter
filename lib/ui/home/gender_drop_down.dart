import 'package:flutter/material.dart';

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({Key? key});

  @override
  _GenderDropdownState createState() {
    return _GenderDropdownState();
  }
}

class _GenderDropdownState extends State<GenderDropdown> {
  String selectedGender = 'Male'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Row(
            children: [
              const Text(
                'Select Your Gender:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: selectedGender,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                items: <String>[
                  'Male',
                  'Female',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}