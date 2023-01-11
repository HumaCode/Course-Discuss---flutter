import 'dart:convert';

import 'package:course_discuss/config/app_color.dart';
import 'package:course_discuss/config/app_route.dart';
import 'package:course_discuss/controller/c_explore.dart';
import 'package:course_discuss/controller/c_user.dart';
import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/widget/item_topic.dart';
import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExploreFragment extends StatelessWidget {
  const ExploreFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final cUser = context.read<CUser>();
    if (cUser.data == null) return DView.loadingCircle();

    context.read<CExplore>().setTopics();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DView.textTitle('Explore', size: 24),
              DButtonElevation(
                mainColor: AppColor.primary,
                onClick: () {
                  context.push(AppRoute.search);
                },
                height: 36,
                width: 36,
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Consumer<CExplore>(
            builder: (contextBuilder, _, child) {
              // jika tidak ada data
              if (_.topics.isEmpty) return DView.empty();

              // jika ada
              return ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: _.topics.length,
                itemBuilder: ((context, index) {
                  Topic topic = _.topics[index];
                  List images = jsonDecode(topic.images);

                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        16, 8, 16, index == _.topics.length - 1 ? 30 : 8),
                    child: ItemTopic(topic: topic, images: images),
                  );
                }),
              );
            },
          ),
        )
      ],
    );
  }
}
