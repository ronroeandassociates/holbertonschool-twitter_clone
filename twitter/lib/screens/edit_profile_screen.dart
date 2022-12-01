import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../providers/auth_state.dart';
// import '../utils/general_info.dart';
import './profile_screen.dart';
// import '../utils/change_profile_pic.dart';

class EditProfileScreen extends StatefulWidget {
  final String userID;
  const EditProfileScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Define property types
  late TextEditingController _displayController;
  late TextEditingController _bioController;

// Decorators don't do anything - just for clarity
  @override
  @mustCallSuper
  void initState() {
    // Initializes state and mounts - data, properties
    // Subscribes to state changes
    super.initState();
    _displayController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  @mustCallSuper
  void dispose() {
    // Permanently remove everything at end of lifecycle (after unmount)
    _displayController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void updateUserData() async {
    final currentUser =
        Provider.of<AppState>(context, listen: false).currentUser;
    // Update either display name or bio or both
    // If changing display name, update it in both Firebase and AppState
    if (currentUser.displayName != _displayController.text &&
        _displayController.text != '') {
      currentUser.displayName = _displayController.text;
      updateUserModel(widget.userID, 'displayName', currentUser.displayName);
    }
    // If changing bio, update it in both Firebase and AppState
    if (currentUser.bio != _bioController.text && _bioController.text != '') {
      currentUser.bio = _bioController.text;
      updateUserModel(widget.userID, 'bio', currentUser.bio);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<AppState>(context, listen: false).currentUser;

    return Scaffold(
      // Appbar with back button and options button
      // Shows in front of body so can see coverImgUrl
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // Override default leading button to return to profile screen
        // This is because without this, context is not saved when going back so pictures remain the same
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(userID: currentUser.userID)));
          },
        ),
        actions: <Widget>[
          TextButton(
              child: Text('Save',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white)),
              onPressed: () {
                // When press save, update name and/or bio and redirect to profile
                updateUserData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(userID: currentUser.userID)));
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // Cover image in 1/3rd of screen
              Image(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                image: NetworkImage(currentUser.coverImgUrl),
              ),
              GestureDetector(
                // When choose new cover pic, update imageUrl in Firebase and re-render screen with setState
                onTap: () async {
                  final url = await pickImageFromDevice(context, 'coverImgUrl');
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      currentUser.coverImgUrl = url;
                    });
                  });
                },
                child: const Center(
                  heightFactor: 4.5,
                  child: Icon(Icons.camera_alt_outlined,
                      color: Colors.white, size: 50),
                ),
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
                      backgroundImage: NetworkImage(currentUser.imageUrl),
                    ),
                  )),
              Positioned(
                bottom: -25,
                left: 45,
                child: GestureDetector(
                    // When choose new profile pic, update imageUrl in Firebase and re-render screen with setState
                    onTap: () async {
                      final url =
                          await pickImageFromDevice(context, 'imageUrl');
                      Future.delayed(Duration.zero, () {
                        setState(() {
                          currentUser.imageUrl = url;
                        });
                      });
                    },
                    child: const Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 50)),
              ),
            ]),
        Padding(
          // Editable fields - do nothing until hit "save" button
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 75),
            const Text('Name', textAlign: TextAlign.left),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: TextField(
                controller: _displayController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
              ),
            ),
            const Text('Bio'),
            TextField(
              controller: _bioController,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 5,
            )
          ]),
        ),
      ])),
    );
  }
}
