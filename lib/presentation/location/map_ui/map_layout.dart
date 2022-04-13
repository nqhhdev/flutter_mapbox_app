import 'package:clean_architechture/presentation/location/bloc/location_bloc.dart';
import 'package:clean_architechture/presentation/location/widgets/location_error_widget.dart';
import 'package:clean_architechture/presentation/location/widgets/map_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_repository/location_repository.dart';

class MapLayout extends StatelessWidget {
  const MapLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        buildWhen: (previous, current) =>
            current is GetLocationFailState ||
            current is GetLocationLoadingState ||
            current is GetLocationSuccessState,
        builder: (context, state) {
          if (state is GetLocationSuccessState) {
            return MapSuccessWidget(
              currentUserLocation: state.currentUserLocation ??
                  const CurrentUserLocationEntity(
                      latitude: 20.9301, longitude: 106.1945),
            );
          }
          if (state is GetLocationFailState) {
            return LocationErrorWidget(
              errorMessage: state.errorMessage,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
