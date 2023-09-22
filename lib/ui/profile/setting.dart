import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Help Me'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
            ],
          ),
        ),
      ),
    );
  }
}
