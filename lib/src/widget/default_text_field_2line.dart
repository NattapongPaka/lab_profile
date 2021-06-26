import 'package:flutter/material.dart';
import 'package:profile/src/utils/index.dart';

import 'package:profile/src/widget/default_text_field.dart';
import 'package:profile/src/constants/index.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class DefaultTextField2Line extends StatefulWidget {
  final String title;
  final bool requires;
  final TextEditingController controller;
  final double paddingBottom;
  final Function validator;
  final TextInputType inputType;
  final FocusNode focusNode;
  final Function onTap;
  final int maxLine;
  final bool readOnly;

  const DefaultTextField2Line({
    Key key,
    @required this.title,
    this.requires = false,
    this.controller,
    this.paddingBottom,
    this.validator,
    this.inputType,
    this.focusNode,
    this.onTap,
    this.maxLine,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _DefaultTextField2LineState createState() => _DefaultTextField2LineState();
}

class _DefaultTextField2LineState extends State<DefaultTextField2Line> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Spacing.m,
        ),
        Text(
          "${widget.title}${widget.requires ? '*' : ''}",
        ).addAlignCenterLeft(),
        DefaultTextFieldForm(
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          controller: widget.controller,
          validator: widget.validator,
          inputType: widget.inputType,
          maxLine: widget.maxLine,
          readOnly: widget.readOnly,
        ),
        Visibility(
          visible: widget.paddingBottom != null,
          child: SizedBox(
            height: widget.paddingBottom,
          ),
        ),
      ],
    );
  }
}

// class CounterFormField<T> extends FormField<T> {

//   CounterFormField({
//     FormFieldSetter<T> onSaved,
//     FormFieldValidator<T> validator,
//     T initialValue,
//     bool autovalidate = false
//   }) : super(

//     onSaved: onSaved,
//     validator: validator,
//     initialValue: initialValue,
//     autovalidate: autovalidate,
//     builder: (FormFieldState<T> state) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.remove),
//             onPressed: () {
//               state.didChange(state.value);
//             },
//           ),
//           Text(
//             state.value.toString()
//           ),
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               state.didChange(state.value);
//             },
//           ),
//         ],
//       );
//     }
//   );
// }
