import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/response-login.dart';

String token = "";
UserModel currentUser = UserModel();

printFunction(message) {
  // ignore: avoid_print
  print(message);
}

pop(context) {
  Navigator.of(context).pop();
}

pushPage({context, page}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

// getDataUser(){
//   ShardEditor editor=ShardEditor();
//   editor.getUser().then((value) {
//
//     currentUser = value;
//     token=value.token!;
//     printFunction("cerrentUser${currentUser.token}");
//   });
// }

bool isLogin() {
  return token != "";
}

readToken() async {
  // await getBaseUrl();
  final prefs = await SharedPreferences.getInstance();

  try {
    //
    // token = (await storage.read(key: "token"));
    // currentUser.id=( await storage.read(key: "id"));
    // // currentUser.role=( await storage.read(key: "role"));
    // currentUser.accessFailedCount =( await storage.read(key: "accessFailedCount"));
    // // currentUser.fullName=( await storage.read(key: "name"));
    // // currentUser.imageUrl=( await storage.read(key: "image"));
    // printFunction("token : ${currentUser.id}");

    token = prefs.getString('token');
    currentUser.id = prefs.getString('id');
    currentUser.accessFailedCount = prefs.getInt('accessFailedCount');
    currentUser.fullName = prefs.getString('fullName');
    // currentUser.id= prefs.getString('id');
    printFunction(
        "currentUser.accessFailedCount+${currentUser.accessFailedCount}");
  } catch (e) {}
}

isRegistered() {
  return (token != "" && token != null);
}

saveToken() async {
  // const storage =  FlutterSecureStorage();
  // storage.write(key: 'token', value: token);
  // storage.write(key: 'id', value: currentUser.id);
  // storage.write(key: 'role', value: currentUser.role);
  // storage.write(key: 'image', value: currentUser.imageUrl);
  // storage.write(key: 'name', value: currentUser.fullName);

  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

// Save an String value to 'action' key.
  await prefs.setString('token', token);
  await prefs.setString('id', currentUser.id);
  await prefs.setString('fullName', currentUser.fullName);
  await prefs.setInt('accessFailedCount', currentUser.accessFailedCount);

  // await prefs.setString('image', currentUser.imageUrl);
  await prefs.setString('name', currentUser.fullName);
}


Future logOut()async{
  final prefs = await SharedPreferences.getInstance();
  // Remove data for the 'counter' key.
   await prefs.remove('token');
}