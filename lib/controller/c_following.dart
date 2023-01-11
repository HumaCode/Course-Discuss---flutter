import 'package:course_discuss/model/user.dart';
import 'package:course_discuss/source/follow_source.dart';
import 'package:flutter/foundation.dart';

class CFollowing extends ChangeNotifier {
  List<User> _list = []; // list kosong

  // getter
  List<User> get list => _list;

  setList(String idUser) async {
    _list = await FollowSource.readFollowing(idUser);
    notifyListeners();
  }
}
