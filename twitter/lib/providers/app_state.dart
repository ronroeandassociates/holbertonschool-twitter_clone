import 'package:flutter/material.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  // Current user
  CustomUser _currentUser = CustomUser(
    key: '',
    userID: '',
    email: '',
    userName: '',
    displayName: '',
    bio: '',
    location: '',
    dateJoined: DateTime.now(),
    imageUrl: '',
    coverImgUrl: '',
    isVerified: false,
    followers: 0,
    following: 0,
    followersList: [],
    followingList: [],
  );

  CustomUser get currentUser => _currentUser;
  set currentUser(CustomUser value) {
    _currentUser = value;
    notifyListeners();
  }

  // Current page index
  int _pageIndex = 0;
  int get pageIndex {
    return _pageIndex;
  }

  set setpageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  // Not actually using this
  bool _loading = false;
  bool get loading {
    return _loading;
  }

  set isLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
