import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screens/profile_screen.dart';
// import '../utils/general_info.dart';

class UsersSearchResultsWidget extends StatelessWidget {
  // Define property types
  final String name;
  final String username;
  final String imgUrl;
  final String userID;
  final bool isVerified;

// Constructor - all properties must be passed
  const UsersSearchResultsWidget(
      {Key? key,
      required this.name,
      required this.username,
      required this.imgUrl,
      required this.userID,
      required this.isVerified})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Get current user model
        CustomUser user = await getUserByID(userID);
        // Pass userID param to ProfileScreen and navigate to it
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileScreen(
                      userID: user.userID,
                    )));
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
              // Center centers horizontally and vertically by default
              // Not centered vertically with heightFactor - Only takes up 100% of container height
              heightFactor: 1,
              child: Row(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imgUrl),
                  radius: 25,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    // mainAxisSize works with height factor to center within container
                    mainAxisSize: MainAxisSize.min,
                    // Overrides default center for text align left
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text('$name ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontWeight: FontWeight.bold)),
                        // If verified, add checkmark - else do nothing
                        if (isVerified)
                          Icon(
                            Icons.check_circle,
                            color: Theme.of(context).primaryColor,
                            size: 15,
                          ),
                      ]),
                      Text('@$username',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: Theme.of(context).primaryColorLight))
                    ],
                  ),
                )
              ]))),
    );
  }
}
