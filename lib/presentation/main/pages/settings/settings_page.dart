import 'package:antiquities/app/app_preferences.dart';
import 'package:antiquities/app/di.dart';
import 'package:antiquities/data/data_source/local_data_source.dart';
import 'package:antiquities/presentation/resources/assets_manager.dart';
import 'package:antiquities/presentation/resources/color_manager.dart';
import 'package:antiquities/presentation/resources/strings_manager.dart';
import 'package:antiquities/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import '../../../resources/language_manager.dart';
import '../../../resources/routes_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.padding8),
        children: [
          ListTile(
            leading: Icon(
              Icons.language,
              color: ColorManager.black,
            ), //SvgPicture.asset(ImageAssets.changeLangIc),
            title: Text(AppStrings.changeLanguage.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contacts,
              color: ColorManager.black,
            ), //SvgPicture.asset(ImageAssets.contactUsIc),
            title: Text(AppStrings.contactUs.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people_outline,
              color: ColorManager.black,
            ), //SvgPicture.asset(ImageAssets.inviteFriendsIc),
            title: Text(AppStrings.inviteYourFriends.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: ColorManager.black,
            ), //SvgPicture.asset(ImageAssets.logoutIc),
            title: Text(AppStrings.logout.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _logout();
            },
          )
        ],
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }

  _changeLanguage() {
    // i will implement it later
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs() {
    // its a task for you to open any webpage using URL
  }

  _inviteFriends() {
    // its a task for you to share app name to friends
  }

  _logout() {
    // app prefs make that user logged out
    _appPreferences.logout();

    // clear cache of logged out user
    _localDataSource.clearCache();

    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
