import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/admin-model.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/logic/bloc/admin-cubit/admin_cubit.dart';
import 'package:flutter_web_dashboard/pages/clients/add_admin_page.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import '../../constants/style.dart';
import '../../helpers/functions.dart';
import '../../widgets/Texts.dart';


List<String> permissions=[
  "أدمن عادى",
  "يضيف قسم ويفعل اعلان",
  "يفعل اعلان"
];


class ClientsPage extends StatefulWidget {
  const ClientsPage({ Key key }) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdminCubit.get(context).getAdmins();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        if(state is DeleteAdminLoad){
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: Colors.blue,
              ),
            ),
          );

        }


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
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                            color:currentUser.accessFailedCount == 1? Colors.blue:Colors.grey,
                            onPressed: (){
                              if(currentUser.accessFailedCount == 1){
                                pushPage(
                                    context: context,
                                    page: AddAdminPage(status:0,admin:Admin()));

                              }

                              // pushPage(
                              //     context: context,
                              //     page: AddCategoryScreen());

                            },
                            child: Center(
                              child: CustomText(
                                text: "اضافة مدير",
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  TableWidgetAdmins(
                    list:AdminCubit.get(context).admins,
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


class TableWidgetAdmins extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<Admin> list;

  TableWidgetAdmins(
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

                  DataColumn(
                    label: Text('الاسم'),
                  ),
                  DataColumn(
                    label: Text('الايميل'),
                  ),
                  DataColumn(
                    label: Text('وقت الانشاء'),
                  ),
                  DataColumn(
                    label: Text('الصلاحيات'),
                  ),
                  DataColumn(
                    label: Text('تعديل الصلاحيات'),
                  ),
                  DataColumn2(
                    label: Text("حذف"),
                    size: ColumnSize.L,
                  ),
                ],
                rows: List<DataRow>.generate(
                    list.length,
                        (index){

                      return  DataRow(cells: [

                        DataCell(CustomText(text: list[index].fullName)),
                        DataCell(CustomText(text: list[index].userName)),
                        DataCell(CustomText(text: list[index].createdAt)),
                        DataCell(CustomText(text: permissions[list[index].accessFailedCount])),
                          DataCell(Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          height: 50,
                          width: 80,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            color:currentUser.accessFailedCount==1? Colors.green:Colors.grey,
                            onPressed: () {
                              if(currentUser.accessFailedCount==1){
                                pushPage(
                                    context: context,
                                    page: AddAdminPage(status:1,admin:list[index]));
                              }

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
                            color:currentUser.accessFailedCount == 1? Colors.red:Colors.grey ,
                            onPressed: () {
                             if(currentUser.accessFailedCount == 1){
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
                                           title: list[index].fullName,
                                           weight: FontWeight.bold),
                                       content: Texts(
                                           fSize: 20,
                                           color: Colors.black,
                                           title:
                                           "هل أنت متأكد من أنك تريد حذف هذا المدير",
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
                                   AdminCubit.get(context).deleteAdmin(
                                       userId: list[index].id).then((value){

                                   });
                                 }
                               });
                             }
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