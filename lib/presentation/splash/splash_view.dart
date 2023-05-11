import 'dart:async';
import 'package:antiquities/presentation/resources/assets_manager.dart';
import 'package:antiquities/presentation/resources/constants_manager.dart';
import 'package:antiquities/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _time;
  // final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _time = Timer(
      const Duration(
        seconds: AppConstants.splashDelay,
      ),
      _goNext,
    );
  }

  _goNext() async {
    // _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
    // if (isUserLoggedIn) {
    //   Navigator.pushReplacementNamed(context, Routes.mainRoute);
    // } else {
    //   _appPreferences
    //       .isOnBoardingScreenViewed()
    //       .then((isOnBoardingScreenViewed) {
    //     if (isOnBoardingScreenViewed) {
    // Navigator.pushReplacementNamed(context, Routes.loginRoute);
    //       } else {
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    //       }
    //     });
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorManager.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Image(
              image: AssetImage(ImageAssets.splashLogo),
              height: 200,
            ),
            Text(
              'ANTIQUITIES',
              style: TextStyle(
                // color: ColorManager.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _time?.cancel();
    super.dispose();
  }
}
