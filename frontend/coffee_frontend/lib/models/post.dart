class Post {
  final int id;
  final String username;
  final String? imageUrl;
  final String? videoUrl;
  final String caption;
  final int likesCount;
  final bool isLiked;

  Post({
    required this.id,
    required this.username,
    this.imageUrl,
    this.videoUrl,
    required this.caption,
    required this.likesCount,
    required this.isLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      username: json['user']['username'],
      imageUrl: json['image'],
      videoUrl: json['video'],
      caption: json['caption'],
      likesCount: json['likes_count'],
      isLiked: json['is_liked'],
    );
  }
}
