class WeatherEntity {
  int? id;
  String? main;
  String? description;
  String? icon;
  WeatherEntity({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  @override
  bool operator ==(covariant WeatherEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.main == main &&
        other.description == description &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^ main.hashCode ^ description.hashCode ^ icon.hashCode;
  }

  WeatherEntity copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return WeatherEntity(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }
}
