class StatEntity {
  final String? name;
  final int? baseStat;

  StatEntity({
    this.name,
    this.baseStat,
  });

  factory StatEntity.fromJson(Map<String, dynamic> json) {
    return StatEntity(
      name: json['stat']['name'],
      baseStat: json['base_stat'],
    );
  }
}
