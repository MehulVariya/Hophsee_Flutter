import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Notifications'),
              subtitle: Text('Enable or disable notifications'),
              trailing: Switch(
                value: true, // You can change this based on user preference
                onChanged: (bool value) {
                  // Handle the switch change
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Dark Mode'),
              subtitle: Text('Enable or disable dark mode'),
              trailing: Switch(
                value: false, // You can change this based on user preference
                onChanged: (bool value) {
                  // Handle the switch change
                },
              ),
            ),
            Divider(),
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            Divider(),
            ListTile(
              title: Text('Log Out'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Log out user
              },
            ),
          ],
        ),
      ),
    );
  }
}
