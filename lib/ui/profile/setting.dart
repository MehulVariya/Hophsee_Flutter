import 'package:flutter/material.dart';

import '../../core/utils.dart';

class SettingsPage extends StatelessWidget {
  static const route = '/setting_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              backArrow(context),
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
