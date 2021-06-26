import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:profile/src/base/base_stateful.dart';
import 'package:profile/src/bloc/todo/bloc/profile_bloc.dart';
import 'package:profile/src/constants/index.dart';
import 'package:profile/src/models/profile.dart';
import 'package:profile/src/utils/index.dart';
import 'package:profile/src/widget/image_circle.dart';
import 'package:profile/src/widget/index.dart';

class AddProfilePage extends StatefulWidget {
  final Profile todoItem;
  final bool isUpdate;
  final bool readOnly;

  const AddProfilePage({
    Key key,
    this.todoItem,
    this.isUpdate = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _AddProfilePageState createState() => _AddProfilePageState();
}

class _AddProfilePageState extends BasePageState<AddProfilePage> {
  final _edtFirstNameController = TextEditingController();
  final _edtLastNameController = TextEditingController();
  final _edtBirthDayController = TextEditingController();
  final _edtAddressController = TextEditingController();
  final _edtPhoneController = TextEditingController();
  final _edtEmailController = TextEditingController();

  final _key = GlobalKey<FormState>();

  final _todoBloc = GetIt.I<ProfileBloc>();

  bool _fieldRequired = true;
  DateTime _selectedDate;
  String _gender;
  String _currentSelectedValue;
  File _imageFile;

  _selectDate({@required TextEditingController edt}) async {
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      edt
        ..text = Utils.dateFormat.format(_selectedDate)
        ..selection = TextSelection.fromPosition(
          TextPosition(
            offset: edt.text.length,
            affinity: TextAffinity.upstream,
          ),
        );
    }
  }

  @override
  void initState() {
    if ((widget.isUpdate || widget.readOnly) && widget.todoItem != null) {
      _edtFirstNameController.text = widget.todoItem.firstName;
      _edtLastNameController.text = widget.todoItem.lastName;
      _edtBirthDayController.text = widget.todoItem.birthDay;
      _edtAddressController.text = widget.todoItem.address;
      _edtPhoneController.text = widget.todoItem.phone;
      _edtEmailController.text = widget.todoItem.email;
    }
    super.initState();
  }

  @override
  void dispose() {
    _todoBloc.close();
    super.dispose();
  }

  @override
  Widget builds(BuildContext context) {
    _buildAppBarTitle() {
      if (widget.readOnly) {
        return Text("Detail");
      } else {
        return widget.isUpdate ? Text("Update") : Text("Add");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        actions: widget.readOnly
            ? null
            : [
                IconButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      if (widget.isUpdate) {
                        Profile todoItem = widget.todoItem.copyWith(
                          firstName: _edtFirstNameController.text,
                          lastName: _edtLastNameController.text,
                          birthDay: _edtBirthDayController.text,
                          address: _edtAddressController.text,
                          phone: _edtPhoneController.text,
                          email: _edtEmailController.text,
                          picture: _imageFile?.path,
                        );
                        _todoBloc.add(UpdateTodoEvent(todoItem: todoItem));
                      } else {
                        Profile todoItem = Profile(
                          firstName: _edtFirstNameController.text,
                          lastName: _edtLastNameController.text,
                          birthDay: _edtBirthDayController.text,
                          address: _edtAddressController.text,
                          phone: _edtPhoneController.text,
                          email: _edtEmailController.text,
                          picture: _imageFile?.path,
                        );
                        _todoBloc.add(AddTodoEvent(todoItem: todoItem));
                      }
                    }
                  },
                  icon: Icon(
                    Icons.save_rounded,
                  ),
                )
              ],
      ),
      body: BlocListener(
        bloc: _todoBloc,
        listener: (context, state) {
          if (state is TodoAddCompleteState ||
              state is UpdateTodoCompleteState) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: Spacing.s, right: Spacing.s),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Spacing.s),
                    child: ImageCircle(
                      initData: widget?.todoItem?.picture != null
                          ? File(widget.todoItem.picture)
                          : null,
                      onChangeImage: (file) {
                        setState(() {
                          _imageFile = file;
                        });
                      },
                    ),
                  ),
                  DefaultTextField2Line(
                    title: "First Name",
                    controller: _edtFirstNameController,
                    requires: _fieldRequired,
                    readOnly: widget.readOnly,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                  ),
                  DefaultTextField2Line(
                    title: "Last Name",
                    requires: _fieldRequired,
                    controller: _edtLastNameController,
                    readOnly: widget.readOnly,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                  ),
                  DefaultTextField2Line(
                    focusNode: AlwaysDisabledFocusNode(),
                    title: "BirthDay",
                    controller: _edtBirthDayController,
                    requires: _fieldRequired,
                    readOnly: widget.readOnly,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                    onTap: widget.readOnly
                        ? null
                        : () {
                            _selectDate(
                              edt: _edtBirthDayController,
                            );
                          },
                  ),
                  DefaultTextField2Line(
                    title: "Address",
                    controller: _edtAddressController,
                    readOnly: widget.readOnly,
                    requires: _fieldRequired,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                    maxLine: 5,
                  ),
                  DefaultTextField2Line(
                    title: "Phone",
                    requires: _fieldRequired,
                    controller: _edtPhoneController,
                    readOnly: widget.readOnly,
                    inputType: TextInputType.number,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                  ),
                  DefaultTextField2Line(
                    title: "Email",
                    requires: _fieldRequired,
                    controller: _edtEmailController,
                    readOnly: widget.readOnly,
                    inputType: TextInputType.emailAddress,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.isUpdate
          ? Padding(
              padding: EdgeInsets.only(left: Spacing.s, right: Spacing.s),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(right: Spacing.xs),
                  //     child: TextButton(
                  //       child: Text("Update"),
                  //       style: TextButton.styleFrom(
                  //         primary: Colors.white,
                  //         backgroundColor: Theme.of(context).primaryColor,
                  //       ),
                  //       onPressed: () {
                  //         _todoBloc.add(
                  //           TodoDoneEvent(todoItem: widget.todoItem),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: Text("Delete"),
                      onPressed: () {
                        _todoBloc.add(
                          TodoDeleteEvent(todoItem: widget.todoItem),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
