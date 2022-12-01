class Post {
  // Fields with Post collection
  String text;
  String userID;
  int likeCount;
  List<String> likeList;

  // Constructor
  Post({
    required this.text,
    required this.userID,
    required this.likeCount,
    required this.likeList,
  });

  // named constructor fromJson that converts Firebase data to a CustomUser
  factory Post.fromJson(Map<dynamic, dynamic> map) => Post(
        text: map['text'],
        userID: map['userID'],
        likeCount: map['likeCount'],
        likeList: List<String>.from(map['likeList']),
      );

  // instance method that converts data retrieved from Firestore into JSON format
  Map<String, Object?> toJson() => {
        "text": text,
        "userID": userID,
        "likeCount": likeCount,
        "likeList": likeList,
      };
}
