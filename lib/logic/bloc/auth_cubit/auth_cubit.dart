import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/response-login.dart';
import 'package:flutter_web_dashboard/constants/end-points.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/functions.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  bool loadLogin = false;

  Future loginAdmin({userName, password,onSuccess}) async {
    loadLogin = true;
    emit(LoginAuthLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl2+"/auth/admin-login"));
    request.fields
        .addAll({'UserName': userName.toString(), 'Password': password});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);

      print(data);

      ResponseLogin userResponse = ResponseLogin.fromJson(data);
      token = "Bearer " + userResponse.token;
      currentUser =  userResponse.user;

      // if(data['driver']!=null) currentUser.driver = Driver.fromJson(data['driver']);
      await saveToken();
      printFunction("currentUser$token");

      printFunction(userResponse.token);

      loadLogin = false;
      onSuccess();
      emit(LoginAuthSuccess());
    } else {
      print(response.reasonPhrase);
      loadLogin = false;
      emit(LoginAuthError());
    }
  }
}
