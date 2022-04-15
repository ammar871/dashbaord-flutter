import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/sub_catgory.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_dashboard/Models/category.dart';

import 'package:meta/meta.dart';


import '../../../constants/end-points.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);
  List<Category> listCategories = [];

  /* getCategories() async {
    _listCategories = [];
    emit(GetCategoriesLoadStat());
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

    final url = "$baseUrl$getCategoriesPoint";
    final response = await http.get(Uri.parse(url), headers: headers);
    print("${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data.forEach((e) {
        _listCategories.add(Category.fromJson(e) );
      });
      // print(decode);
      emit(GetCategoriesSuccessStat(_listCategories));
    } else {
      print("errrrrrrrrrror");
      emit(GetCategoriesErrorStat("error"));
    }
  }*/
 Category category;
  void changeValue(Category category2){
    category=category2;
    emit(ChangeValueSubCategory());
  }

bool loadCategories=false;
  getCategories() async {
   listCategories = [];
   loadCategories=true;
    emit(GetCategoriesLoadStat());
    var request =
        http.MultipartRequest('GET', Uri.parse("$baseUrl$getCategoriesPoint"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listCategories.add(Category.fromJson(e));
      });
      loadCategories=false;
      emit(GetCategoriesSuccessStat(listCategories));
    } else {
      loadCategories=false;
      print(response.reasonPhrase);
    }
  }

  bool loadDelete = false;

  deleteCategory({id, context}) async {
    loadDelete = true;
    emit(GetCategoriesLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + deleteCategoryPoints));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDelete = false;

      emit(DeleteCategoriesSuccessStat("تم حذف العنصر"));

      getCategories();
    } else {
      loadDelete = false;
      print(response.reasonPhrase);
      emit(DeleteCategoriesErrorStat("حدث خطأ"));
    }
  }

  bool loadUpdate=false;
 Future updateCategory({category}) async {
   loadUpdate=true;
    emit(UpdateCategoriesLoadStat());
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + updateCategoryPoint));
    request.fields.addAll({
      'nameArbice': category.nameArbice,
      'nameEnglish': category.nameEnglish,
      'nameFrance': category.nameFrance,
      'image': category.image,
      'id': "${category.id}"
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadUpdate=false;

      emit(UpdateCategoriesSuccessStat("success"));
      // getCategories();
    } else {
      loadUpdate=false;
      print(response.reasonPhrase);
      emit(UpdateCategoriesErrorStat("Error"));
    }
  }


  bool loadAdd=false;
  Future addCategory({category}) async {
    loadAdd=true;
    emit(AddCategoriesLoadStat());
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl+ addCategoryPoint));
    request.fields.addAll({


    });

    request.fields.addAll({
      'nameArbice': category.nameArbice,
      'nameEnglish': category.nameEnglish,
      'nameFrance': category.nameFrance,
      'image': category.image,
    });


    http.StreamedResponse response = await request.send();






    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAdd=false;
getCategories();
      emit(AddCategoriesSuccessStat("success"));
      // getCategories();
    } else {
      loadAdd=false;
      print(response.reasonPhrase);
      emit(AddCategoriesErrorStat("Error"));
    }
  }

// sub Category
  List<SubCategoryResponse> _listSubCategories = [];

  getSubCategories() async {
    _listSubCategories = [];
    emit(GetSubCategoriesLoadStat());
    var request =
    http.MultipartRequest('GET', Uri.parse("$baseUrl$getSubCategoriesPoint"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        _listSubCategories.add(SubCategoryResponse.fromJson(e));
      });
      emit(GetSubCategoriesSuccessStat(_listSubCategories));
    } else {
      print(response.reasonPhrase);
    }
  }

  bool loadDeleteSub = false;

  deleteSubCategory({id, context}) async {
    loadDeleteSub = true;
    emit(GetSubCategoriesLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + deleteSubCategoryPoints));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDeleteSub = false;

      emit(DeleteSubCategoriesSuccessStat("تم حذف العنصر"));

      getSubCategories();
    } else {
      loadDeleteSub = false;
      print(response.reasonPhrase);
      emit(DeleteSubCategoriesErrorStat("حدث خطأ"));
    }
  }

  bool loadUpdateSub=false;
  Future updateSubCategory({category}) async {
    loadUpdateSub=true;
    emit(UpdateSubCategoriesLoadStat());
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl + updateSubCategoryPoint));
    request.fields.addAll({
      'nameArbice': category.nameArbice,
      'nameEnglish': category.nameEnglish,
      'nameFrance': category.nameFrance,
      'image': category.image,
      'id': "${category.id}"
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadUpdateSub=false;
print(response.statusCode);
      emit(UpdateSubCategoriesSuccessStat("success"));
      // getCategories();
    } else {
      loadUpdateSub=false;
      print(response.reasonPhrase);
      emit(UpdateSubCategoriesErrorStat("Error"));
    }
  }


  bool loadAddSub=false;
  Future addSubCategory({category}) async {
    loadAddSub=true;
    emit(AddSubCategoriesLoadStat());
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl+ addSubCategoryPoint));
    request.fields.addAll({


    });

    request.fields.addAll({
      'nameArbice': category.nameArbice,
      'nameEnglish': category.nameEnglish,
      'nameFrance': category.nameFrance,
      'image': category.image,
      'CategoryId': category.categoryId.toString(),
    });


    http.StreamedResponse response = await request.send();






    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAddSub=false;

      emit(AddSubCategoriesSuccessStat("success"));
      // getCategories();
    } else {
      loadAddSub=false;
      print(response.reasonPhrase);
      emit(AddSubCategoriesErrorStat("Error"));
    }
  }

  Future uploadSelectedFile({objFile}) async {
    emit(UpdateCategoriesLoadImageStat());
    //---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl+uploadImagePoint),
    );
    //-----add other fields if needed


    //-----add selected file with request
    request.files.add(new http.MultipartFile(
        "file", objFile.readStream, objFile.size,
        filename: objFile.name));

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
    emit(UpdateCategoriesLoadedImageStat(result));
  }
}
