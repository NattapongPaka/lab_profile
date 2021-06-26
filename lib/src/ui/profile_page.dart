import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:profile/src/bloc/todo/bloc/profile_bloc.dart';
import 'package:profile/src/models/profile.dart';
import 'package:profile/src/routes.dart';
import 'package:profile/src/ui/index.dart';
import 'package:profile/src/utils/index.dart';
import 'package:profile/src/widget/index.dart';

class ProfilePage extends StatefulWidget {
  final TextEditingController textSearchController;
  const ProfilePage({
    Key key,
    this.textSearchController,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with RouteAware, RouteObserverMixin {
  final _todoBloc = GetIt.I<ProfileBloc>();

  @override
  void initState() {
    _todoBloc.add(GetTodoAllEvent());
    super.initState();
    debugPrint("TodoInit");
    widget.textSearchController.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _todoBloc.close();
    super.dispose();
  }

  @override
  void didPopNext() {
    _todoBloc.add(GetTodoAllEvent());
  }

  _onTextChange() {
    if (widget.textSearchController.text.length > 2) {
      _todoBloc.add(
        SearchEvent(
          searchText: widget.textSearchController.text,
        ),
      );
    } else if (widget.textSearchController.text.length == 0) {
      _todoBloc.add(
        GetTodoAllEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _todoBloc,
        builder: (context, state) {
          if (state is GetTodoAllCompleteState) {
            List<Profile> todoItemList = state.resource.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  key: Key('$index'),
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDialog(
                          todoItem: todoItemList[index],
                        );
                      },
                    );
                    if (result) {
                      _todoBloc.add(
                        TodoDeleteEvent(todoItem: todoItemList[index]),
                      );
                    }
                  },
                  child: TodoListTile(
                    title: todoItemList[index].firstName,
                    subTitle: todoItemList[index].lastName,
                    picture: todoItemList[index]?.picture,
                    showDelete: true,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddProfilePage(
                            todoItem: todoItemList[index],
                            isUpdate: true,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: todoItemList.length,
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
