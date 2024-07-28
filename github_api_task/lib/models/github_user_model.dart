import 'dart:convert';

class GithubUser {
  final String? name;
  final int? id;
  final String? avatarUrl;
  final String? htmlUrl;
  final int? publicRepos;
  final int? publicGists;
  final int? followers;
  final int? following;
  GithubUser({
    this.name,
    this.id,
    this.avatarUrl,
    this.htmlUrl,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(id != null){
      result.addAll({'id': id});
    }
    if(avatarUrl != null){
      result.addAll({'avatarUrl': avatarUrl});
    }
    if(htmlUrl != null){
      result.addAll({'htmlUrl': htmlUrl});
    }
    if(publicRepos != null){
      result.addAll({'publicRepos': publicRepos});
    }
    if(publicGists != null){
      result.addAll({'publicGists': publicGists});
    }
    if(followers != null){
      result.addAll({'followers': followers});
    }
    if(following != null){
      result.addAll({'following': following});
    }
  
    return result;
  }

  factory GithubUser.fromJson(Map<String, dynamic> map) {
    return GithubUser(
      name: map['name'],
      id: map['id']?.toInt(),
      avatarUrl: map['avatarUrl'],
      htmlUrl: map['htmlUrl'],
      publicRepos: map['publicRepos']?.toInt(),
      publicGists: map['publicGists']?.toInt(),
      followers: map['followers']?.toInt(),
      following: map['following']?.toInt(),
    );
  }

}
