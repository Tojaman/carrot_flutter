import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carrot_flutter/src/widget/image_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/feed_model.dart';
import '../../shared/global.dart';
import 'index.dart';

final FeedController feedController = Get.put(FeedController());

class FeedCreate extends StatefulWidget {
  const FeedCreate({super.key});

  @override
  State<FeedCreate> createState() => _FeedCreateState();
}

class _FeedCreateState extends State<FeedCreate> {
  @override
  void initState() {
    super.initState();
    feedController.feedIndex();
  }


  int? fileId;
  final ImagePicker picker = ImagePicker();

  var inputDecoration = InputDecoration();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String price = _priceController.text;
      final String content = _contentController.text;

      // 회원가입 실행(await : 결과를 기다렸다가 에러 나오면 에러 출력, 잘 실행되면 다음 코드 실행)
      bool result = await feedController.feedCreate(
          title, price, content, fileId);

      if (result == true) {
        Get.back();
      }
    }
  }

  //작성 버튼을 누를때 동작할 함수
  void _submitForm() async {
    //현재 폼에서 별다른 오류가 없을때
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String price = _priceController.text;
      final String content = _contentController.text;
      //피드 작성 로직
      bool result =
      await feedController.feedCreate(title, content, price, fileId);
      if (result) {
        Get.back();
      }
    }
  }

  void uploadImamge() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    int id = await feedController.upload(image.name, image.path);
    setState(() {
      fileId = id;
    });
  }

  var labelTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 물건 팔기'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // 이미지 버튼
            Row(
              children: [
                ImageButton(
                  imageUrl: fileId == null
                      ? null
                      : "${Global.apiRoot}/api/file/$fileId",
                  onTap: uploadImamge,
                ),
              ],
            ),
            // 제목
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('제목', style: labelTextStyle),
                TextFormField(
                  decoration: inputDecoration,
                  controller: _titleController,
                ),
              ],
            ),
            // 가격
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('가격', style: labelTextStyle),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration,
                  controller: _priceController,
                ),
              ],
            ),
            // 내용
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('내용', style: labelTextStyle),
                TextFormField(
                  maxLines: 5,
                  decoration: inputDecoration,
                  controller: _contentController,
                ),
              ],
            ),
            // 작성 버튼
            SizedBox(height: 20), // 간격 조절
            //작성 버튼
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF7E36),
              ),
              child: const Text(
                '작성 완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            //버튼 끝
            // ElevatedButton(
            //   onPressed: () {
            //     // 작성 버튼이 눌렸을 때 수행할 로직 추가
            //     if (_formKey.currentState!.validate()) {
            //       // 폼 검증 성공 시 처리
            //       // 여기에 작성 버튼이 눌렸을 때의 로직을 추가하세요.
            //
            //     }
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.orange, // 버튼 색상 설정
            //   ),
            //   child: Text(
            //       '작성 완료', style: TextStyle(fontSize: 15, color: Colors.white)),
            // ),
          ],
        ),
      ),
    );
  }
}