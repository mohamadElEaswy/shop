class UserModel{

  late bool status;
  late dynamic message;
  UserData? userData;
  UserModel({required this.status, required this.message, required this.userData});
  UserModel.fromJson(Map<String, dynamic> json){
    status = json['status'] as bool;
    message = json['message'] as dynamic;
    if (json['data'] != null) {
      userData = UserData.fromJson(json['data']);
    }
    else {
      print('Error from user model');
    }

  }
}


class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late dynamic points;
  late dynamic credit;
  late String token;
  UserData({required this.id, required this.name,
    required this.email, required this.phone, required this.image,
    required this.points, required this.credit, required this.token,});
  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'] as int;
    name = json['name'] as String;
    email = json['email'] as String;
    phone = json['phone'] as String;
    image = json['image'] as String;
    points = json['points'] as dynamic;
    credit = json['credit'] as dynamic;
    token = json['token'] as String;

  }
}