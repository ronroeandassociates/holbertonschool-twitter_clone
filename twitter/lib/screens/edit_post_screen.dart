import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/post.dart';
import '../providers/app_state.dart';
// import '../utils/general_info.dart';
import './home_screen.dart';

class EditPostScreen extends StatefulWidget {
  final String userID;
  const EditPostScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController _postController;

  @override
  @mustCallSuper
  void initState() {
    // Initializes state and mounts - data, properties
    // Subscribes to state changes
    super.initState();
    _postController = TextEditingController();
  }

  @override
  @mustCallSuper
  void dispose() {
    // Permanently remove everything at end of lifecycle (after unmount)
    _postController.dispose();
    super.dispose();
  }

  void postTweet() async {
    // Add post object to Firestore
    Map<String, dynamic> postMap = {
      'text': _postController.text,
      'userID': widget.userID,
      'likeCount': 0,
      'likeList': [],
    };
    await postsRef.doc(const Uuid().v4()).set(Post.fromJson(postMap));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<AppState>(context, listen: false).currentUser;

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(children: [
                  // Always stays the same - profile image, title, settings icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close,
                              color: Colors.blue, size: 30)),
                      OutlinedButton(
                          onPressed: () {
                            postTweet();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          // Outlined button with rounded corners
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          child: Text('Tweet',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white)))
                    ],
                  ),
                ])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                // Shows user's profile pic and text field to enter post tied to "tweet" button
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(currentUser.imageUrl)),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _postController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ))
                ]),
              ]),
            ),
          ],
        ),
      ])),
    );
  }
}
