import 'package:course_discuss/config/app_route.dart';
import 'package:course_discuss/controller/c_home.dart';
import 'package:course_discuss/page/fragment/account_fragment.dart';
import 'package:course_discuss/page/fragment/explore_fragment.dart';
import 'package:course_discuss/page/fragment/feed_fragment.dart';
import 'package:course_discuss/page/fragment/my_topic_fragment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // list menu
    List menu = [
      {
        'icon': Icons.feed,
        'label': 'Feed',
        'view': const FeedFragment(),
      },
      {
        'icon': Icons.public,
        'label': 'Explore',
        'view': const ExploreFragment(),
      },
      {
        'icon': Icons.library_books,
        'label': 'My Topic',
        'view': const MyTopicFragment(),
      },
      {
        'icon': Icons.account_circle,
        'label': 'Profile',
        'view': const AccountFragment(),
      },
    ];

    return Consumer<CHome>(
      builder: (context, _, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: menu[_.indexMenu]['view'],
          ),

          // floating action button
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push(AppRoute.addTopic);
            },
            mini: true,
            tooltip: 'Create New Topic',
            child: const Icon(Icons.create),
          ),

          // location floating button
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          // bottom navigation bar
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _.indexMenu,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (newIndex) {
              _.indexMenu = newIndex;
            },
            items: menu.map((e) {
              return BottomNavigationBarItem(
                  icon: Icon(e['icon']), label: e['label']);
            }).toList(),
          ),
        );
      },
    );
  }
}
