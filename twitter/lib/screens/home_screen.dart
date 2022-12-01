import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:twitter/utils/search_stream.dart';
import 'package:twitter/widgets/show_posts_stream.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../providers/app_state.dart';
import '../providers/auth_state.dart';
import './edit_post_screen.dart';
import './signin_screen.dart';
import '../widgets/post_widget.dart';
import '../widgets/side_bar_menu.dart';
import '../widgets/bar_menu.dart';

class HomeScreen extends StatefulWidget {
  final String? userID;
  const HomeScreen({Key? key, this.userID}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // init state
    super.initState();
    // This is hitting DB everytime return to home screen
    // Thought I'd figured it out but stopped working - this is fine for non-production mode
    _populateCurrentUserInfo();
  }

  _populateCurrentUserInfo() async {
    CustomUser user = await Auth().getCurrentUserModel();
    setState(() {
      // Get user data from Firebase
      Provider.of<AppState>(context, listen: false).currentUser = user;
    });
  }

  @override
  void dispose() {
    // Dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const SignIn();
    } else {
      String userID = FirebaseAuth.instance.currentUser!.uid;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPostScreen(userID: userID),
                  ),
                );
              },
            ),
          ],
        ),
        body: const ShowPosts(),
        // HomeScreen is only screen to have side menu drawer
        drawer: const SideBarMenu(),
        bottomNavigationBar: const BottomMenuBar(),
      );
    }
  }
}
