import 'package:bloc/bloc.dart';
import 'package:clean_architechture/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:latlng/latlng.dart';
import 'package:location_repository/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;
  LocationBloc({
    required this.locationRepository,
  }) : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(
            const GetLocationLoadingState(status: LocationStateStatus.loading));

        final _currentLocation = await locationRepository.getCurrentLocation();
        print(_currentLocation.toString());
        emit(GetLocationSuccessState(
          currentUserLocation: _currentLocation,
          status: LocationStateStatus.success,
        ));
      } on CurrentLocationFailure catch (e) {
        emit(GetLocationFailState(e.error));
        // This is important to check errors on tests.
        // Also you can see the error on the [BlocObserver.onError].
        addError(e);
      }
    });
  }
}
