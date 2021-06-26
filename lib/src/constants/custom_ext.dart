import 'package:flutter/material.dart';
import 'package:profile/src/utils/index.dart';

extension ExtendedText on Widget {
  addAlignCenter({EdgeInsets padding}) {
    return Container(
      padding: padding,
      alignment: Alignment.center,
      child: this,
    );
  }

  addAlignCenterLeft() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  addAlignCenterRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  addContainerPadding(EdgeInsetsGeometry padding) {
    return Container(child: this, padding: padding);
  }

  addContainerPaddingBottom() {
    return Container(
      alignment: Alignment.centerLeft,
      child: this,
      margin: EdgeInsets.only(
        bottom: Spacing.s,
      ),
    );
  }

  // addContainerMarginBottom() {
  //   return Container(
  //     child: this,
  //     margin: EdgeInsets.only(
  //       top: Spacing.xs,
  //       left: Spacing.xs,
  //       right: Spacing.xs,
  //       bottom: Platform.isIOS ? kToolbarHeight : Spacing.xs,
  //     ),
  //   );
  // }
}
