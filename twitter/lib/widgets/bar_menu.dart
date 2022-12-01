import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/chats_screen.dart';

class BottomMenuBar extends StatefulWidget {
  // Using state in this widget to setpageIndex and reference pageIndex in AppState
  const BottomMenuBar({Key? key}) : super(key: key);

  @override
  State<BottomMenuBar> createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // Custom Row widtget with near-identical children
        // There is BottomNavigationBar widget
        // Couldn't get it to work but Jay did! Very cool, check it out
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // All children are near-identical so list builder would be best but...
            GestureDetector(
                // When click on icon, updates state, then navigates to HomeScreen
                // Consumer is syntactic sugar for Provider.of - is using provider/consumer to get data from app state
                // Require listen: false to avoid infinite loop when listening outside of this widget
                onTap: () {
                  Provider.of<AppState>(context, listen: false).setpageIndex =
                      0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Icon(
                  Icons.home_outlined,
                  // Fun lil if statement to change icon color based on if pageIndex in state matches given index
                  color: Provider.of<AppState>(context).pageIndex == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                )),
            GestureDetector(
                onTap: () {
                  Provider.of<AppState>(context, listen: false).setpageIndex =
                      1;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
                child: Icon(
                  Icons.search,
                  color: Provider.of<AppState>(context).pageIndex == 1
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                )),
            GestureDetector(
                onTap: () {
                  Provider.of<AppState>(context, listen: false).setpageIndex =
                      2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsScreen()),
                  );
                },
                child: Icon(
                  Icons.notifications_outlined,
                  color: Provider.of<AppState>(context).pageIndex == 2
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                )),
            GestureDetector(
                onTap: () {
                  Provider.of<AppState>(context, listen: false).setpageIndex =
                      3;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatsScreen()),
                  );
                },
                child: Icon(
                  Icons.email_outlined,
                  color: Provider.of<AppState>(context).pageIndex == 3
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                )),
          ],
        ));
  }
}
