import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/sub_catgory.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';

import '../../constants/end-points.dart';
import '../../logic/bloc/category_cubit/category_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class UpdateSubCategory extends StatefulWidget {
 final SubCategory subCategory;


 UpdateSubCategory(this.subCategory);

  @override
  State<UpdateSubCategory> createState() => _UpdateSubCategoryState();
}

class _UpdateSubCategoryState extends State<UpdateSubCategory> {
  final TextEditingController _controllerArabic = TextEditingController();

  final TextEditingController _controllerEnglish = TextEditingController();

  final TextEditingController _controllerFrance = TextEditingController();
  String imagePath = "";
  SubCategory _category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.subCategory != null) {
      _category=widget.subCategory;
      _controllerArabic.text = widget.subCategory.nameArbice;
      _controllerFrance.text = widget.subCategory.nameFrance;
      _controllerEnglish.text = widget.subCategory.nameEnglish;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerArabic.dispose();
    _controllerEnglish.dispose();
    _controllerFrance.dispose();
  }
  String image="";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {

        if(state is UpdateCategoriesLoadedImageStat){
          image =state.image;

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
                          inputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controllerEnglish,
                          hint: "الاسم (English)",
                          inputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controllerFrance,
                          hint: "الاسم (France)",
                          inputType:TextInputType.text,
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

                                  CategoryCubit.get(context).uploadSelectedFile(objFile: objFile).then((value) {


                                  });
                                });
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    image==""?   baseUrlImages + widget.subCategory.image:
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
                        state is UpdateSubCategoriesLoadStat
                            ? CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        )
                            : CustomButton(
                          color: Colors.blue,
                          width: double.infinity,
                          height: 50,
                          onPress: () {
                            print("dh");
                            if(image==""){
                              SubCategory cat=SubCategory(
                                  id: widget.subCategory.id,
                                  categoryId: widget.subCategory.categoryId,
                                  image: widget.subCategory.image,
                                  nameArbice: _controllerArabic.text,
                                  nameEnglish: _controllerEnglish.text,
                                  nameFrance: _controllerFrance.text
                              );

                              CategoryCubit.get(context)
                                  .updateSubCategory(category: cat,
                              ).then((value) {
                                Navigator.pushNamed(
                                    context, subCategoryPageRoute);
                              });
                            }else{
                              SubCategory cat=SubCategory(
                                  id: widget.subCategory.id,
                                  categoryId: widget.subCategory.categoryId,
                                  image: image,
                                  nameArbice: _controllerArabic.text,
                                  nameEnglish: _controllerEnglish.text,
                                  nameFrance: _controllerFrance.text
                              );

                              CategoryCubit.get(context)
                                  .updateSubCategory(category: cat).then((value) {

                                Navigator.pushNamed(
                                    context, subCategoryPageRoute);
                              });
                            }

                          },
                          fontFamily: "",
                          text: "تعديل",
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
}