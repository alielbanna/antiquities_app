import 'package:antiquities/presentation/resources/strings_manager.dart';
import 'package:antiquities/presentation/resources/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:antiquities/presentation/main/pages/home/view/home_page.dart';
import 'package:antiquities/presentation/main/pages/notifications/notifications_page.dart';
import 'package:antiquities/presentation/main/pages/search/search_page.dart';
import 'package:antiquities/presentation/main/pages/settings/settings_page.dart';
import 'package:antiquities/presentation/resources/color_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];
  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];

  var _title = AppStrings.home.tr();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: getRegularStyle(
            color: ColorManager.white,
            fontSize: 20,
          ),
        ),
        leading: const Icon(Icons.menu),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: ColorManager.lightGrey,
        //       spreadRadius: AppSize.size1,
        //     ),
        //   ],
        // ),
        child: BottomNavigationBar(
          elevation: 0.0,
          selectedItemColor: ColorManager.brown,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: AppStrings.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search_outlined),
              label: AppStrings.search.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_outlined),
              label: AppStrings.notifications.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              label: AppStrings.settings.tr(),
            ),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
