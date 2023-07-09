import 'package:flutter/material.dart';

class NavigationHelper{

  static void pushNamedRoute(BuildContext context, String routeName){
    Navigator.pushNamed(context, routeName);
  }

 static void pushNamedReplacement(BuildContext context, String routeName , [Object? parameters]){
    Navigator.pushReplacementNamed(context, routeName , arguments:parameters);
  }
}