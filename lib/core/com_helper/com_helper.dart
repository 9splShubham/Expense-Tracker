import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/com_helper/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

alertDialog(String msg) {
  //Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //Toast.show(msg, duration: Toast.lengthShort, gravity: Toast.bottom);
  print('msg--$msg');
  print(
      'NavigatorKey.navigatorKey.currentContext--${NavigatorKey.navigatorKey.currentContext}');
  showAlertDialog(NavigatorKey.navigatorKey.currentContext!, msg);
}

showAlertDialog(BuildContext context, String msg) {
  // set up the button
  Widget okCancel = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(fontSize: AppSize.mainSize14),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(fontSize: AppSize.mainSize14),
    ),
    onPressed: () {
      // onLogout();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    title: Text(
      "Alert",
      style: TextStyle(color: Colors.blue),
    ),
    content: Text(msg),
    actions: [
      okCancel,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
