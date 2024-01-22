import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../shared/global.dart';

final GetStorage _storage = GetStorage();

/*
 * 회원 관련된 통신을 담당하는 클래스
 */
class UserConnect extends GetConnect {
  /*
   * 회원가입
   */
  Future sendRegister(String email, String name, String password) async {
    Response response = await post('/api/user/register', {
      'email': email,
      'name': name,
      'password': password,
    });
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['access_token'];
  }

  /*
   * 로그인
   */
  Future sendLogin(String email, String password) async {
    // post 응답
    Response response = await post('/api/user/login', {
      'email': email,
      'password': password,
    });
    // post 요청의 응답 메시지의 body에 있는 access_token 반환
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['access_token'];
  }

  /*
   * 내 정보 가져오기
   */
    Future<Map> getMyInfo() async {
      Response response = await get(
      '/api/user/mypage',
      headers: {'token': await getToken},
      );
      if (response.statusCode == null) throw Exception('통신 에러');
      Map<String, dynamic> body = response.body;
      if (body['result'] == 'fail') {
        throw Exception(body['message']);
      }
      return body;
    }
    get getToken async {
      return _storage.read("access_token");
    }

    @override
  void onInit() {
    // TODO: implement onInit
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }
}
