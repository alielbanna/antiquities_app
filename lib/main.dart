import 'package:antiquities/core/app.dart';
import 'package:antiquities/core/di.dart';
import 'package:antiquities/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await initAppModule();

  // Set the app to only allow portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      EasyLocalization(
        path: ASSET_PATH_LOCALISATIONS,
        supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
        child: Phoenix(
          child: MyApp(),
        ),
      ),
    ),
  );
}
