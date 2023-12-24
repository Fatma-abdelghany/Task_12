import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_auth_provider.dart';
import '../utils/constants/colors_constants.dart';
import '../utils/constants/strings_constants.dart';
import '../widgets/customTextField.dart';

import '../widgets/customButton.dart';
import '../widgets/grey_txt.dart';
import '../widgets/red_txt.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppAuthProvider>(context, listen: false).init();

    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<AppAuthProvider>(context, listen: false).providerDispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(child: Consumer<AppAuthProvider>(
          builder: (context, appAuthProvider, _) {
            return Form(
              key: appAuthProvider.formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: appAuthProvider.emailController,
                          isPassword: false,
                          hint: StringsConstants.userNameOrEmail,
                          myPrefixIcon: Icon(
                            Icons.person_outlined,
                            color: ColorsConstants.iconColor,
                            size: 25,
                          ),
                          type: TextInputType.emailAddress,
                          validatorFun: (value) {
                            if (value == null || value == "") {
                              return StringsConstants.emailRequired;
                            }
                            if (!EmailValidator.validate(value)) {
                              return StringsConstants.validEmail;
                            } else {
                              if (!value.split('@').last.contains('gmail')) {
                                return StringsConstants.validGmail;
                              }
                            }
                            return null;
                          },
                        ),
                        const Divider(color: Color(0x9bd7d3d3)),
                        CustomTextField(
                          controller: appAuthProvider.nameController,
                          isPassword: false,
                          hint: StringsConstants.userName,
                          myPrefixIcon: const Icon(Icons.person_outlined),
                          type: TextInputType.text,
                          validatorFun: (value) {
                            if (value == null || value == "") {
                              return StringsConstants.userNameRequired;
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                    child: CustomTextField(
                      controller: appAuthProvider.passwordController,
                      isPassword: true,
                      hint: StringsConstants.password,
                      myPrefixIcon: const Icon(Icons.lock_outline_rounded),
                      type: TextInputType.emailAddress,
                      validatorFun: (value) {
                        if (value == null || value == "") {
                          return StringsConstants.passwordRequired;
                        }
                        if (value.length < 8) {
                          return StringsConstants.validPassword;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      text: StringsConstants.signUP,
                      onBtnPressed: () async {
                        await appAuthProvider.signUp(context);
                      }),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const  GreyTxt(
                        label: StringsConstants.notHaveAccount,
                      ),
                      TextButton(
                        child:const  RedTxt(label: StringsConstants.createAccount),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
