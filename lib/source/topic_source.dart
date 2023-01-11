import 'dart:convert';

import 'package:course_discuss/config/api.dart';
import 'package:course_discuss/model/topic.dart';
import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

class TopicSource {
  // function create topic
  static Future<bool> create(
    String title,
    String description,
    String images,
    String base64codes,
    String idUser,
  ) async {
    String url = '${Api.topic}/create.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'title': title,
        'description': description,
        'images': images,
        'base64codes': base64codes,
        'id_user': idUser,
      });

      DMethod.printTitle('Topic Source - create', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - create', e.toString());
      return false;
    }
  }

  // function update topic
  static Future<bool> update(
    String id,
    String title,
    String description,
  ) async {
    String url = '${Api.topic}/update.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'title': title,
        'description': description,
      });

      DMethod.printTitle('Topic Source - update', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - update', e.toString());
      return false;
    }
  }

  // function delete topic
  static Future<bool> delete(
    String id,
    String images,
  ) async {
    String url = '${Api.topic}/delete.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id': id,
        'images': images,
      });

      DMethod.printTitle('Topic Source - delete', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - delete', e.toString());
      return false;
    }
  }

  // function get readExplore
  static Future<List<Topic>> readExplore() async {
    String url = '${Api.topic}/read_explore.php';

    try {
      Response response = await Client().get(Uri.parse(url));

      DMethod.printTitle('Topic Source - readExplore', response.body);
      Map responseBody = jsonDecode(response.body);

      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topic.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - readExplore', e.toString());
      return [];
    }
  }

  // function get readfeed
  static Future<List<Topic>> readFeed(String idUser) async {
    String url = '${Api.topic}/read_feed.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });

      DMethod.printTitle('Topic Source - readFeed', response.body);
      Map responseBody = jsonDecode(response.body);

      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topic.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - readFeed', e.toString());
      return [];
    }
  }

  // function get readWhereIdUser
  static Future<List<Topic>> readWhereIdUser(String idUser) async {
    String url = '${Api.topic}/read_where_id_user.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });

      DMethod.printTitle('Topic Source - readWhereIdUser', response.body);
      Map responseBody = jsonDecode(response.body);

      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topic.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - readWhereIdUser', e.toString());
      return [];
    }
  }

  // function search
  static Future<List<Topic>> search(String query) async {
    String url = '${Api.topic}/search.php';

    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'search_query': query,
      });

      DMethod.printTitle('Topic Source - search', response.body);
      Map responseBody = jsonDecode(response.body);

      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topic.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - search', e.toString());
      return [];
    }
  }
}
