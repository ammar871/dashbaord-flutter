import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';

import 'package:flutter_web_dashboard/Models/category.dart';
import 'package:flutter_web_dashboard/constants/end-points.dart';
import 'package:flutter_web_dashboard/helpers/heloprs.dart';
import 'package:flutter_web_dashboard/logic/bloc/category_cubit/category_cubit.dart';
import 'package:flutter_web_dashboard/pages/update_category/update_Category.dart';

import '../constants/style.dart';
import 'Texts.dart';
import 'custom_text.dart';

class TableWidgetCategory extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<Category> list;

  TableWidgetCategory(
      {this.label,
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
                    (index) => DataRow(cells: [
                          DataCell(CustomText(text: "${list[index].id}")),
                          DataCell(CustomText(text: list[index].nameArbice)),
                          DataCell(Container(
                            child: Container(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "$baseUrlImages${list[index].image}",
                                  height: 60,
                                  width: 100,
                                  placeholder: (context, url) => Center(
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
                                    page: UpdateCategory(list[index]));
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
                                            title: list[index].nameArbice,
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
                                    CategoryCubit.get(context).deleteCategory(
                                        context: context, id: list[index].id);
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
