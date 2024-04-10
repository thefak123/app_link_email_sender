import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomAlertDialog {
  Future<void> showMessageDialog(
      {required String title,
      required String description,
      required BuildContext ctx}) {
        
    return showDialog(
        context: ctx,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  Future<void> confirmationDialog(
      {required String title,
      required String description,
      required Function yesFunction,
      required BuildContext ctx}) {
        
    return showDialog(
        context: ctx,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  yesFunction();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
