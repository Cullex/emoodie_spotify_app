import 'package:emoodie_app/screens/search_screen.dart';
import 'package:get/get.dart';
import '../screens/splash_screen.dart';

class RoutesClass {
  static String splashScreen = '/splashScreen';
  static String getSplashScreen()=>splashScreen;

  static String searchScreen = '/searchScreen';
  static String getSearchScreen()=>searchScreen;


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: ()=> const SplashScreen()),
    GetPage(name: searchScreen, page: ()=> const SearchScreen()),
  ];
}