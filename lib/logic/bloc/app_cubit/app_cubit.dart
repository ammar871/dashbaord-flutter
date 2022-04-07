import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/general.dart';
import 'package:flutter_web_dashboard/constants/end-points.dart';
import 'package:http/http.dart' as http;
import '../../../Models/status_model.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  List<StatusModel> status = [
    StatusModel(id: 3, name: "تعديل"),
    StatusModel(id: 0, name: "معلقة"),
    StatusModel(id: 1, name: "حالية"),
    StatusModel(id: 2, name: "مرفوضة"),
  ];

  List<StatusModel> selectedItemValue =[];



  void changeValue(StatusModel value,int index) {
    selectedItemValue[index] = value;
    emit(ChangeValueAdd());
  }


  bool loadCounter = false;
General general =General();
  getCounters() async {
    loadCounter = true;
    emit(GetCountersLoadStat());
    var headers = {
      'Content-Type': 'application/json',

      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
      // If needed
      'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
      // If needed
      'Access-Control-Allow-Credentials': true
      // If  needed
    };

    final dio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));
    final response = await dio.get("/get-counters");

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // var responseBody = response.stream.bytesToString().toString();
      var decode = jsonDecode(response.toString());


      general = General.fromJson(decode);
      print(general.counterAdds);
      emit(GetCountersSuccessStat(general));
    } else {
      print("errrrrrrrrrror");
      emit(GetCountersErrorStat("error"));
    }


  }


}
