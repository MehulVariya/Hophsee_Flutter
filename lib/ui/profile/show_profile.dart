import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/profile/profile_design.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShowProfileDesign extends StatefulWidget {
  @override
  _ShowProfileDesignState createState() => _ShowProfileDesignState();
}

class _ShowProfileDesignState extends State<ShowProfileDesign> {
  String name = '';
  String lastName = '';
  String mobileNumber = '';
  String emailAddress = '';
  String gender = 'Male'; // Set a default gender value

  // Define a map to associate titles with leading icons
  final Map<String, IconData> leadingIcons = {
    'Name': Icons.person,
    'Last Name': Icons.person,
    'Mobile Number': Icons.phone,
    'Email Address': Icons.email,
    'Gender': LineAwesomeIcons.genderless,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileDesign(),
                ),
                (route) => false);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        children: [
          _buildEditableCard(
            context,
            'Name',
            name,
            (newValue) {
              setState(() {
                name = newValue;
              });
            },
          ),
          _buildEditableCard(
            context,
            'Last Name',
            lastName,
            (newValue) {
              setState(() {
                lastName = newValue;
              });
            },
          ),
          _buildEditableCard(
            context,
            'Mobile Number',
            mobileNumber,
            (newValue) {
              setState(() {
                mobileNumber = newValue;
              });
            },
          ),
          _buildEditableCard(
            context,
            'Email Address',
            emailAddress,
            (newValue) {
              setState(() {
                emailAddress = newValue;
              });
            },
          ),
          _buildEditableCard(
            context,
            'Gender',
            gender,
            (newValue) {
              setState(() {
                gender = newValue;
              });
            },
            isGenderField: true, // Indicate that this is the gender field
          ),
        ],
      ),
    );
  }

  Widget _buildEditableCard(
    BuildContext context,
    String title,
    String subtitle,
    Function(String) onEdit, {
    bool isGenderField = false, // Additional parameter for the gender field
  }) {
    return GestureDetector(
      onTap: () {
        if (isGenderField) {
          _showGenderSelectionDialog(context, title);
        } else {
          _showEditDialog(context, title, subtitle, onEdit);
        }
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        elevation: 4.0,
        child: ListTile(
          leading: Icon(
            leadingIcons[title] ??
                Icons
                    .person, // Use the leading icon from the map or default to Icons.person
            color: Colors.blue,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.edit), // Edit button icon
        ),
      ),
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    String title,
    String initialValue,
    Function(String) onSave,
  ) async {
    String editedValue = initialValue;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            decoration: InputDecoration(labelText: title),
            onChanged: (value) {
              editedValue =
                  value; // Update editedValue when the text field changes
            },
            controller: TextEditingController(text: initialValue),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(editedValue);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showGenderSelectionDialog(
      BuildContext context, String title) async {
    final selectedGender = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Male'),
                onTap: () {
                  Navigator.of(context).pop('Male');
                },
              ),
              ListTile(
                title: Text('Female'),
                onTap: () {
                  Navigator.of(context).pop('Female');
                },
              ),
              ListTile(
                title: Text('Other'),
                onTap: () {
                  Navigator.of(context).pop('Other');
                },
              ),
            ],
          ),
        );
      },
    );

    if (selectedGender != null) {
      setState(() {
        gender = selectedGender;
      });
    }
  }
}

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: ShowProfileDesign(),
      ),
    );
  }
}
