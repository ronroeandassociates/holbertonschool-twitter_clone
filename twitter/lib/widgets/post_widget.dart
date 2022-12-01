import 'package:flutter/material.dart';
import 'package:twitter/widgets/comment_retweet_like_bar.dart';
import '../models/post.dart';
import '../models/user.dart';
// import '../utils/general_info.dart';
import './tweet_user_info.dart';

class PostWidget extends StatefulWidget {
  // Define property types
  final Post post;

// Constructor - all properties must be passed
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    Post post = widget.post;

    return Column(children: [
      Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Center(
            // Center centers horizontally and vertically by default
            // Not centered vertically with heightFactor - Only takes up 100% of container height
            heightFactor: 1,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FutureBuilder(
                // Requires getting user info in order to get profile pic
                // Post saves user as userID but need imageUrl
                future: getUserByID(post.userID),
                builder:
                    (BuildContext context, AsyncSnapshot<CustomUser> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!.imageUrl),
                      radius: 25,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  // mainAxisSize works with height factor to center within container
                  mainAxisSize: MainAxisSize.min,
                  // Overrides default center for text align left
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TweetUserInfo(userID: post.userID, postText: post.text),
                    // Separates in appearance from users_search_results_widget starting here
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                      child: SizedBox(
                          width: 250,
                          child: Text(post.text,
                              style: Theme.of(context).textTheme.bodyText2)),
                    )
                  ],
                ),
              ),
            ]),
          )),
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: CommentRetweetLikeBar(post: post),
      )
    ]);
  }
}
