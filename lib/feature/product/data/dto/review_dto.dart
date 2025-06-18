
class ReviewDto {
  const ReviewDto({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  factory ReviewDto.fromJson(Map<String, dynamic> json) => ReviewDto(
    rating: json['rating'] as int,
    comment: json['comment'] as String,
    date: DateTime.parse(json['date'] as String),
    reviewerName: json['reviewerName'] as String,
    reviewerEmail: json['reviewerEmail'] as String,
  );

}
