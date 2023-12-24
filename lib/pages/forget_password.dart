import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../utils/constants/colors_constants.dart';
import '../utils/constants/strings_constants.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextField.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late GlobalKey<FormState> formKey;

  TextEditingController? EmailController;

  @override
  void initState() {
    // TODO: implement initState
    formKey = GlobalKey<FormState>();
    EmailController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              // Center(child: GreyTxt(label: StringsConstants.forgetPasswordHint,)),
              Text(
                StringsConstants.forgetPasswordHint,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: CustomTextField(
                  controller: EmailController,
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
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: StringsConstants.sendEmail,
                  onBtnPressed: () {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
