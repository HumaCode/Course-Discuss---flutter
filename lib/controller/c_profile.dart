import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/source/follow_source.dart';
import 'package:course_discuss/source/topic_source.dart';
import 'package:course_discuss/source/user_source.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/cupertino.dart';

class CProfile extends ChangeNotifier {
  List<Topic> _topics = []; // list kosong

  // getter
  List<Topic> get topics => _topics;

  setTopics(String idUser) async {
    _topics = await TopicSource.readWhereIdUser(idUser);
    notifyListeners();
  }

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

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;
  checkIsFollowing(String fromIdUser, String toIdUser) async {
    _isFollowing = await FollowSource.checkIsFollowing(fromIdUser, toIdUser);
    notifyListeners();
  }

  // function follow
  setFollow(BuildContext context, String fromIdUser, String toIdUser) {
    if (isFollowing) {
      FollowSource.noFollowing(fromIdUser, toIdUser).then((success) {
        if (success) {
          setStat(toIdUser);
          checkIsFollowing(fromIdUser, toIdUser);
          DInfo.snackBarSuccess(context, 'Success Unfollow');
        } else {
          DInfo.snackBarError(context, 'Unfollow Failed');
        }
      });
    } else {
      FollowSource.following(fromIdUser, toIdUser).then((success) {
        if (success) {
          setStat(toIdUser);
          checkIsFollowing(fromIdUser, toIdUser);
          DInfo.snackBarSuccess(context, 'Success follow');
        } else {
          DInfo.snackBarError(context, 'follow Failed');
        }
      });
    }
  }
}
