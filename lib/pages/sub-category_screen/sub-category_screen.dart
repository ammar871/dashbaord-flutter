import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/pages/sub-category_screen/update-sub-Category.dart';

import '../../Models/sub_catgory.dart';
import '../../constants/end-points.dart';
import '../../constants/style.dart';
import '../../helpers/heloprs.dart';
import '../../logic/bloc/category_cubit/category_cubit.dart';
import '../../widgets/Texts.dart';
import '../../widgets/custom_text.dart';
import 'add_subCategory_screen.dart';


class SubCategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: (context) => CategoryCubit()..getSubCategories(),
      child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            if (state is GetSubCategoriesLoadStat) {
              print("loaad");
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.blue,
                  ),
                ),
              );
            }

            else if (state is GetSubCategoriesSuccessStat) {
              print("Success");
              return Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),

                        width: 80,
                        child: MaterialButton(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            pushPage(
                                context: context,
                                page: AddSubCategory());

                          },
                          child: Center(
                            child: CustomText(
                              text: "اضافة قسم",
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableWidgetSubCategory(
                      list: state.list,
                      name: "JDJDJD",
                      image: "HDDDDDDD",
                      id: "1",
                      label: "الاقسام",
                      onDelete: state is DeleteCategoriesLoadStat
                          ? true
                          : false,
                      onUpdate: false,

                    ),
                  ],
                ),
              );
            }

            else if (state is GetCategoriesErrorStat) {
              print("Error");
              return Container(
                child: Center(
                  child: Text(
                    "حدث خطأ اثناء تحميل البيانات ",
                    style: TextStyle(
                        color: Colors.black, fontSize: 25
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }


}


class TableWidgetSubCategory extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<SubCategoryResponse> list;

  TableWidgetSubCategory({this.label,
    this.name,
    this.id,
    this.onDelete,
    this.onUpdate,
    this.image,
    this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: label,
                  color: lightGrey,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [
                  DataColumn2(
                    label: Text("Id"),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('الاسم'),
                  ),
                  DataColumn(
                    label: Text('الصورة'),
                  ),
                  DataColumn(
                    label: Text('تعـديل'),
                  ),
                  DataColumn(
                    label: Text('حذف'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    list.length,
                        (index) =>
                        DataRow(cells: [
                          DataCell(CustomText(text: "${list[index].subCategory.id}")),
                          DataCell(CustomText(text: list[index].subCategory.nameArbice)),
                          DataCell(Container(
                            child: Container(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "$baseUrlImages${list[index].subCategory.image}",
                                  height: 60,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      Center(
                                          child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          )),
                          DataCell(Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            height: 50,
                            width: 80,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: Colors.green,
                              onPressed: () {
                                pushPage(
                                    context: context,
                                    page: UpdateSubCategory(list[index].subCategory));
                              },
                              child: Center(
                                child: CustomText(
                                  text: "تعديل",
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                          DataCell(Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            height: 50,
                            width: 80,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: Colors.red,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    // return object of type Dialog
                                    return Container(
                                      // height: 200,
                                      child: AlertDialog(
                                        title: Texts(
                                            fSize: 18,
                                            color: Colors.red,
                                            title: list[index].subCategory.nameArbice,
                                            weight: FontWeight.bold),
                                        content: Texts(
                                            fSize: 20,
                                            color: Colors.black,
                                            title:
                                            "هل أنت متأكد من أنك تريد حذف هذا القسم",
                                            weight: FontWeight.bold),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          TextButton(
                                            child: Text("حذف",
                                                style: const TextStyle(
                                                    color: Colors.red)),
                                            onPressed: () {
                                              Navigator.pop(context, 1);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("الغاء"),
                                            onPressed: () {
                                              Navigator.pop(context, 0);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).then((value) {
                                  print(value);
                                  if (value == null) {
                                    return;
                                  } else if (value == 1) {
                                    CategoryCubit.get(context).deleteSubCategory(
                                        context: context, id: list[index].subCategory.id);
                                  }
                                });
                              },
                              child: Center(
                                child: CustomText(
                                  text: "حذف",
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                        ]))),
          ],
        ),
      ),
    );
  }

  Future showDialogAction(int id, BuildContext context, String name) async {
    showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return Container(
          // height: 200,
          child: AlertDialog(
            title: Texts(
                fSize: 18,
                color: Colors.red,
                title: name,
                weight: FontWeight.bold),
            content: Texts(
                fSize: 20,
                color: Colors.black,
                title: "هل أنت متأكد من أنك تريد حذف هذا القسم",
                weight: FontWeight.bold),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: Text("حذف", style: const TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
              TextButton(
                child: Text("الغاء"),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}