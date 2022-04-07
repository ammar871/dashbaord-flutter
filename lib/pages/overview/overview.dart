import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/available_drivers_table.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/revenue_section_large.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import '../../logic/bloc/app_cubit/app_cubit.dart';
import '../../logic/bloc/app_cubit/app_state.dart';
import 'widgets/revenue_section_small.dart';

class OverviewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()..getCounters(),
      child: BlocConsumer<AppCubit, AppState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            if (state is GetCountersLoadStat) {

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

            else  if (state is GetCountersSuccessStat) {

              print("Success${AppCubit.get(context).general.counterAdds}");
              return Container(
                child: Column(
                  children: [
                    Obx(
                          () => Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  top: ResponsiveWidget.isSmallScreen(context)
                                      ? 56
                                      : 6),
                              child: CustomText(
                                text: menuController.activeItem.value,
                                size: 24,
                                weight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                          children: [
                            if (ResponsiveWidget.isLargeScreen(context) ||
                                ResponsiveWidget.isMediumScreen(context))
                              if (ResponsiveWidget.isCustomSize(context))
                                OverviewCardsMediumScreen(state.general)
                              else
                                OverviewCardsLargeScreen(state.general)
                            else
                              OverviewCardsSmallScreen(state.general),
                            if (!ResponsiveWidget.isSmallScreen(context))
                              RevenueSectionLarge()
                            else
                              RevenueSectionSmall(),
                            AvailableDriversTable(),
                          ],
                        ))
                  ],
                ),
              );
            }

            else  if (state is GetCountersErrorStat) {

              print("Error");
              return Container(
                child: Center(
                  child: Text(
                    "حدث خطأ اثناء تحميل البيانات ",
                    style: TextStyle(
                      color: Colors.black,fontSize: 25
                    ),
                  ),
                ),
              );
            }else {
              return Container();
            }

          }),
    );
  }

}
