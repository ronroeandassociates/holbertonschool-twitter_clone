import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/app_state.dart';
import '../providers/auth_state.dart';
import '../screens/signin_screen.dart';
import '../screens/profile_screen.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({Key? key}) : super(key: key);

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<AppState>(context).currentUser;

    return Drawer(
      // Traditional structure of Drawer (there is UserAccountsDrawerHeader but not quite right)
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            // Want DrawerHeader to be 275 rather than default 200 I think
            height: 275,
            child: DrawerHeader(
                // Separate user info from navigation (don't think this is necessary but better org)
                // Besides DrawerHeader, everything else is ListTile
                child: Column(
                    // Override default center crossAxisAlignment to text align left
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Default user image and all other info hardcoded
                    children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(currentUser.imageUrl),
                    radius: 35,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser.displayName,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Theme.of(context).primaryColorLight),
                        ),
                        Text(
                          // Convert snapshot to UserModel
                          '@${currentUser.userName}',
                          // 'User Name',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Theme.of(context).primaryColorLight),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text('${currentUser.followers} Followers',
                              style: Theme.of(context).textTheme.subtitle1)),
                      Expanded(
                          child: Text('${currentUser.following} Following',
                              style: Theme.of(context).textTheme.subtitle1))
                    ],
                  ),
                ])),
          ),
          // These are the actual menu items - ideally they should be links but onTap does nothing for most
          ListTile(
            leading: const Icon(Icons.person),
            iconColor: Theme.of(context).primaryColorLight,
            title: const Text('Profile'),
            onTap: () async {
              // Get current user model
              CustomUser user = await Auth().getCurrentUserModel();
              // Pass userID param to ProfileScreen and navigate to it
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            userID: user.userID,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            iconColor: Theme.of(context).primaryColorLight,
            title: const Text('Lists'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            iconColor: Theme.of(context).primaryColorLight,
            title: const Text('Bookmark'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.flash_on),
            iconColor: Theme.of(context).primaryColorLight,
            title: const Text('Moments'),
            onTap: () => {},
          ),
          Divider(
            color: Theme.of(context).primaryColorLight,
          ),
          ListTile(
            title: const Text('Settings and privacy'),
            onTap: () => {},
          ),
          ListTile(
            title: const Text('Help Center'),
            onTap: () => {},
          ),
          Divider(
            color: Theme.of(context).primaryColorLight,
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () => {
              // Logout
              Auth().logout(),
              // Provider.of<AppState>(context, listen: false).isLoading = true,
              // Navigate back to SignIn screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignIn()))
            },
          ),
        ],
      ),
    );
  }
}
