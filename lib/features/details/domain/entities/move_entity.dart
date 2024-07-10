class MoveEntity {
  final String name;
  final String url;

  MoveEntity({required this.name, required this.url});

  factory MoveEntity.fromJson(Map<String, dynamic> json) {
    return MoveEntity(name: json['move']['name'], url: json['move']['url']);
  }
}
