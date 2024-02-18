import 'package:flutter/material.dart';

class ProcessNotificationService {
  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.greenAccent, content: Text(message)),
    );
  }

  static void warning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text(message),
    ));
  }

  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.redAccent, content: Text(message)),
    );
  }

  static startLoading(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.9), // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(
          milliseconds:
              400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        return SizedBox.expand(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                    width: 85,
                    height: 85,
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.blueGrey, strokeWidth: 10)),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.blueGrey),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
