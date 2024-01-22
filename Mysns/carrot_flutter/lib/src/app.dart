import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screen/auth/intro.dart';
import 'package:carrot_flutter/src/screen/home.dart';

class MyApp extends StatelessWidget {
  // 앱이 시작될 때 로그인 여부 판단
  final bool isLogin;

  // 생성자의 첫번째 파라미터로 로그인 여부 boolean을 가져와서 isLogin 변수에 저장
  const MyApp(this.isLogin, {super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: isLogin ? const Home() : const Intro(),
    );
  }
}