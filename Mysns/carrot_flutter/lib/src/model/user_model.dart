class UserModel {
  int? id;
  String? name;
  String? email;

  /*
   * 아래 형태의 jsonData(map)을 클래스에 멤버변수들에게 초기화
  {
    "id": 1,
    "name": "조형준"
    "email": "toja@naver.com"
   */
  UserModel.fromJson(Map m) {
    id = m['id'];
    name = m['name'];
    email = m['email'];

  }
}
