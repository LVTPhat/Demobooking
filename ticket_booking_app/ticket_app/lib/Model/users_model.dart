

class UsersModel{
  String? id;
  String? username;
  int? permisstion;

  UsersModel({ this.id, this.username, this.permisstion});

  factory UsersModel.fromjson(Map<String, dynamic> json){
    return UsersModel(
        id: json['id'],
        username: json['username'],
        permisstion: json['permisstion']
    );
  }
  static List<UsersModel> JsonToList(List<dynamic> jsonList){
    return jsonList.map((json) => UsersModel.fromjson(json)).toList();
  }
}