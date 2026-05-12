class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String watchId;
  final double rating;
  final String comment;
  final DateTime date;
  final int helpfulCount;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.watchId,
    required this.rating,
    required this.comment,
    required this.date,
    this.helpfulCount = 0,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userImage: json['userImage'] ?? '',
      watchId: json['watchId'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      helpfulCount: json['helpfulCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'watchId': watchId,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'helpfulCount': helpfulCount,
    };
  }
}