import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/status_model.dart';
import 'package:flutter_web_dashboard/constants/end-points.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../Models/add.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());

  static AddCubit get(context) => BlocProvider.of<AddCubit>(context);

  // List<StatusModel> status = [
  //   StatusModel(id: 0, name: "معلقة"),
  //   StatusModel(id: 1, name: "حالية"),
  //   StatusModel(id: 2, name: "مرفوضة"),
  // ];
  //
  // StatusModel newValue;
  //
  // void changeValue(StatusModel value) {
  //   newValue = value;
  //   emit(ChangeValueAdd());
  // }

  List<Add> adds = [];

  getAdds() async {
    emit(GetAddsLoadState());
    var request = http.Request('GET', Uri.parse(baseUrl + getAddsPoint));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        adds.add(Add.fromJson(e));
      });

      emit(GetAddsSuccessState(adds));
    } else {
      emit(GetAddsErrorState());
      print(response.reasonPhrase);
    }
  }

  ResponseAdds responseAdds;

  bool loadGetAllAdds = false;

  getAddsHome() async {
    loadGetAllAdds = true;
    emit(GetAddsHomeLoadState());
    var request = http.Request('GET', Uri.parse(baseUrl + getHomeAddsPoint));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("response.statusCode${response.statusCode}");
      var responseBody = await response.stream.bytesToString();
      print(response.statusCode);
      final data = jsonDecode(responseBody);
      responseAdds = ResponseAdds.fromJson(data);

      print(responseAdds.currentAdds.length);
      loadGetAllAdds = false;
      emit(GetAddsHomeSuccessState(responseAdds));
    } else {
      loadGetAllAdds = false;
      print(response.statusCode);
      emit(GetAddsHomeErrorState());
      print(response.reasonPhrase);
    }
  }


  bool loadUpdate=false;
  Future updateAdd(Add add) async {
    loadUpdate=true;
    emit(UpdateAddsLoadState());
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + updateAddPoint));

    request.fields.addAll({
      'Title': add.title,
      'Desc': add.desc,
      'Phone': add.phone,
      'PhoneWhats': add.phoneWhats,
      'Country': add.country,
      'lat': add.lat.toString(),
      'lang': add.lang.toString(),
      'Images': add.images,
      'Status': add.status.toString(),
      'AdvertiserName': add.advertiserName,
      'id': add.id.toString(),
      'UserId': add.userId,

      'CategoryId': add.categoryId.toString(),
    });



    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadUpdate=false;
      emit(UpdateAddsSuccessState());
    } else {
      loadUpdate=false;
      emit(UpdateAddsErrorState());
      print(response.reasonPhrase);
    }
  }
}
