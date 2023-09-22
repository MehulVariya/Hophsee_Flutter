import 'package:flutter/material.dart';
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
  String gender = 'Male'; // Default gender value
  String profilePhotoUrl = 'assets/pimage.png'; // Profile photo URL

  // Store the previous values for canceling changes
  String prevName = '';
  String prevLastName = '';
  String prevMobileNumber = '';
  String prevEmailAddress = '';
  String prevGender = 'Male';

  final Map<String, IconData> leadingIcons = {
    'Name': Icons.person,
    'Last Name': Icons.person,
    'Mobile Number': Icons.phone,
    'Email Address': Icons.email,
    'Gender': LineAwesomeIcons.genderless,
  };

  @override
  void initState() {
    super.initState();
    // Initialize previous values
    prevName = name;
    prevLastName = lastName;
    prevMobileNumber = mobileNumber;
    prevEmailAddress = emailAddress;
    prevGender = gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Help Me'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage(profilePhotoUrl),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Add logic to edit profile photo here
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Photo'),
            ),
            _buildEditableCard(
              context,
              'Name',
              name,
              (newValue) => setState(() => name = newValue),
            ),
            _buildEditableCard(
              context,
              'Last Name',
              lastName,
              (newValue) => setState(() => lastName = newValue),
            ),
            _buildEditableCard(
              context,
              'Mobile Number',
              mobileNumber,
              (newValue) => setState(() => mobileNumber = newValue),
            ),
            _buildEditableCard(
              context,
              'Email Address',
              emailAddress,
              (newValue) => setState(() => emailAddress = newValue),
            ),
            _buildEditableCard(
              context,
              'Gender',
              gender,
              (newValue) => setState(() => gender = newValue),
              isGenderField: true,
            ),
            ElevatedButton(
              onPressed: () {
                _showSaveAllDialog(context);
              },
              child: Text('Save All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableCard(
    BuildContext context,
    String title,
    String subtitle,
    Function(String) onEdit, {
    bool isGenderField = false,
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
        elevation: 4.0,
        child: ListTile(
          leading: Icon(
            leadingIcons[title] ?? Icons.person,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.edit),
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
            onChanged: (value) => editedValue = value,
            controller: TextEditingController(text: editedValue),
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
    BuildContext context,
    String title,
  ) async {
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
                onTap: () => Navigator.of(context).pop('Male'),
              ),
              ListTile(
                title: Text('Female'),
                onTap: () => Navigator.of(context).pop('Female'),
              ),
              ListTile(
                title: Text('Other'),
                onTap: () => Navigator.of(context).pop('Other'),
              ),
            ],
          ),
        );
      },
    );

    if (selectedGender != null) {
      setState(() => gender = selectedGender);
    }
  }

  Future<void> _showSaveAllDialog(BuildContext context) async {
    // Create a dialog to choose between saving and canceling all changes
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Save All Changes?'),
          content: Text('Do you want to save all changes?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Save
              },
              child: Text('Save All'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (result != null && result) {
      // Save button was pressed, keep the changes
      prevName = name;
      prevLastName = lastName;
      prevMobileNumber = mobileNumber;
      prevEmailAddress = emailAddress;
      prevGender = gender;
      // Add your logic to save all changes here
    } else {
      // Cancel button was pressed, restore previous values
      setState(() {
        name = prevName;
        lastName = prevLastName;
        mobileNumber = prevMobileNumber;
        emailAddress = prevEmailAddress;
        gender = prevGender;
      });
    }
  }
}
