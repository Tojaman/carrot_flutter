import 'package:flutter/material.dart';

import '../model/feed_model.dart';
import '../shared/global.dart';

class FeedListItem extends StatelessWidget {
  // const FeedListItem({Key? key});
  final FeedModel model;
  const FeedListItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 썸네일
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            "${Global.apiRoot}/api/file/${model.imageId}",
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset('asset/고릴라.jpg', width: 100, height: 100);
            }),
        ),
        // 내용
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title ?? '제목없음',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(model.content ?? '내용없음'),
                const SizedBox(height: 6),
                Text(
                  '${model.price} 원',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            ),
          ),
        ),

        // 메뉴 및 댓글
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 16),
                  SizedBox(width: 4),
                  Text('100'),
                  SizedBox(width: 6),
                  Icon(Icons.comment_outlined, size: 16),
                  SizedBox(width: 4),
                  Text('27'),
                ],
              ),
            ],
          ),
        ), // 이 부분에 괄호를 추가하세요
      ], // 추가된 부분: Row 위젯의 괄호를 닫습니다.
    );
  }
}