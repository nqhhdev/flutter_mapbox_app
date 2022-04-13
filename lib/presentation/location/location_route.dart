import 'package:clean_architechture/presentation/location/bloc/location_bloc.dart';
import 'package:clean_architechture/presentation/location/map_ui/map_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_repository/location_repository.dart';

class LocationRoute {
  static Widget get route => RepositoryProvider(
        create: (context) => LocationRepository(),
        child: BlocProvider(
          create: (BuildContext context) => LocationBloc(
            locationRepository: context.read<LocationRepository>(),
          )..add(GetLocationEvent()),
          child: const MapLayout(),
        ),
      );
}
