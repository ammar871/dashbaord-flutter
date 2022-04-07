import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/functions.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';

import '../routing/routes.dart';
import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 40,
                        height: 40,
                      )),
                ),
              ],
            )
          : IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                key.currentState.openDrawer();
              }),
      title: Container(
        child: Row(
          children: [
            Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: CustomText(
                  text: "Donya",
                  color: lightGrey,
                  size: 20,
                  weight: FontWeight.bold,
                )),
            Expanded(child: Container()),
            // IconButton(icon: Icon(Icons.settings, color: dark,), onPressed: (){}),

            Container(
              width: 1,
              height: 22,
              color: lightGrey,
            ),
            SizedBox(
              width: 24,
            ),
            CustomText(
              text: "${currentUser.fullName}",
              color: lightGrey,
            ),
            SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  color: active.withOpacity(.5),
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: light,
                  child: Icon(
                    Icons.person_outline,
                    color: dark,
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: dark.withOpacity(.7),
                    ),
                    onPressed: () {

                        logOut().then((value){
                          // Get.to(AuthenticationPage());
                         pushPage(page: AuthenticationPage(),context: context);
                          // menuController.changeActiveItemTo(overviewPageDisplayName);
                        });


                    }),
                // Positioned(
                //   top: 7,
                //   right: 7,
                //   child: Container(
                //     width: 12,
                //     height: 12,
                //     padding: EdgeInsets.all(4),
                //     decoration: BoxDecoration(
                //       color: active,
                //       borderRadius: BorderRadius.circular(30),
                //       border: Border.all(color: light, width: 2)
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
      iconTheme: IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
