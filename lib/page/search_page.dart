import 'dart:convert';

import 'package:course_discuss/controller/c_search.dart';
import 'package:course_discuss/model/topic.dart';
import 'package:course_discuss/model/user.dart';
import 'package:course_discuss/widget/item_topic.dart';
import 'package:course_discuss/widget/item_user.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerSearch = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: controllerSearch,
            decoration: InputDecoration(
              hintText: 'Search...',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              fillColor: Colors.white54,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  // cek apakah inputan kosong
                  if (controllerSearch.text != '') {
                    context.read<CSearch>().search(controllerSearch.text);
                  }
                },
                icon: const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // action
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: context.watch<CSearch>().filter,
              items: context.read<CSearch>().filters.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                context.read<CSearch>().filter = value!;
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              underline: const SizedBox(),
            ),
          )
        ],
      ),

      // body
      body: Consumer<CSearch>(builder: (contextConsumer, _, child) {
        // cek apakah user atau topic
        if (_.filter == 'Topic') {
          // jika kosong
          if (_.topics.isEmpty) return DView.empty();

          // jika tidak kosong/ada datanya
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: _.topics.length,
            itemBuilder: (context, index) {
              Topic topic = _.topics[index];
              List images = jsonDecode(topic.images);
              return Padding(
                padding: EdgeInsets.fromLTRB(
                    16, 8, 16, index == _.topics.length - 1 ? 16 : 8),
                child: ItemTopic(
                  topic: topic,
                  images: images,
                ),
              );
            },
          );
        } else {
          // jika kosong
          if (_.users.isEmpty) return DView.empty();

          // jika tidak kosong/ada datanya
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: _.users.length,
            itemBuilder: (context, index) {
              User user = _.users[index];
              return ItemUser(user: user);
            },
          );
        }
      }),
    );
  }
}
