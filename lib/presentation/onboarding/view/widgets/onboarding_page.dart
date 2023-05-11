import 'package:antiquities_e_commerce/domain/models/models.dart';
import 'package:antiquities_e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          _sliderObject.image,
        ),
        const SizedBox(
          height: AppSize.size12,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),

        // const SizedBox(
        //   height: AppSize.size60,
        // ),
      ],
    );
  }
}
