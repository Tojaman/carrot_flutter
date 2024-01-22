import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../connect/user_connect.dart';
import 'package:get_storage/get_storage.dart';

import '../model/user_model.dart';
// import 'package:flutter/src';

final GetStorage _storage = GetStorage();


/**
 * 회원 동작과 관련된 모든 상태들을 공통으로 관리하는 클래스
 */
class UserController extends GetxController {
  final userConnection = Get.put(UserConnect());

  // 공통으로 관리할 멤버 변수
  UserModel? user;

  // 로그인 상태인지 검증
  Future<bool> isLogin() async {
    return _storage.hasData('access_token');
  }

  // 회원가입
  final GetStorage _storage = GetStorage();
  Future<bool> register(String email, String name, String password) async {
    try {
      String token = await userConnection.sendRegister(email, name, password);
      _storage.write('access_token', token);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  // 로그인
  Future<bool> login(String email, String password) async {
    try {
      String token = await userConnection.sendLogin(email, password);
      _storage.write('access_token', token);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  // 마이페이지
  Future mypage() async {
  Map map = await userConnection.getMyInfo();
  UserModel parseUser = UserModel.fromJson(map);
  user = parseUser;
  }
}