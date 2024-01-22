import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carrot_flutter/src/screen/home.dart';

import '../../controller/user_controller.dart';
class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final userController = Get.put(UserController());

  // 회원가입 완료 버튼을 누를 때 동작할 함수
  _submit() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String name = _nameController.text;

      // 회원가입 실행(await : 결과를 기다렸다가 에러 나오면 에러 출력, 잘 실행되면 다음 코드 실행)
      bool result = await userController.register(email, name, password);

      if (result == true) {
        Get.off(() => const Home());
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              '홍당무 마켓은 이메일로 가입해요. \n비밀번호는 안전하게 보관되며 \n어디에도 공개하지 않아요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 20),
            // TextFormField
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: '이메일',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력하세요';
                }
                if (value.length < 5) {
                  return '이메일이 그렇게 짧을리가 있나요';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
              labelText: '비밀번호',
                ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '비밀번호을 입력하세요';
              }
              if (value.length < 5) {
                return '비밀번호이 그렇게 짧을리가 있나요';
              }
              return null;
            },
          ),
            const SizedBox(height: 10),
            TextFormField(controller: _nameController,
              decoration: InputDecoration(
              labelText: '이름',
              ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '이름을 입력하세요';
              }
              if (value.length < 5) {
                return '이름이 그렇게 짧을리가 있나요';
              }
              return null;
            },
          ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF7E36),
              ),
              child: const Text(
                '회원 가입',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}