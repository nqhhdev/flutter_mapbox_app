import 'package:clean_architechture/data/login/data_sources/remote/login_api.dart';
import 'package:clean_architechture/data/login/models/request/login_request.dart';
import 'package:clean_architechture/data/login/models/response/login_response.dart';
import 'package:clean_architechture/domain/login/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApi api;

  LoginRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      // final loginResponse = await api.login(request);
      await Future.delayed(const Duration(seconds: 3));
      return LoginResponse(
          userName: "UserName", phone: "phone", email: "email", createdAt: '');
    } catch (e) {
      throw Exception('Unexpected Exception $e');
    }
  }
}
