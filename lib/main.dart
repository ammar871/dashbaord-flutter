import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/controllers/menu_controller.dart';
import 'package:flutter_web_dashboard/controllers/navigation_controller.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/logic/bloc/add_cubit/add_cubit.dart';
import 'package:flutter_web_dashboard/logic/bloc/admin-cubit/admin_cubit.dart';
import 'package:flutter_web_dashboard/logic/bloc/app_cubit/app_cubit.dart';
import 'package:flutter_web_dashboard/logic/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_web_dashboard/logic/bloc/category_cubit/category_cubit.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers/functions.dart';
import 'routing/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  readToken();
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit(),
    ),
        BlocProvider<CategoryCubit>(
          create: (BuildContext context) => CategoryCubit()..getCategories(),
        ),
        BlocProvider<AddCubit>(
          create: (BuildContext context) => AddCubit()..getAddsHome(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<AdminCubit>(
          create: (BuildContext context) => AdminCubit(),
        )
      ],
      child: GetMaterialApp(
        initialRoute: authenticationPageRoute,
        unknownRoute: GetPage(
            name: '/not-found',
            page: () => PageNotFound(),
            ),
        getPages: [
          GetPage(
              name: rootRoute,
              page: () {
                return SiteLayout();
              }),
          isRegistered()?
          GetPage(
              name: overviewPageRoute, page: () => OverviewPage()):

          GetPage(
              name: authenticationPageRoute, page: () => AuthenticationPage()),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        theme: ThemeData(
          scaffoldBackgroundColor: light,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme ??
                  Theme.of(context).textTheme.bodyText1.color)
              .apply(bodyColor: Colors.black),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
        ),
        // home: AuthenticationPage(),
      ),
    );
  }
}
