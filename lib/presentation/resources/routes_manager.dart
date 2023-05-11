import 'package:antiquities_e_commerce/presentation/forgot_password/forgot_password_view.dart';
import 'package:antiquities_e_commerce/presentation/login/login_view.dart';
import 'package:antiquities_e_commerce/presentation/main/main_view.dart';
import 'package:antiquities_e_commerce/presentation/onboarding/view/onboarding_view.dart';
import 'package:antiquities_e_commerce/presentation/product/product_details_view.dart';
import 'package:antiquities_e_commerce/presentation/register/register_view.dart';
import 'package:antiquities_e_commerce/presentation/resources/strings_manager.dart';
import 'package:antiquities_e_commerce/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String productDetailsRoute = '/productDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingView(),
        );

      case Routes.loginRoute:
        // initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );

      case Routes.registerRoute:
        // initRegisterModule();
        return MaterialPageRoute(
          builder: (_) => const RegisterView(),
        );

      case Routes.forgotPasswordRoute:
        // initForgotPasswordModule();
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordView(),
        );
      case Routes.mainRoute:
        // initHomeModule();
        return MaterialPageRoute(
          builder: (_) => const MainView(),
        );
      case Routes.productDetailsRoute:
        // initStoreDetailsModule();
        return MaterialPageRoute(
          builder: (_) => const ProductDetailsView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(
            child: Text(AppStrings.noRouteFound),
          ),
        ),
      );
}
