import 'package:flutter/material.dart';

class MyDialog {
  Future<Null> normalDialog(
      BuildContext context, String title, String messasge) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Icon(Icons.wrong_location),
          title: Text(title),
          subtitle: Text(messasge),
        ),actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }
}
