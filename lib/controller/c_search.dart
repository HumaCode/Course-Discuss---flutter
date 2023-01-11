import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/model/user.dart';
import 'package:course_discuss/source/topic_source.dart';
import 'package:course_discuss/source/user_source.dart';
import 'package:flutter/foundation.dart';

class CSearch extends ChangeNotifier {
  List<String> get filters => ['Topic', 'User'];

  String _filter = 'Topic';
  String get filter => _filter;
  set filter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  // tombol pencarian
  search(String query) {
    if (filter == 'Topic') {
      setTopics(query);
    } else {
      setUsers(query);
    }
  }

  // pencarian topic
  List<Topic> _topics = []; // list kosong
  // getter
  List<Topic> get topics => _topics;

  setTopics(String query) async {
    _topics = await TopicSource.search(query);
    notifyListeners();
  }

  // pencarian user
  List<User> _users = []; // list kosong
  // getter
  List<User> get users => _users;

  setUsers(String query) async {
    _users = await UserSource.search(query);
    notifyListeners();
  }
}
