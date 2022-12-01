import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/widgets/entry_field.dart';
import '../models/user.dart';
import '../providers/app_state.dart';
import '../widgets/search_users.dart';
import '../widgets/bar_menu.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    // init state
    super.initState();
    _searchController.addListener(() {
      // set state
      setState(() {});
    });
  }

  @override
  void dispose() {
    // dispose controllers
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CustomUser currentUser = Provider.of<AppState>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundImage: NetworkImage(currentUser.imageUrl),
            radius: 50,
          ),
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            // Background and color
            filled: true,
            fillColor: Colors.grey[200],
            // Hint/placeholder text
            hintStyle: TextStyle(
                color: Theme.of(context).primaryColorLight, fontSize: 20),
            // Padding around text itself within field
            contentPadding: const EdgeInsets.fromLTRB(30, 15, 0, 15),
            // Border around field
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: (Colors.grey[200])!),
            ),
            // Border around field when focused
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                color: Colors.blue, size: 35),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
        ],
      ),
      // Body of page is results from user search
      body: SearchUsers(
        searchText: _searchController.text,
      ),
      bottomNavigationBar: const BottomMenuBar(),
    );
  }
}
