
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import '../../Models/admin-model.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../logic/bloc/admin-cubit/admin_cubit.dart';
import '../../widgets/Texts.dart';
import '../../widgets/custom_text.dart';

class UsersScreen extends StatefulWidget {


  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdminCubit.get(context).getUsers();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {



        return  AdminCubit.get(context).loadGetAdmins?

        Container(
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: Colors.blue,
            ),
          ),
        ):Container(
          child: Column(
            children: [
              Obx(() =>
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top:
                          ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                          child: CustomText(
                            text: menuController.activeItem.value,
                            size: 24,
                            weight: FontWeight.bold,)),
                    ],
                  ),),

              Expanded(
                  child: ListView(
                    children: [


                      TableWidgetUsers(
                        list:AdminCubit.get(context).users,
                        name: "JDJDJD",
                        image: "HDDDDDDD",
                        id: "1",
                        label: "الاقسام",
                        onDelete:false ,
                        onUpdate:false ,

                      ),
                    ],
                  )),

            ],
          ),
        );
      },
    );
  }
}


class TableWidgetUsers extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<Admin> list;

  TableWidgetUsers(
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
                // SizedBox(
                //   width: 10,
                // ),
                // CustomText(
                //   text: label,
                //   color: lightGrey,
                //   weight: FontWeight.bold,
                // ),
              ],
            ),
            DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [


                  DataColumn(
                    label: Text('الاسم',style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  DataColumn(
                    label: Text('موبايل',style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('وقت الانشاء',style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('id',style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                  // DataColumn(
                  //   label: Text('تعديل الصلاحيات'),
                  // ),
                  // DataColumn2(
                  //   label: Text("حذف"),
                  //   size: ColumnSize.L,
                  // ),
                ],
                rows: List<DataRow>.generate(
                    list.length,
                        (index){
                          DateTime now = DateTime.parse(list[index].createdAt.toString());
                          String formattedDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(now);
                      return  DataRow(cells: [


                        DataCell(CustomText(text: list[index].fullName)),
                        DataCell(CustomText(text: list[index].userName)),
                        DataCell(CustomText(text: formattedDate)),
                        DataCell(CustomText(text: list[index].id)),
                        // DataCell(Container(
                        //   margin: EdgeInsets.symmetric(vertical: 5),
                        //   height: 50,
                        //   width: 80,
                        //   child: MaterialButton(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(4)),
                        //     color:currentUser.accessFailedCount==1? Colors.green:Colors.grey,
                        //     onPressed: () {
                        //       if(currentUser.accessFailedCount==1){
                        //         pushPage(
                        //             context: context,
                        //             page: AddAdminPage(status:1,admin:list[index]));
                        //       }
                        //
                        //     },
                        //     child: Center(
                        //       child: CustomText(
                        //         text: "تعديل",
                        //         color: Colors.white,
                        //         weight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // )),
                        // DataCell(Container(
                        //   margin: EdgeInsets.symmetric(vertical: 5),
                        //   height: 50,
                        //   width: 80,
                        //   child: MaterialButton(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(4)),
                        //     color:currentUser.accessFailedCount == 1? Colors.red:Colors.grey ,
                        //     onPressed: () {
                        //       if(currentUser.accessFailedCount == 1){
                        //         showDialog(
                        //           context: context,
                        //           builder: (context) {
                        //             // return object of type Dialog
                        //             return Container(
                        //               // height: 200,
                        //               child: AlertDialog(
                        //                 title: Texts(
                        //                     fSize: 18,
                        //                     color: Colors.red,
                        //                     title: list[index].fullName,
                        //                     weight: FontWeight.bold),
                        //                 content: Texts(
                        //                     fSize: 20,
                        //                     color: Colors.black,
                        //                     title:
                        //                     "هل أنت متأكد من أنك تريد حذف هذا المدير",
                        //                     weight: FontWeight.bold),
                        //                 actions: <Widget>[
                        //                   // usually buttons at the bottom of the dialog
                        //                   TextButton(
                        //                     child: Text("حذف",
                        //                         style: const TextStyle(
                        //                             color: Colors.red)),
                        //                     onPressed: () {
                        //                       Navigator.pop(context, 1);
                        //                     },
                        //                   ),
                        //                   TextButton(
                        //                     child: Text("الغاء"),
                        //                     onPressed: () {
                        //                       Navigator.pop(context, 0);
                        //                     },
                        //                   ),
                        //                 ],
                        //               ),
                        //             );
                        //           },
                        //         ).then((value) {
                        //           print(value);
                        //           if (value == null) {
                        //             return;
                        //           } else if (value == 1) {
                        //             AdminCubit.get(context).deleteAdmin(
                        //                 userId: list[index].id).then((value){
                        //
                        //             });
                        //           }
                        //         });
                        //       }
                        //     },
                        //     child: Center(
                        //       child: CustomText(
                        //         text: "حذف",
                        //         color: Colors.white,
                        //         weight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // )),
                      ]);
                    })),
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