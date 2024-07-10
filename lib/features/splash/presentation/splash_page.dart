import 'package:flutter/material.dart';
import 'package:sample/core/utils/app_images.dart';

import '../../../routes/navigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),
        () => AppNavigator.pushReplacementNamed(Routes.HomePage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text(
          'Bienvenido!',
          style: TextStyle(
              fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Image.asset(AppImages.pokeballImage),
        const Center(
          heightFactor: 1,
          widthFactor: 1,
          child: SizedBox(
            height: 46,
            width: 46,
            child: CircularProgressIndicator(
              strokeWidth: 1.8,
              color: Colors.yellow,
            ),
          ),
        ),
      ])),
    );
  }
}
