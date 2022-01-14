import 'package:bloc/bloc.dart';
import 'package:clean_architechture/data/login/models/request/login_request.dart';
import 'package:clean_architechture/data/utils/exceptions/api_exception.dart';
import 'package:clean_architechture/domain/login/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginPressed>(
      (event, emit) async {
        try {
          emit(LoginLoadingState());
          await loginUseCase.login(
            LoginRequest(
              userName: event.userName,
              password: event.password,
            ),
          );
          if (event.isError) {
            emit(const LoginErrorState("Fake error"));
          } else {
            emit(LoginSuccessState());
          }
        } on ApiException catch (e) {
          emit(LoginErrorState(e.displayError));
        }
      },
    );
  }
}
