import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName;
  final String userPhone;

  UserEntity({
    this.userName,
    this.userPhone,
  });

  @override
  List<Object> get props => [
        userName,
        userPhone,
      ];
}
