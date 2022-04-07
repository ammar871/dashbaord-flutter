import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/constants/end-points.dart';
import 'package:flutter_web_dashboard/helpers/functions.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../Models/admin-model.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(context) => BlocProvider.of<AdminCubit>(context);

  bool loadGetAdmins = false;
  List<Admin> admins = [];


  Permission permission;
  void changeValue(Permission permission2){
    permission=permission2;
    emit(ChangeValuePermission());
  }


  getAdmins() async {
    admins = [];
    loadGetAdmins = true;
    emit(GetAdminsLoad());
    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl2 + "/auth/get-admins"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        admins.add(Admin.fromJson(e));
      });
      Admin admin =
          admins.firstWhere((element) => element.id == currentUser.id);

      admins.remove(admin);

      loadGetAdmins = false;
      emit(GetAdminsSuccess());
    } else {
      print(response.reasonPhrase);

      loadGetAdmins = false;
      emit(GetAdminsError());
    }
  }


  List<Admin> users = [];
  getUsers() async {
    users = [];
    loadGetAdmins = true;
    emit(GetUsersLoad());
    var request =
    http.MultipartRequest('GET', Uri.parse(baseUrl2 + "/auth/get-users"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        users.add(Admin.fromJson(e));
      });
      // Admin admin =
      // users.firstWhere((element) => element.id == currentUser.id);
      //
      // users.remove(admin);

      loadGetAdmins = false;
      emit(GetUsersSuccess());
    } else {
      print(response.reasonPhrase);

      loadGetAdmins = false;
      emit(GetUsersError());
    }
  }

  bool loadAddAdmin = false;

  Future addAdmin({fullName, userName, pass, permission, onSuccess}) async {
    loadAddAdmin = true;
    emit(AddAdminLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl2+"/auth/admin/signup"));
    request.fields.addAll({
      'fullName': fullName,
      'email': 'admin5@tashleeh.com',
      'userName': userName,
      'knownName': 'askdkalshkjsa',
      'Role': 'admin',
      'password': pass,
      'AccessFailedCount': permission.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      print(data);
      onSuccess();
      loadAddAdmin = false;
      emit(AddAdminSuccess());
    } else {
      print(response.reasonPhrase);
      loadAddAdmin = false;
      emit(AddAdminError());
    }
  }

  bool loadDeleteAdmin = false;

  Future deleteAdmin({userId}) async {
    loadDeleteAdmin = true;
    emit(DeleteAdminLoad());
    print(token);
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl2 + '/auth/delete-account'));
    request.fields.addAll({'id': userId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      print(data);

      loadDeleteAdmin = false;
      getAdmins();
      emit(DeleteAdminSuccess());
    } else {
      print(response.statusCode);
      loadDeleteAdmin = false;
      emit(DeleteAdminError());
    }
  }

  bool loadUpdateAdmin = false;

  Future updateAdmin({userId, permission, onSuccess,fullName}) async {
    loadAddAdmin = true;
    emit(AddAdminLoad());
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl2 + '/auth/update-account'));
    request.fields.addAll({
      'id': userId,
      'access': permission.toString(),
      'fullName': fullName
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      print(data);
      onSuccess();
      loadAddAdmin = false;
      emit(AddAdminSuccess());
    } else {
      print(response.reasonPhrase);
      loadAddAdmin = false;
      emit(AddAdminError());
    }
  }
}


class Permission{
  int id;
  String name;

  Permission({this.id, this.name});
}


List<Permission> listPermission=[
  Permission(id: 0,name: "أدمن عادى"),
  Permission(id: 1,name: "يضيف قسم ويفعل اعلان"),
  Permission(id: 2,name: "يفعل اعلان")

];

List<String> permissions=[
  "بدون صلاحيات",
  "يضيف قسم ويفعل اعلان",
  "يفعل اعلان"
];