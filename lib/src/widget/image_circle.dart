import 'dart:io';

import 'package:flutter/material.dart';
import 'package:profile/src/constants/index.dart';
import 'package:profile/src/utils/img_util.dart';

typedef OnImageCircleChange = Function(File);

class ImageCircle extends StatefulWidget {
  final File initData;
  final OnImageCircleChange onChangeImage;

  const ImageCircle({
    Key key,
    this.onChangeImage,
    this.initData,
  }) : super(key: key);

  @override
  _ImageCircleState createState() => _ImageCircleState();
}

class _ImageCircleState extends State<ImageCircle> {
  final double avatarRadius = 72;
  final ValueNotifier<File> profilePath = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    if (widget.initData != null)
      setState(() {
        profilePath.value = widget.initData;
      });
  }

  @override
  Widget build(BuildContext context) {
    buildTakePhotoDialog({
      Function takePhoto,
      Function gallery,
    }) async {
      return await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                content: Container(
                  alignment: Alignment.center,
                  height: (MediaQuery.of(context).size.height / 2) *
                      MediaQuery.of(context).size.aspectRatio,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Please selected",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Container(
                        height: kToolbarHeight,
                        width: double.infinity,
                        child: TextButton(
                          child: Text("TakePhoto"),
                          onPressed: () => takePhoto?.call(),
                        ),
                      ),
                      Container(
                        height: kToolbarHeight,
                        width: double.infinity,
                        child: TextButton(
                          child: Text("Gallery"),
                          onPressed: () => gallery?.call(),
                        ),
                      )
                    ],
                  ),
                ),
              ));
    }

    buildAvatarEdit({ValueNotifier<File> image, Function onEdit}) {
      var _value = ValueListenableBuilder(
        valueListenable: image,
        builder: (context, value, child) {
          return CircleAvatar(
            radius: avatarRadius,
            backgroundImage:
                value is String ? NetworkImage(value) : FileImage(value),
          );
        },
      );
      return Container(
        child: Stack(
          overflow: Overflow.visible,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: <Widget>[
            _value.valueListenable.value != null
                ? _value
                : CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: AssetImage("${Assets.mockAvatar}"),
                  ),
            Positioned(
              right: -(avatarRadius / 2),
              top: 0,
              child: RawMaterialButton(
                onPressed: () => onEdit?.call(),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 8,
                ),
                shape: CircleBorder(),
                fillColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      );
    }

    // _buildCircleImage() => Container(
    //       child: Center(
    //         child: CircleAvatar(
    //           radius: 56,
    //           backgroundImage: AssetImage("${Assets.mockAvatar}"),
    //           // backgroundImage: NetworkImage(userDao.userImage == null
    //           //     ? Util.mockAvatar
    //           //     : userDao.userImage),
    //         ),
    //       ),
    //     );

    return buildAvatarEdit(
        image: profilePath,
        onEdit: () {
          buildTakePhotoDialog(takePhoto: () {
            ImageUtil.instance.getImage(takeCamera: true).then((file) {
              Navigator.of(context).pop();

              if (file != null) {
                setState(() {
                  profilePath.value = file;
                });
                widget.onChangeImage?.call(file);
              } else {
                debugPrint("Empty takePhoto");
              }
            });
          }, gallery: () {
            ImageUtil.instance.getImage().then((file) {
              Navigator.of(context).pop();

              if (file != null) {
                setState(() {
                  profilePath.value = file;
                });
                widget.onChangeImage?.call(file);
              } else {
                debugPrint("Empty gallery");
              }
            });
          });
        });
  }
}
