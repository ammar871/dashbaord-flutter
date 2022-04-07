import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/helpers/helper_functions.dart';
import 'package:flutter_web_dashboard/logic/bloc/app_cubit/app_cubit.dart';

import '../../Models/category.dart';
import '../../constants/end-points.dart';
import '../../logic/bloc/category_cubit/category_cubit.dart';
import '../../routing/routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _controllerArabic = TextEditingController();

  final TextEditingController _controllerEnglish = TextEditingController();

  final TextEditingController _controllerFrance = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerArabic.dispose();
    _controllerEnglish.dispose();
    _controllerFrance.dispose();
  }

  String image = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        if (state is UpdateCategoriesLoadedImageStat) {
          image = state.image;
        }

        return Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black),
                        color: Colors.white),
                    padding: EdgeInsets.all(20),
                    // height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField2(
                          controller: _controllerArabic,
                          hint: "الاسم (عربي)",
                          inputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controllerEnglish,
                          hint: "الاسم (English)",
                          inputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controllerFrance,
                          hint: "الاسم (France)",
                          inputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                chooseFileUsingFilePicker().then((value) {
                                  CategoryCubit.get(context)
                                      .uploadSelectedFile(objFile: objFile)
                                      .then((value) {});
                                });
                              },
                              child: image == ""
                                  ? Icon(
                                      Icons.camera_alt,
                                      size: 100,
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          baseUrlImages + image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CategoryCubit.get(context).loadAdd
                            ? CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              )
                            : CustomButton(
                                color: Colors.blue,
                                width: double.infinity,
                                height: 50,
                                onPress: () {
                                  // print("dh");
                                  if (isValidate()) {
                                    Category cat = Category(
                                        image: image,
                                        nameArbice: _controllerArabic.text,
                                        nameEnglish: _controllerEnglish.text,
                                        nameFrance: _controllerFrance.text);

                                    CategoryCubit.get(context)
                                        .addCategory(
                                      category: cat,
                                    )
                                        .then((value) {
                                      Navigator.pushNamed(
                                          context, categoriesPageRoute);
                                    });
                                  }
                                },
                                fontFamily: "",
                                text: "اضافة",
                                isCustomColor: true,
                                redius: 0,
                                fontSize: 20,
                                textColor: Colors.white,
                                isBorder: true,
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PlatformFile objFile;
  Uint8List uploadedImage;
  Image _imageWidget;

  Future chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform
        .pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    )
        .then((value) {
      if (value != null) {
        setState(() {
          objFile = value.files.single;

          print(objFile.name);
        });
      }
    });
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      _imageWidget = Image.memory(file.bytes);
    }
  }

  bool isValidate() {
    if (_controllerArabic.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الاسم باللغة العربية",
          color: Colors.blue,
          context: context);
      return false;
    } else if (_controllerEnglish.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الاسم باللغة الانجليزية",
          color: Colors.blue,
          context: context);
      return false;
    } else if (_controllerFrance.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الاسم باللغة الفرنسية",
          color: Colors.blue,
          context: context);
      return false;
    } else if (image == "") {
      HelperFunctions.slt.notifyUser(
          message: "اختار الصورة",
          color: Colors.blue,
          context: context);
      return false;
    } else {
      return true;
    }
  }
}
