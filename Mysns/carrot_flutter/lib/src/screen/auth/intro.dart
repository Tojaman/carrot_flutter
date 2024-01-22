import 'package:carrot_flutter/src/screen/auth/register.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('asset/고릴라.jpg', width: 200, height: 200),
                  const SizedBox(height: 40),
                  const Text(
                    '당신 근처의 홍당무마켓',
                    style:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '내 동네를 설정하고\n홍당무마켓을 시작해보세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                // ElevatedButton : 시작하기 버튼?
                child: ElevatedButton(
                  onPressed: () {
                    // 시작하기를 클릭하면 회원가입 창으로 이동
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Register(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF7E36),
                  ),
                  child: const Text(
                    '시작하기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('이미 계정이 있나요? '),
                  // TextButton : 글자 버튼
                  TextButton(onPressed: () {}, child: const Text('로그인'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}