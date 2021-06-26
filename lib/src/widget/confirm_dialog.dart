import 'package:flutter/material.dart';
import 'package:profile/src/models/profile.dart';

class ConfirmDialog extends StatelessWidget {
  final Profile todoItem;
  final Function onConfirm;

  const ConfirmDialog({Key key, this.todoItem, this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildAlertDialog() {
      return AlertDialog(
        title: Text("ยืนยันการลบข้อมูล"),
        content: Text("ต้องการลบ ${todoItem?.firstName} ${todoItem?.lastName}"),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("ลบ"),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("ยกเลิก"),
          ),
        ],
      );
    }

    return _buildAlertDialog();
  }
}
