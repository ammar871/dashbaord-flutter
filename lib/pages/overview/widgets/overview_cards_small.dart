import 'package:flutter/material.dart';
import '../../../Models/general.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  final General  general;

  OverviewCardsSmallScreen(this.general);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "عدد الاعلانات",
            value: general.counterAdds,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "عدد الاقسام",
            value: general.counterCategories,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          //xmxjk,x
          InfoCardSmall(
            title: "عدد الاقسام الفرعية",
            value: general.counterSub,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "عدد العملاء ",
            value: "32",
            onTap: () {},
          )
        ],
      ),
    );
  }
}
