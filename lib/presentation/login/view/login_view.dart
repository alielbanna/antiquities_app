import 'package:antiquities/core/app_preferences.dart';
import 'package:antiquities/core/di.dart';
import 'package:antiquities/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:antiquities/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:antiquities/presentation/resources/color_manager.dart';
import 'package:antiquities/presentation/resources/font_manager.dart';
import 'package:antiquities/presentation/resources/routes_manager.dart';
import 'package:antiquities/presentation/resources/strings_manager.dart';
import 'package:antiquities/presentation/resources/styles_manager.dart';
import 'package:antiquities/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
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
          AppStrings.login,
          style: TextStyle(
            fontSize: FontSize.size13,
          ),
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                () {
                  _viewModel.login();
                },
              ) ??
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
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Let’s log you in',
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
                'Welcome back, you’ve been missed!',
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
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppStrings.username.tr(),
                        labelText: AppStrings.username.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.usernameError.tr(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.size28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError.tr(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.padding4,
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.forgotPasswordRoute,
                        );
                      },
                      child: Text(
                        AppStrings.forgetPassword.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: AppSize.size14,
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.registerRoute,
                        );
                      },
                      child: Text(
                        AppStrings.registerText.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: AppSize.size14,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.size28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.padding28,
                  right: AppPadding.padding28,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllDataValid,
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
                                  _viewModel.login();
                                }
                              : null,
                          child: Center(
                            child: Text(
                              AppStrings.register.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: ColorManager.white,
                                    fontSize: AppSize.size16,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
