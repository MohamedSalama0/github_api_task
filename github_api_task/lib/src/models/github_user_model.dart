
class GithubUser {
  final String? name;
  final int? userId;
  final String? avatarUrl;
  final String? htmlUrl;
  final String? bio;
  final int? publicRepos;
  final int? publicGists;
  final int? followers;
  final int? following;
  GithubUser({
    this.name,
    this.userId,
    this.avatarUrl,
    this.htmlUrl,
    this.bio,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(userId != null){
      result.addAll({'id': userId});
    }
    if(avatarUrl != null){
      result.addAll({'avatar_url': avatarUrl});
    }
    if(htmlUrl != null){
      result.addAll({'html_url': htmlUrl});
    }
    if(bio != null){
      result.addAll({'bio': bio});
    }
    if(publicRepos != null){
      result.addAll({'public_repos': publicRepos});
    }
    if(publicGists != null){
      result.addAll({'public_gists': publicGists});
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
      userId: map['id']?.toInt(),
      avatarUrl: map['avatar_url'],
      htmlUrl: map['html_url'],
      bio: map['bio'],
      publicRepos: map['public_repos']?.toInt(),
      publicGists: map['public_gists']?.toInt(),
      followers: map['followers']?.toInt(),
      following: map['following']?.toInt(),
    );
  }

}
