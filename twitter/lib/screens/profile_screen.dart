import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/app_state.dart';
import '../providers/auth_state.dart';
// import '../utils/general_info.dart';
import './home_screen.dart';
import '../widgets/edit_profile_button.dart';
import '../widgets/follow_unfollow_button.dart';
// import '../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final String userID;
  const ProfileScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Default user to current user
  bool _isUser = true;
  late CustomUser currentUser;

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    // Check if user is current user
    _isCurrentUser();
  }

  // Set state of _isUser to true if user is current user to display options
  void _isCurrentUser() async {
    final user = await Auth().getCurrentUserModel();
    setState(() {
      if (user.userID == widget.userID) {
        _isUser = true;
        currentUser = user;
      } else {
        _isUser = false;
        currentUser = user;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize userID
    String userID = widget.userID;

    return Scaffold(
      // Appbar with back button and options button
      // Shows in front of body so can see coverImgUrl
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // Override default leading button to return to home screen
        // This is because without this, there is a circular loop where rotates between edit_profile_screen and this
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<AppState>(context, listen: false).setpageIndex = 0;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {})
        ],
      ),
      body: FutureBuilder(
          future: getUserByID(userID),
          builder: (BuildContext context, AsyncSnapshot<CustomUser> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Column(children: [
                Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Cover image in 1/3rd of screen
                      Image(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        image: NetworkImage(snapshot.data!.coverImgUrl),
                      ),
                      // Profile image is positioned halfway into middle of cover image
                      Positioned(
                          bottom: -50,
                          left: 15,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey[200],
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(snapshot.data!.imageUrl),
                            ),
                          ))
                    ]),
                _isUser
                    // If user is current user, show edit profile button
                    ? EditProfileButton(userID: userID)
                    // If user is not current user, show follow button
                    : FollowButton(userID: userID, currentUser: currentUser),
                SizedBox(
                  height: 50,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(snapshot.data!.displayName),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    subtitle: Text('@' + snapshot.data!.userName),
                  ),
                ),
                SizedBox(
                  child: ListTile(
                    subtitle: Text(snapshot.data!.bio),
                  ),
                ),
                SizedBox(
                  height: 32,
                  child: ListTile(
                    minLeadingWidth: 5,
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(snapshot.data!.location),
                  ),
                ),
                ListTile(
                  minLeadingWidth: 5,
                  leading: const Icon(Icons.calendar_month),
                  title:
                      Text(convertDateTimeToString(snapshot.data!.dateJoined)),
                ),
                ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 100, 0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // This does not update in real time because FollowButton is a child element and followers is not stateful
                        Text('${snapshot.data!.followers} Followers',
                            style: Theme.of(context).textTheme.headline6!),
                        Text('${snapshot.data!.following} Following',
                            style: Theme.of(context).textTheme.headline6!),
                      ],
                    ))
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
