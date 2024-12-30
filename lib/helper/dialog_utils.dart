import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(),
              Text(
                'Loading.....',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  static void closeLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
    BuildContext context, {
    String title = 'Title',
    required String message,
    String? posActionTitle,
    VoidCallback? posAction,
    String? negActionTitle,
    VoidCallback? negAction,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        List<Widget> actions = [];
        if (posActionTitle != null) {
          actions.add(
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  posAction?.call();
                },
                child: Text(posActionTitle)),
          );
        }
        if (negActionTitle != null) {
          actions.add(
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  negAction?.call();
                },
                child: Text(negActionTitle)),
          );
        }
        return AlertDialog(
          title: Text(
            title,
          ),
          actions: actions,
          content: Text(message),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          contentTextStyle: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}
