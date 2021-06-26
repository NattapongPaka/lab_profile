import 'package:flutter/material.dart';
import 'package:profile/src/routes.dart';
import 'package:profile/src/ui/profile_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final TextEditingController _todoController = TextEditingController();
  final FocusNode _todoFocusNode = FocusNode();
  final PageController _myPage = PageController(initialPage: 0);

  int _selectedIndex = 0;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  void dispose() {
    // _todoController.dispose();
    _todoFocusNode.dispose();
    _searchQueryController.dispose();
    super.dispose();
  }

  _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      //onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  _startSearch() {
    ModalRoute.of(context).addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearching),
    );

    setState(() {
      _isSearching = true;
    });
  }

  _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : Text("All Profile"),
        actions: _buildActions(),
      ),
      body: ProfilePage(
        textSearchController: _searchQueryController,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePage.todoAdd);
        },
      ),
    );
  }
}
