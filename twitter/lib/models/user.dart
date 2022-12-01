class CustomUser {
  // Fields within User table
  String key;
  String userID;
  String email;
  String userName;
  String displayName;
  String bio;
  String location;
  DateTime dateJoined;
  String imageUrl;
  String coverImgUrl;
  bool isVerified;
  int followers;
  int following;
  List<String> followersList;
  List<String> followingList;

  // Constructor
  CustomUser({
    required this.key,
    required this.userID,
    required this.email,
    required this.userName,
    required this.displayName,
    required this.bio,
    required this.location,
    required this.dateJoined,
    required this.imageUrl,
    required this.coverImgUrl,
    required this.isVerified,
    // Can probably just find length of list rather than passing in - we'll see
    required this.followers,
    required this.following,
    required this.followersList,
    required this.followingList,
  });

  // named constructor fromJson that converts Firebase data to a CustomUser
  factory CustomUser.fromJson(Map<dynamic, dynamic> map) => CustomUser(
        key: map['key'],
        userID: map['userID'],
        email: map['email'],
        userName: map['userName'],
        displayName: map['displayName'],
        bio: map['bio'],
        location: map['location'],
        dateJoined: DateTime.fromMillisecondsSinceEpoch(
            map['dateJoined'].millisecondsSinceEpoch),
        imageUrl: map['imageUrl'],
        coverImgUrl: map['coverImgUrl'],
        isVerified: map['isVerified'],
        followers: map['followers'],
        following: map['following'],
        followersList: List<String>.from(map['followersList']),
        followingList: List<String>.from(map['followingList']),
      );

  // instance method that converts data retrieved from Firestore into JSON format
  Map<String, Object?> toJson() => {
        "key": key,
        "userID": userID,
        "email": email,
        "userName": userName,
        "displayName": displayName,
        "bio": bio,
        "location": location,
        "dateJoined": dateJoined,
        "imageUrl": imageUrl,
        "coverImgUrl": coverImgUrl,
        "isVerified": isVerified,
        "followers": followers,
        "following": following,
        "followersList": followersList,
        "followingList": followingList,
      };
}
