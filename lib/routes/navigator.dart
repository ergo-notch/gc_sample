import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/features/details/presentation/details_page.dart';
import 'package:sample/features/home/presentation/home_page.dart';
import 'package:sample/features/splash/presentation/splash_page.dart';

// ignore: constant_identifier_names
enum Routes { HomePage, DetailsPage }

class _Paths {
  static const String init = '/';
  static const String homePage = '/home';
  static const String detailsPage = '/details';

  static const Map<Routes, String> _pathMap = {
    Routes.HomePage: _Paths.homePage,
    Routes.DetailsPage: _Paths.detailsPage,
  };

  static String? of(Routes route) => _pathMap[route];
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    Route pageRoute({Widget page = const SplashPage()}) {
      return Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => page, settings: settings)
          : MaterialPageRoute(builder: (context) => page, settings: settings);
    }

    switch (settings.name) {
      case _Paths.init:
        return pageRoute(page: const SplashPage());
      case _Paths.homePage:
        return pageRoute(
          page: const HomePage(),
        );
      case _Paths.detailsPage:
        return pageRoute(page: const DetailsPage());
      default:
        return pageRoute(page: const SplashPage());
    }
  }

  static FutureOr push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route) ?? '/', arguments: arguments);

  static FutureOr pushReplacementNamed<T>(Routes route, [T? arguments]) => state
      ?.pushReplacementNamed(_Paths.of(route) ?? '/', arguments: arguments);

  static void pop<T>([T? arguments]) => state?.pop(arguments);

  static void popWithResult<T>(T res) => state?.pop(res);

  static NavigatorState? get state => navigatorKey.currentState;
}
