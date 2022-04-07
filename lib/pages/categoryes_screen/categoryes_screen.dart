
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/logic/bloc/category_cubit/category_cubit.dart';
import 'package:flutter_web_dashboard/pages/categoryes_screen/AddCategory_screen.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/tabel_widet.dart';

import '../../helpers/heloprs.dart';
import '../../widgets/custom_text.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryCubit.get(context).getSubCategories();
  }
  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<CategoryCubit, CategoryState>(
        listener: (ctx, state) {},
        builder: (ctx, state) {


            return CategoryCubit.get(context).loadCategories?

            Container(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.blue,
                ),
              ),
            ):
            Padding(
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
                        onPressed: (){

                          pushPage(
                              context: context,
                              page: AddCategoryScreen());

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
                  TableWidgetCategory(
                    list:CategoryCubit.get(context).listCategories,
                    name: "JDJDJD",
                    image: "HDDDDDDD",
                    id: "1",
                    label: "الاقسام",
                    onDelete:state is DeleteCategoriesLoadStat ?true :false ,
                    onUpdate:false ,

                  ),
                ],
              ),
            );






        });



  }
}
