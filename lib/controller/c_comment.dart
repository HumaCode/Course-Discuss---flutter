import 'dart:convert';

import 'package:course_discuss/model/comment.dart';
import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/model/user.dart';
import 'package:course_discuss/source/comment_source.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CComment extends ChangeNotifier {
  List<Comment> _comments = []; // list kosong

  // getter
  List<Comment> get comments => _comments;

  setComments(Topic topic) async {
    _image = '';
    _imageBase64code = '';
    _comments = await CommentSource.read(topic.id);
    setReplyTo(topic.user!);
    notifyListeners();
  }

  // function reply comment
  User? _replyTo;
  User? get replyTo => _replyTo;
  setReplyTo(User user) {
    _replyTo = user;
    notifyListeners();
  }

  // mengelola gambar/image picker
  String _image = '';
  String get image => _image;

  String _imageBase64code = '';
  String get imageBase64code => _imageBase64code;

  pickImage(ImageSource source) async {
    XFile? result = await ImagePicker().pickImage(source: source);
    if (result != null) {
      _image = result.name;
      _imageBase64code = base64Encode(await result.readAsBytes());
      notifyListeners();
    }
  }
}
