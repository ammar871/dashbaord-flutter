import 'package:flutter_web_dashboard/pages/categoryes_screen/categoryes_screen.dart';

const rootRoute = "/";

const overviewPageDisplayName = "الرئيسية";
const overviewPageRoute = "/overview";


const usersPageDisplayName = "العملاء";
const usersPageRoute = "/users";

const categoriesPageDisplayName = "الأقسام";
const categoriesPageRoute = "/categories";


const driversPageDisplayName = "الاعلانات الممولة";
const driversPageRoute = "/drivers";

const clientsPageDisplayName = "المديرون";
const clientsPageRoute = "/clients";

const authenticationPageDisplayName = "تسجيل الخروج";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}



List<MenuItem> sideMenuItemRoutes = [
 MenuItem(overviewPageDisplayName, overviewPageRoute),
 MenuItem(driversPageDisplayName, driversPageRoute),
 MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(categoriesPageDisplayName, categoriesPageRoute),
  MenuItem(usersPageDisplayName, usersPageRoute),
 MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
