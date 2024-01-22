import 'package:carrot_flutter/src/connect/feed_connect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/feed_model.dart';

final feedConnect = Get.put(FeedConnect());

class FeedController extends GetxController {
  // 상태관리에서 관리하는 변수
  List<FeedModel> list = [];

  feedIndex() async {
    // FeedConnect를 통해 서버에서부터 List를 가져옴
    List jsonData = await feedConnect.getList();

    // List<Map>을 모델인 List<Model>로 변경!
    List<FeedModel> tmp = jsonData.map((m) => FeedModel.parse(m)).toList();

    // 변경된 tmp를 상태 관리 변수 list 에다가 넣어줌
    list = tmp;

    // UI 업데이트를 알려준다
    update();
  }

  Future<bool> feedCreate(String title, String content, String price, int? imageId) async {
    try {
      await feedConnect.storeItem(title, price, content, imageId: imageId);
      await feedIndex();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  Future<int> upload(String name, String path) async {
    Map data = await feedConnect.imageUpload(name, path);
    return data['id'];
  }
}