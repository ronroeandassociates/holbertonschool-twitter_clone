import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/app_state.dart';
import './home_screen.dart';
import '../widgets/bar_menu.dart';

class NotificationsScreen extends StatelessWidget {
  // No props needed
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<AppState>(context).currentUser;

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(children: [
              // Always stays the same - profile image, title, settings icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(currentUser.imageUrl),
                    radius: 25,
                  ),
                  Flexible(
                      child: Text(
                    'Notifications',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Theme.of(context).primaryColorDark),
                  )),
                  GestureDetector(
                    // On tap of text, navigate to sign up screen as on notifications_screen and chats_screen
                    // Not asked to do this but I wanted it - no other way to get to SignIn if home is HomeScreen
                    onTap: () {
                      Provider.of<AppState>(context, listen: false)
                          .setpageIndex = 0;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: const Icon(Icons.settings_outlined,
                        color: Colors.blue, size: 35),
                  ),
                ],
              ),
            ])),
        // Filler info while no notifications
        // Needs to be flexible so text can be wrapped
        Flexible(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Colors.grey[200],
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Notifications available yet",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "When new notifications are found, they'll show up here",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).primaryColorLight,
                          height: 1.5),
                    )
                  ]),
            ),
          ),
        ),
      ])),
      // Always includes bottom nav bar
      bottomNavigationBar: const BottomMenuBar(),
    );
  }
}
