import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';

import '../../Models/category.dart';
import '../../Models/sub_catgory.dart';
import '../../constants/end-points.dart';
import '../../helpers/helper_functions.dart';
import '../../logic/bloc/category_cubit/category_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_text_field.dart';

class AddSubCategory extends StatefulWidget {

  @override
  State<AddSubCategory> createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
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

  Category _category;
  String image = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        if (state is UpdateCategoriesLoadedImageStat) {
          image = state.image;
          print(image);
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
                        CustomDropDownWidget(
                            currentValue: CategoryCubit.get(context).category,
                            selectCar: false,
                            colorBackRound: const Color(0xffF6F6F6),
                            textColor: Colors.black,
                            isTwoIcons: false,
                            iconColor: const Color(0xff515151),
                            icon2: Icons.add_box_outlined,
                            icon1: Icons.search,
                            list:
                            CategoryCubit.get(context).listCategories
                          .map((item) => DropdownMenuItem<dynamic>(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.nameArbice,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              // if(widget.actionBtn!=null) IconButton(onPressed:(){
                              //   widget.actionBtn(item.id);
                              // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                            ],

                          )))
                          .toList(),
                            onSelect: (value) {

                              CategoryCubit.get(context).changeValue(value);

                            },
                            hint: "اختار قسم"),
                        const SizedBox(
                          height: 20,
                        ),
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
                        CategoryCubit.get(context).loadAddSub
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

                                  print(CategoryCubit.get(context).category.id);
                                  if (isValidate()) {
                                    SubCategory cat = SubCategory(
                                        image: image,
                                        categoryId:CategoryCubit.get(context).category.id,
                                        nameArbice: _controllerArabic.text,
                                        nameEnglish: _controllerEnglish.text,
                                        nameFrance: _controllerFrance.text);

                                    CategoryCubit.get(context)
                                        .addSubCategory(
                                      category: cat,
                                    )
                                        .then((value) {
                                      Navigator.pushNamed(
                                          context, subCategoryPageRoute);
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

    }
  }

  bool isValidate() {
    if (CategoryCubit.get(context).category == null) {
      HelperFunctions.slt.notifyUser(
          message: "اختار القسم",
          color: Colors.blue,
          context: context);
      return false;
    } else if (_controllerArabic.text.isEmpty) {
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
          message: "اختار الصورة", color: Colors.blue, context: context);
      return false;
    } else {
      return true;
    }
  }
}
