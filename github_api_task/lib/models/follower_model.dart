import 'dart:convert';

class FollowerModel {
  final String? login;
  final int? id;
  FollowerModel({
    this.login,
    this.id,
  });
  

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
  
    if(login != null){
      result.addAll({'login': login});
    }
    if(id != null){
      result.addAll({'id': id});
    }
  
    return result;
  }

  factory FollowerModel.fromJson(Map<String, dynamic> map) {
    return FollowerModel(
      login: map['login'],
      id: map['id']?.toInt(),
    );
  }


}
