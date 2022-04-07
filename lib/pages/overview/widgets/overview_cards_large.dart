import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';

import '../../../Models/general.dart';


class OverviewCardsLargeScreen extends StatelessWidget {
  final General  general;

  OverviewCardsLargeScreen(this.general);
  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Row(
              children: [
                InfoCard(
                  title: "عدد الاعلانات",
                  value: general.counterAdds,
                  onTap: () {},
                  topColor: Colors.orange,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد الأقسام",
                  value: general.counterCategories,
                  topColor: Colors.lightGreen,
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد الأقسام الفرعية",
                  value:general.counterSub,
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
            );
  }
}