import 'package:clean_architechture/data/login/api/login_api.dart';
import 'package:clean_architechture/data/login/models/request/login_request.dart';
import 'package:clean_architechture/data/login/models/response/login_response.dart';
import 'package:clean_architechture/domain/login/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApi api;

  LoginRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // await api
    //     .login(request)
    //     .catchError((e, stack) => throw ApiException.error(e, stack));
    await Future.delayed(const Duration(seconds: 3));
    return const LoginResponse(
      userName: "UserName",
      userPhone: "phone",
      email: "email",
      createdAt: '',
    );
  }
}
