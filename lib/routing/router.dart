import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/adds/adds_screen.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';

import 'package:flutter_web_dashboard/pages/categoryes_screen/categoryes_screen.dart';
import 'package:flutter_web_dashboard/pages/clients/add_admin_page.dart';
import 'package:flutter_web_dashboard/pages/clients/clients.dart';

import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/pages/sub-category_screen/sub-category_screen.dart';

import 'package:flutter_web_dashboard/pages/users_screen/users_screen.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case driversPageRoute:
      return _getPageRoute(AddsPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());

    case categoriesPageRoute:
      return _getPageRoute(CategoriesScreen());

    case usersPageRoute:
      return _getPageRoute(UsersScreen());

    case subCategoryPageRoute:
      return _getPageRoute(SubCategoryScreen());

    case authenticationPageRoute:
      return _getPageRoute(AuthenticationPage());

    case addAdminPageDisplayName:
      return _getPageRoute(AddAdminPage());

    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}