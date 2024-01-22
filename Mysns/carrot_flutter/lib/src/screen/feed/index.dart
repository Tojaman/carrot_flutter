import 'package:carrot_flutter/src/widget/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carrot_flutter/src/controller/feed_controller.dart';

final feedController = Get.put(FeedController());

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  @override
  void initState() {
    super.initState();
    feedController.feedIndex();
  }

  Future<void> _onRefresh() async {
    await feedController.feedIndex();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            // ListView 내의 안여백(padding)
            padding: const EdgeInsets.all(10),
            // 현재 ListView의 아이템 갯수
            itemCount: controller.list.length,
            itemBuilder: (BuildContext context, int index) {
              // 각각 ListView의 Item이 어떻게 그려질지를 적어주는 Builder
              return FeedListItem(controller.list[index]);
            },
          ),
        );
      });
  }
}