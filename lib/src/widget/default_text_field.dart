import 'package:flutter/material.dart';

class DefaultTextFieldForm extends StatefulWidget {
  final TextEditingController controller;
  final Function validator;
  final String labelText;
  final String hint;
  final TextInputType inputType;
  final FocusNode focusNode;
  final Function onTap;
  final int maxLine;
  final bool readOnly;

  const DefaultTextFieldForm({
    Key key,
    this.controller,
    this.labelText,
    this.validator,
    this.hint,
    this.inputType,
    this.focusNode,
    this.onTap,
    this.maxLine = 1,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _DefaultTextFieldFormState createState() => _DefaultTextFieldFormState();
}

class _DefaultTextFieldFormState extends State<DefaultTextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: Spacing.m),
      child: TextFormField(
        onTap: () {
          widget.onTap?.call();
        },
        readOnly: widget.readOnly,
        focusNode: widget.focusNode,
        keyboardType: widget.inputType,
        maxLines: widget.maxLine,
        textAlign: TextAlign.start,
        controller: widget.controller,
        autofocus: false,
        style: TextStyle(
          color: Colors.grey,
        ),
        validator: widget.validator,
        decoration: InputDecoration(
          errorStyle: TextStyle(),
          hintText: widget.hint,
          filled: true,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
