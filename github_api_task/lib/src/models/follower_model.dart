class Follower {
  final String? login;
  final String? avatarUrl;
  final int? id;
  Follower({
    this.login,
    this.avatarUrl,
    this.id,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (login != null) {
      result.addAll({'login': login});
    }
    if (avatarUrl != null) {
      result.addAll({'avatar_url': avatarUrl});
    }
    if (id != null) {
      result.addAll({'id': id});
    }

    return result;
  }

  factory Follower.fromJson(Map<String, dynamic> map) {
    return Follower(
      login: map['login'],
      avatarUrl: map['avatar_url'],
      id: map['id']?.toInt(),
    );
  }
}
