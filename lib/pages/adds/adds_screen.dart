import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/Models/status_model.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/logic/bloc/add_cubit/add_cubit.dart';
import 'package:flutter_web_dashboard/logic/bloc/app_cubit/app_cubit.dart';
import 'package:flutter_web_dashboard/logic/bloc/app_cubit/app_state.dart';

import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

import '../../Models/add.dart';
import '../../constants/end-points.dart';
import '../../constants/style.dart';
import '../../widgets/Texts.dart';
import '../../widgets/custom_drop_down_widget.dart';

class AddsPage extends StatelessWidget {
  const AddsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(child: CustomTabBar(0)),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  final page;

  CustomTabBar(this.page);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      initialIndex: widget.page,
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return AddCubit.get(context).loadGetAllAdds
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.blue,
                  ),
                ),
              )
            : Column(
                children: [
                  Material(
                    elevation: 5,
                    child: Container(
                      color: Colors.white,
                      child: TabBar(
                        indicatorColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        labelStyle: TextStyle(
                          fontFamily: 'pnuR',
                          fontSize: 15,
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w700,
                        ),
                        labelColor: Colors.blue,
                        labelPadding: const EdgeInsets.symmetric(vertical: 5),
                        controller: tabController,
                        tabs: [
                          Tab(text: 'الحالية'),
                          Tab(
                            text: 'المعلقة',
                          ),
                          Tab(text: 'المرفوضة'),
                          // Tab(text: 'مسترجعة'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ListView(
                          children: [
                            TableWidgetAdds(
                              list: AddCubit.get(context)
                                  .responseAdds
                                  .currentAdds,
                              name: "JDJDJD",
                              image: "HDDDDDDD",
                              id: "1",
                              label: "الاقسام",
                              onDelete: false,
                              onUpdate: false,
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            TableWidgetAdds(
                              list:
                                  AddCubit.get(context).responseAdds.spoonAdds,
                              name: "JDJDJD",
                              image: "HDDDDDDD",
                              id: "1",
                              label: "الاقسام",
                              onDelete: false,
                              onUpdate: false,
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            TableWidgetAdds(
                              list: AddCubit.get(context)
                                  .responseAdds
                                  .unacceptableAdds,
                              name: "JDJDJD",
                              image: "HDDDDDDD",
                              id: "1",
                              label: "الاقسام",
                              onDelete: false,
                              onUpdate: false,
                            ),
                          ],
                        )
                        // OrderRefundedPage(list:OrdersProvider.getInItWatch(context).returnOrders)
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class TableWidgetAdds extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<Add> list;

  TableWidgetAdds(
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
                    label: Text('الوقت'),
                  ),
                  DataColumn(
                    label: Text('تعديل'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    list.length,
                    (index){
                      for (int i = 0; i < list.length; i++) {
                        AppCubit.get(context)
                            .selectedItemValue.add(AppCubit.get(context)
                            .status[0]);
                      }
                      return  DataRow(cells: [
                        DataCell(CustomText(text: "${list[index].id}")),
                        DataCell(CustomText(text: list[index].title)),
                        DataCell(Container(
                          child: Container(
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CachedNetworkImage(
                                imageUrl: "$baseUrlImages${list[0]}",
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
                        DataCell(CustomText(text: list[index].date)),
                        DataCell(BlocConsumer<AppCubit, AppState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {



                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              height: 50,
                              width: 100,
                              child: CustomDropDownWidget(
                                  currentValue: AppCubit.get(context)
                                      .selectedItemValue[index],
                                  selectCar: false,
                                  colorBackRound: Colors.green,
                                  textColor: Colors.white,
                                  isTwoIcons: false,
                                  iconColor: Colors.white,
                                  icon2: Icons.add_box_outlined,
                                  icon1: Icons.search,
                                  list: AppCubit.get(context)
                                      .status
                                      .map(
                                          (item) => DropdownMenuItem<dynamic>(
                                          value: item,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                              // if(widget.actionBtn!=null) IconButton(onPressed:(){
                                              //   widget.actionBtn(item.id);
                                              // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                                            ],
                                          )))
                                      .toList(),
                                  onSelect: (value) {
                                    AppCubit.get(context)
                                        .changeValue(value, index);
                                    print(AppCubit.get(context)
                                        .selectedItemValue[index]
                                        .id);

                                    // print(list[index].status);
                                    if(AppCubit.get(context)
                                        .selectedItemValue[index]
                                        .id!=3 || AppCubit.get(context)
                                        .selectedItemValue[index]
                                        .id == AppCubit.get(context)
                                        .status[list[index].status].id){
                                      Add add = Add(
                                          id: list[index].id,
                                          lat: list[index].lat,
                                          lang: list[index].lang,
                                          userId: list[index].userId,
                                          phone: list[index].phone,
                                          title: list[index].title,
                                          categoryId: list[index].categoryId,
                                          country: list[index].country,
                                          advertiserName:
                                          list[index].advertiserName,
                                          date: list[index].date,
                                          desc: list[index].desc,
                                          images: list[index].images,
                                          isImage: list[index].isImage,
                                          phoneWhats: list[index].phoneWhats,
                                          status: AppCubit.get(context)
                                              .selectedItemValue[index]
                                              .id);
                                      AddCubit.get(context)
                                          .updateAdd(add)
                                          .then((value) {
                                        AddCubit.get(context).getAddsHome();
                                      });
                                    }


                                  },
                                  hint: AppCubit.get(context)
                                      .status[list[index].status]
                                      .name),
                            );
                          },
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
