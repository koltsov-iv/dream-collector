class Statement {
  final String id;
  final String comment;
  final String description;

  const Statement({
    required this.id,
    required this.comment,
    required this.description,
  });

  factory Statement.fromJson(Map<String, dynamic> json) {
    return Statement(
        id: json['id'],
        comment: json['comment'] ?? "",
        description: json['description'],
    );
  }
}
