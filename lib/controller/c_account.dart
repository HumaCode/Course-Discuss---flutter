import 'package:course_discuss/source/user_source.dart';
import 'package:flutter/foundation.dart';

class CAccount extends ChangeNotifier {
  Map<String, dynamic> _stat = {
    'topic': 0.0,
    'following': 0.0,
    'follower': 0.0,
  };

  Map<String, dynamic> get stat => _stat;

  setStat(String idUser) async {
    _stat = await UserSource.stat(idUser);
    notifyListeners();
  }
}