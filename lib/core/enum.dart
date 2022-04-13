part of "core.dart";

extension EnumExt on Enum {
  static Enum? enumFromString(String? key, Iterable<Enum> values) =>
      values.firstWhereOrNull((v) => key == v.name);
}

enum LocationStateStatus { initial, success, error, loading }

extension LocationStateStatusX on LocationStateStatus {
  bool get isInitial => this == LocationStateStatus.initial;
  bool get isSuccess => this == LocationStateStatus.success;
  bool get isError => this == LocationStateStatus.error;
  bool get isLoading => this == LocationStateStatus.loading;
}