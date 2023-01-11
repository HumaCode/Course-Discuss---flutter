import 'package:course_discuss/config/session.dart';
import 'package:course_discuss/controller/c_add_topic.dart';
import 'package:course_discuss/controller/c_comment.dart';
import 'package:course_discuss/controller/c_follower.dart';
import 'package:course_discuss/controller/c_following.dart';
import 'package:course_discuss/controller/c_profile.dart';
import 'package:course_discuss/controller/c_search.dart';
import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/model/user.dart';
import 'package:course_discuss/page/add_topic.dart';
import 'package:course_discuss/page/comment_page.dart';
import 'package:course_discuss/page/detail_topic_page.dart';
import 'package:course_discuss/page/error_page.dart';
import 'package:course_discuss/page/follower_page.dart';
import 'package:course_discuss/page/following_page.dart';
import 'package:course_discuss/page/home_page.dart';
import 'package:course_discuss/page/login_page.dart';
import 'package:course_discuss/page/profile_page.dart';
import 'package:course_discuss/page/register_page.dart';
import 'package:course_discuss/page/search_page.dart';
import 'package:course_discuss/page/update_topic_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRoute {
  static const home = "/";
  static const login = "/login";
  static const register = "/register";
  static const addTopic = "/add-topic";
  static const profile = "/profile";
  static const search = "/search";
  static const follower = "/follower";
  static const following = "/following";
  static const comment = "/comment";
  static const detailTopic = "/detail-topic";
  static const updateTopic = "/update-topic";

  // membuat route
  static GoRouter routerConfig = GoRouter(
    // jika error
    errorBuilder: (context, state) => ErrorPage(
      title: 'Something Error',
      description: state.error.toString(),
    ),

    // debuging
    debugLogDiagnostics: true,

    // redirect pengecekan session
    redirect: (context, state) async {
      User? user = await Session.getUser(); // ambil sessionya

      // dicek jika null
      if (user == null) {
        // cek lagi agar tidak terjadi invinitiloop
        if (state.location == login || state.location == register) {
          // jika sudah di lokasi login maka ya sudah gak perlu di cek lagi user sessionya
          return null;
        }

        return login; // maka ke halaman login
      }

      return null; // kehalaman route awal(home)
    },

    routes: [
      // home
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),

      // login
      GoRoute(
        path: login,
        builder: (context, state) => LoginPage(),
      ),

      // register
      GoRoute(
        path: register,
        builder: (context, state) => RegisterPage(),
      ),

      // Add topic
      GoRoute(
        path: addTopic,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CAddTopic(),
          child: AddTopic(),
        ),
      ),

      // profile
      GoRoute(
        path: profile,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CProfile(),
          child: ProfilePage(user: state.extra as User),
        ),
      ),

      // pencarian
      GoRoute(
        path: search,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CSearch(),
          child: const SearchPage(),
        ),
      ),

      // follower
      GoRoute(
        path: follower,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CFollower(),
          child: FollowerPage(user: state.extra as User),
        ),
      ),

      // following
      GoRoute(
        path: following,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CFollowing(),
          child: FollowingPage(user: state.extra as User),
        ),
      ),

      // comment
      GoRoute(
        path: comment,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CComment(),
          child: CommentPage(topic: state.extra as Topic),
        ),
      ),

      // detail topic
      GoRoute(
        path: detailTopic,
        builder: (context, state) =>
            DetailTopicPage(topic: state.extra as Topic),
      ),

      // update topic
      GoRoute(
        path: updateTopic,
        builder: (context, state) =>
            UpdateTopicPage(topic: state.extra as Topic),
      ),
    ],
  );
}
