import 'package:flutter/material.dart';

void showLoading(BuildContext context, String massege,
    {bool isCansellabal = true}) {
  showDialog(
      context: context,
      barrierDismissible: isCansellabal,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(massege),
              SizedBox(height: 15),
              CircularProgressIndicator()
            ],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showMassege(BuildContext context, String massege, String description,
    String posBtn, VoidCallback posAction,
    {bool isCansellabal = true, String? negBtn, VoidCallback? negAction}) {
  showDialog(
      context: context,
      barrierDismissible: isCansellabal,
      builder: (context) {
        List<Widget> Actions = [
          TextButton(onPressed: posAction, child: Text(posBtn))
        ];
        if (negBtn != null) {
          Actions.add(TextButton(onPressed: posAction, child: Text(negBtn)));
        }
        return AlertDialog(
          title: Text(massege),
          content: Text(description),
          actions: Actions,
        );
      });
}
