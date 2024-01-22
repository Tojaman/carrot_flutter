import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';

import '../shared/global.dart';

final GetStorage _storage = GetStorage();

class FeedConnect extends GetConnect {
  getList() async {
    Response response = await get(
      '/api/feed',
      // headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  storeItem(String title, String price, String content, {int? imageId}) async {
    Response response = await post(
      '/api/feed',
      {
        'title': title,
        'price': price,
        'content': content,
        if (imageId != null) 'imageId': imageId,
      },
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }
  imageUpload(String name, String path) async {
    final form = FormData({'file': MultipartFile(path, filename: name)});
    Response response = await post('/api/file', form);
    if (response.statusCode == null) throw Exception('통신 에러');
    return response.body;
  }

  /**
   * 일반 함수로 구현
   * 사용 방법 : String token - getToken();
   * String getToken() {
   *  return _Stroage.read('access_token');
   */

  /**
   * Getter로 구현
   * 사용 방법 : String toekn = getToken;
  get getToken async {
    return _storage.read("access_token");
  }
  **/

  /**
   * Getter의 축약 표현
   * 사용 방법 :
   */
  get getToken => _storage.read("access_token");
  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) {
      request.headers['token'] = getToken;
      // Feed는 어차피 token 다 씀
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }
}