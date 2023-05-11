import 'dart:async';
import 'package:antiquities/domain/models/models.dart';
import 'package:antiquities/presentation/base/baseviewmodel.dart';
import 'package:antiquities/presentation/resources/assets_manager.dart';
import 'package:antiquities/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controller for outputs

  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // onBoarding viewModel inputs

  @override
  void dispose() {
    // _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // onBoarding viewModel outputs

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //onBoarding private functions

  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStrings.onBoardingTitle1,
          AppStrings.onBoardingSubTitle1,
          ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2,
          AppStrings.onBoardingSubTitle2,
          ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3,
          AppStrings.onBoardingSubTitle3,
          ImageAssets.onBoardingLogo3,
        ),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      _list[_currentIndex],
      _list.length,
      _currentIndex,
    ));
  }
}

abstract class OnBoardingViewModelInputs {
  void onPageChanged(int index);

  //stream controller input

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  //stream controller input
  Stream get outputSliderViewObject;
}
