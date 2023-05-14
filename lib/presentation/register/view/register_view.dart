import 'dart:io';
import 'package:antiquities/app/app_preferences.dart';
import 'package:antiquities/app/constants.dart';
import 'package:antiquities/app/di.dart';
import 'package:antiquities/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:antiquities/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:antiquities/presentation/resources/assets_manager.dart';
import 'package:antiquities/presentation/resources/color_manager.dart';
import 'package:antiquities/presentation/resources/font_manager.dart';
import 'package:antiquities/presentation/resources/routes_manager.dart';
import 'package:antiquities/presentation/resources/strings_manager.dart';
import 'package:antiquities/presentation/resources/styles_manager.dart';
import 'package:antiquities/presentation/resources/values_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();

  _bind() {
    _viewModel.start();

    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });

    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });

    _viewModel.isUserRegisteredInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          AppStrings.register,
          style: TextStyle(
            fontSize: FontSize.size13,
          ),
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(
        top: AppPadding.padding50,
      ),
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSize.size30),
            topRight: Radius.circular(AppSize.size30),
          )),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Create your account',
                style: getRegularStyle(
                  fontSize: 30,
                  color: ColorManager.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.size10,
              ),
              Text(
                'After your registration is complete, \nyou can see our opportunity products.',
                style: getRegularStyle(
                  fontSize: 14,
                  color: ColorManager.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.size60,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username.tr(),
                            labelText: AppStrings.username.tr(),
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.size18,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.padding28,
                    right: AppPadding.padding28,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (country) {
                              // update view model with code
                              _viewModel.setCountryCode(
                                  country.dialCode ?? Constants.TOKEN);
                            },
                            initialSelection: '+20',
                            favorite: const ['+39', 'FR', '+966'],
                            // optional. Shows only country name and flag
                            showCountryOnly: true,
                            hideMainText: true,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: true,
                          )),
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<String?>(
                          stream: _viewModel.outputErrorMobileNumber,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _mobileNumberEditingController,
                              decoration: InputDecoration(
                                hintText: AppStrings.mobileNumber.tr(),
                                labelText: AppStrings.mobileNumber.tr(),
                                errorText: snapshot.data,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.size18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailEditingController,
                      decoration: InputDecoration(
                        hintText: AppStrings.emailHint.tr(),
                        labelText: AppStrings.emailHint.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.size18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordEditingController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.size18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: Container(
                  height: AppSize.size40,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSize.size8),
                      ),
                      border: Border.all(color: ColorManager.grey)),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.size28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.padding28, right: AppPadding.padding28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.size60,
                        ),
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.size28),
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.register();
                                  }
                                : null,
                            child: Text(AppStrings.register.tr()),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  //top: AppPadding.padding18,
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.mainRoute,
                    );
                  },
                  child: Text(
                    AppStrings.alreadyHaveAccount.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: Text(AppStrings.photoGallery.tr()),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(AppStrings.photoCamera.tr()),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.padding8,
        right: AppPadding.padding8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(AppStrings.profilePicture.tr()),
          ),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outputProfilePicture,
            builder: (context, snapshot) {
              return _imagePicketByUser(snapshot.data);
            },
          )),
          Flexible(
            child: SvgPicture.asset(ImageAssets.photoCameraIc),
          ),
        ],
      ),
    );
  }

  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      // return image
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}


// Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           const Color(0xff272833),
//           const Color(0xff2e2b32),
//           const Color(0xff3e322f),
//           const Color(0xff6f4626),
//           const Color(0xff7f4d23),
//           const Color(0xff915420),
//           const Color(0xff9a581e),
//           const Color(0xff9f5a1d),
//           const Color(0xffa95e1b),
//           const Color(0xffb0611a),
//           const Color(0xffb86518)
//         ],
//         

//       ),
//       borderRadius: BorderRadius.circular(4.0),
//     ),
//   )