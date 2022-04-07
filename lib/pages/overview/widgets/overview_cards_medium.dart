import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/Models/general.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';


class OverviewCardsMediumScreen extends StatelessWidget {
final General  general;

OverviewCardsMediumScreen(this.general);

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
                  children: [
                    InfoCard(
                      title: "عدد الاقسام",
                      value: general.counterCategories,
                      onTap: () {},
                  topColor: Colors.orange,

                    ),
                    SizedBox(
                      width: _width / 64,
                    ),
                    InfoCard(
                      title: "عدد الاقسام الفرعية",
                      value: general.counterSub,
                  topColor: Colors.lightGreen,

                      onTap: () {},
                    ),
                  
                  ],
                ),
            SizedBox(
                      height: _width / 64,
                    ),
                  Row(
                  children: [
             
                    InfoCard(
                      title: "عدد الاعلانات",
                      value: general.counterAdds,
                  topColor: Colors.redAccent,

                      onTap: () {},
                    ),
                    SizedBox(
                      width: _width / 64,
                    ),
                    InfoCard(
                      title: "عدد العملاء",
                      value: "32",
                      onTap: () {},
                    ),
                
                  ],
                ),
      ],
    );
  }
}