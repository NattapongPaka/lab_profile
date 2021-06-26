import 'dart:io';

import 'package:flutter/material.dart';
import 'package:profile/src/constants/index.dart';
import 'package:profile/src/utils/index.dart';

class TodoListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showDelete;
  final Function onTap;
  final Function onDelete;
  final String picture;

  const TodoListTile({
    Key key,
    this.title,
    this.subTitle,
    this.onTap,
    this.showDelete = false,
    this.onDelete,
    this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildListTile({String title, String sub}) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: picture != null
              ? FileImage(File(picture))
              : AssetImage(Assets.mockAvatar),
        ),
        title: Text(
          "$title",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          "$sub",
          style: Theme.of(context).textTheme.caption,
        ),
        contentPadding: EdgeInsets.only(left: Spacing.xs),
        onTap: () {
          onTap?.call();
        },
        trailing: showDelete
            ? IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  onDelete?.call();
                },
              )
            : null,
      );
    }

    return _buildListTile(title: title, sub: subTitle);
  }
}
