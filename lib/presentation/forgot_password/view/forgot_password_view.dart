// ignore_for_file: library_private_types_in_public_api

import 'package:antiquities/core/di.dart';
import 'package:antiquities/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:antiquities/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:antiquities/presentation/resources/assets_manager.dart';
import 'package:antiquities/presentation/resources/color_manager.dart';
import 'package:antiquities/presentation/resources/font_manager.dart';
import 'package:antiquities/presentation/resources/strings_manager.dart';
import 'package:antiquities/presentation/resources/styles_manager.dart';
import 'package:antiquities/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  bind() {
    _viewModel.start();
    _emailTextEditingController.addListener(
        () => _viewModel.setEmail(_emailTextEditingController.text));
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          AppStrings.forgetPassword,
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
                _viewModel.forgotPassword();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      constraints: const BoxConstraints.expand(),
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
                'Forgot your password?',
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
                'Enter your email address and we will send you \ninstructions on how to reset your password.',
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
                    left: AppPadding.padding28, right: AppPadding.padding28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextEditingController,
                      decoration: InputDecoration(
                          hintText: AppStrings.emailHint.tr(),
                          labelText: AppStrings.emailHint.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.invalidEmail.tr()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.size28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.padding28, right: AppPadding.padding28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputValid,
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
                                ? () => _viewModel.forgotPassword()
                                : null,
                            child: Text(AppStrings.resetPassword.tr())),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
