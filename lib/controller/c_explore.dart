import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/source/topic_source.dart';
import 'package:flutter/foundation.dart';

class CExplore extends ChangeNotifier {
  List<Topic> _topics = []; // list kosong

  // getter
  List<Topic> get topics => _topics;

  setTopics() async {
    _topics = await TopicSource.readExplore();
    notifyListeners();
  }
}
