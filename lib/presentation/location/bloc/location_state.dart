part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class GetLocationSuccessState extends LocationState {
  final LocationStateStatus? status;
  final CurrentUserLocationEntity? currentUserLocation;
  final LatLng? initLocation;

  const GetLocationSuccessState({
    this.status = LocationStateStatus.initial,
    this.currentUserLocation = CurrentUserLocationEntity.empty,
    this.initLocation,
  });
  @override
  List<Object?> get props => [
        status,
        currentUserLocation,
        initLocation,
      ];
}

class GetLocationFailState extends LocationState {
  final String errorMessage;

  const GetLocationFailState(this.errorMessage);
}

class GetLocationLoadingState extends LocationState{
  final LocationStateStatus? status;

  const GetLocationLoadingState({
    this.status
  });

}
