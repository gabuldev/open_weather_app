class CityEntity {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;
  bool isFavorite;
  CityEntity(
      {this.name,
      this.lat,
      this.lon,
      this.country,
      this.state,
      this.isFavorite = false});

  @override
  bool operator ==(covariant CityEntity other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.lat == lat &&
        other.lon == lon &&
        other.country == country &&
        other.state == state;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        lat.hashCode ^
        lon.hashCode ^
        country.hashCode ^
        state.hashCode;
  }

  CityEntity copyWith({
    String? name,
    double? lat,
    double? lon,
    String? country,
    String? state,
    bool? isFavorite,
  }) {
    return CityEntity(
        name: name ?? this.name,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        country: country ?? this.country,
        state: state ?? this.state,
        isFavorite: isFavorite ?? this.isFavorite);
  }
}
