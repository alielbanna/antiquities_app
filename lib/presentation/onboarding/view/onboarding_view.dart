// ignore_for_file: prefer_final_fields

import 'package:antiquities/domain/models/models.dart';
import 'package:antiquities/presentation/onboarding/view/widgets/onboarding_page.dart';
import 'package:antiquities/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:antiquities/presentation/resources/color_manager.dart';
import 'package:antiquities/presentation/resources/routes_manager.dart';
import 'package:antiquities/presentation/resources/strings_manager.dart';
import 'package:antiquities/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  // final AppPreferences _appPreferences = instance<AppPreferences>();

  // ignore: unused_field
  bool _isLast = false;

  _bind() {
    // _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        // appBar: AppBar(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSize.size20,
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.padding10),
                child: Row(
                  children: [
                    const Spacer(),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: sliderViewObject.numOfSlides,
                      effect: ExpandingDotsEffect(
                        dotColor: ColorManager.grey,
                        activeDotColor: ColorManager.brown,
                        dotHeight: 5.0,
                        dotWidth: 5.0,
                        expansionFactor: 4.0,
                        spacing: 5.0,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemCount: sliderViewObject.numOfSlides,
                  onPageChanged: (index) {
                    // _viewModel.onPageChanged(index);
                    _viewModel.onPageChanged(index);
                  },
                  itemBuilder: (context, index) =>
                      OnBoardingPage(sliderViewObject.sliderObject),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.loginRoute,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.size60,
                  ),
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppSize.size28)),
                      border: Border.all(color: ColorManager.white),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.login,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.size12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.registerRoute,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.size60,
                  ),
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorManager.gold,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppSize.size28)),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.register,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.size20,
              ),
            ],
          ),
        ),
      );
    }
  }
}
