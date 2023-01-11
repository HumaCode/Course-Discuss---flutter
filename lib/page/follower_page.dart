import 'package:course_discuss/controller/c_follower.dart';
import 'package:course_discuss/model/user.dart';
import 'package:course_discuss/widget/item_user.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowerPage extends StatelessWidget {
  const FollowerPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    // final cFollower = context.read<CFollower>();
    // cFollower.setList(user.id);

    context.read<CFollower>().setList(user.id);

    return Scaffold(
      appBar: DView.appBarLeft("${user.username}'s follower"),
      body: Consumer<CFollower>(builder: (contextConsumer, _, child) {
        // jika tidak ada datanya
        if (_.list.isEmpty) return DView.empty();

        // jika ada datanya
        return ListView.builder(
          itemCount: _.list.length,
          itemBuilder: (context, index) {
            return ItemUser(user: _.list[index]);
          },
        );
      }),
    );
  }
}
