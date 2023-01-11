import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/source/topic_source.dart';
import 'package:flutter/foundation.dart';

class CMyTopic extends ChangeNotifier {
  List<Topic> _topics = []; // list kosong

  // getter
  List<Topic> get topics => _topics;

  setTopics(String idUser) async {
    _topics = await TopicSource.readWhereIdUser(idUser);
    notifyListeners();
  }
}
