import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/screen/feed/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'feed/create.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('정왕동'),
            centerTitle: false,
            actions: const [
              IconButton(onPressed: null, icon: Icon(Icons.menu)),
              IconButton(onPressed: null, icon: Icon(Icons.search)),
              IconButton(onPressed: null, icon: Icon(Icons.notifications_outlined)),
            ],
          ),
          floatingActionButton: InkWell(
            onTap: () {
              Get.to(() => FeedCreate());
            },
            child: Container (
              width: 56.0,
              height: 56.0,
              decoration: const ShapeDecoration(
                shape: StadiumBorder(),
                color: Color(0xFFFF6f0f),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
        ),
          bottomNavigationBar: const SafeArea(
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: '홈'),
                Tab(icon: Icon(Icons.feed), text: '동네생활'),
                Tab(icon: Icon(Icons.location_on_outlined), text: '내 근처'),
                Tab(icon: Icon(Icons.chat_bubble_outline_rounded), text: '채팅'),
                Tab(icon: Icon(Icons.person_outline), text: '나의 홍당무'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FeedIndex(),
              // Center(child: Text('page1')),
              Center(child: Text('page2')),
              Center(child: Text('page3')),
              Center(child: Text('page4')),
              Center(child: Text('page5')),
            ],
          ),
        )
      // body: const Center(
      //   child: Text('app'),
      // ),
    );
  }
}