import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/admin-model.dart';
import 'package:flutter_web_dashboard/helpers/functions.dart';
import 'package:flutter_web_dashboard/logic/bloc/admin-cubit/admin_cubit.dart';

import '../../helpers/helper_functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import 'clients.dart';

class AddAdminPage extends StatefulWidget {
  final int status;
  final Admin admin;

  AddAdminPage({this.status, this.admin});

  @override
  State<AddAdminPage> createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  final TextEditingController _controllerFullName = TextEditingController();

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.status);
    if (widget.status == 1) {
      AdminCubit.get(context).permission = listPermission.firstWhere(
          (element) => element.id == widget.admin.accessFailedCount);

      _controllerFullName.text = widget.admin.fullName;
      _controllerEmail.text = widget.admin.userName;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerPassword.dispose();
    _controllerEmail.dispose();
    _controllerFullName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropDownWidget(
                                  currentValue:
                                      AdminCubit.get(context).permission,
                                  selectCar: false,
                                  colorBackRound: const Color(0xffF6F6F6),
                                  textColor: Colors.black,
                                  isTwoIcons: false,
                                  iconColor: const Color(0xff515151),
                                  icon2: Icons.add_box_outlined,
                                  icon1: Icons.search,
                                  list: listPermission
                                      .map((item) => DropdownMenuItem<dynamic>(
                                          value: item,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.name,
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
                                    AdminCubit.get(context).changeValue(value);
                                  },
                                  hint: "اختار الصلاحية"),
                            ),
                            CustomText(
                              text: " الصلاحيات ",
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controllerFullName,
                          hint: "الاسم كاملا",
                          inputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        widget.status == 1
                            ? SizedBox():   CustomTextField2(
                          controller: _controllerEmail,
                          hint: "البريد الالكترونى",
                          inputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        widget.status == 1
                            ? SizedBox()
                            : CustomTextField2(
                                controller: _controllerPassword,
                                hint: "الرقم السرى",
                                inputType: TextInputType.text,
                              ),
                        SizedBox(
                          height: 20,
                        ),

                        AdminCubit.get(context).loadAddAdmin
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

                                  if (widget.status == 1) {
                                    if (isValidateUpdate()) {
                                      AdminCubit.get(context).updateAdmin(
                                          userId: widget.admin.id,
                                          fullName: _controllerFullName.text,
                                          permission: AdminCubit.get(context)
                                              .permission
                                              .id,
                                          onSuccess: () {
                                            pushPage(
                                                context: context,
                                                page: ClientsPage());
                                          });
                                    }
                                  } else {
                                    if (isValidate()) {
                                      AdminCubit.get(context).addAdmin(
                                          pass: _controllerPassword.text,
                                          userName: _controllerEmail.text,
                                          fullName: _controllerFullName.text,
                                          permission: AdminCubit.get(context)
                                              .permission
                                              .id,
                                          onSuccess: () {
                                            pushPage(
                                                context: context,
                                                page: ClientsPage());
                                          });
                                    }
                                  }

                                  // print(CategoryCubit.get(context).category.id);
                                  // if (isValidate()) {
                                  //   SubCategory cat = SubCategory(
                                  //       image: image,
                                  //       categoryId:CategoryCubit.get(context).category.id,
                                  //       nameArbice: _controllerArabic.text,
                                  //       nameEnglish: _controllerEnglish.text,
                                  //       nameFrance: _controllerFrance.text);
                                  //
                                  //   CategoryCubit.get(context)
                                  //       .addSubCategory(
                                  //     category: cat,
                                  //   )
                                  //       .then((value) {
                                  //     Navigator.pushNamed(
                                  //         context, subCategoryPageRoute);
                                  //   });
                                  // }
                                },
                                fontFamily: "",
                                text: widget.status == 1? "تعديل": "اضافة",
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

  bool isValidate() {
    if (AdminCubit.get(context).permission == null) {
      HelperFunctions.slt.notifyUser(
          message: "اختار الصلاحية", color: Colors.blue, context: context);
      return false;
    } else if (_controllerFullName.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الاسم كاملا", color: Colors.blue, context: context);
      return false;
    } else if (_controllerEmail.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب البريد الالكتروني",
          color: Colors.blue,
          context: context);
      return false;
    } else if (_controllerPassword.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الرقم السرى", color: Colors.blue, context: context);
      return false;
    } else {
      return true;
    }
  }

  bool isValidateUpdate() {
    if (AdminCubit.get(context).permission == null) {
      HelperFunctions.slt.notifyUser(
          message: "اختار الصلاحية", color: Colors.blue, context: context);
      return false;
    } else if (_controllerFullName.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الاسم كاملا", color: Colors.blue, context: context);
      return false;
    } else if (_controllerEmail.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب البريد الالكتروني",
          color: Colors.blue,
          context: context);
      return false;
    } else {
      return true;
    }
  }
}
