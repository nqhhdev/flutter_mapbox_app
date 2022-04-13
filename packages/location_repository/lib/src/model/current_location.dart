class CurrentUserLocationEntity {
  
  final double? latitude;
  final double? longitude;
  const CurrentUserLocationEntity({
    required this.latitude,
    required this.longitude,
  });

  static const empty = CurrentUserLocationEntity(latitude: 0, longitude: 0);
}
