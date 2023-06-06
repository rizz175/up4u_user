import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:up4u/Bloc/UserBloc/user_bloc.dart';
import 'package:up4u/Data/Constants/constants.dart';
import 'package:up4u/Presentation/Screens/Authenication/registrationScreen.dart';
import 'package:up4u/Presentation/Screens/Bottom_Navigation/Bottommenu.dart';

import 'package:up4u/Presentation/Utils/constants.dart';
import 'package:up4u/Presentation/Utils/usefulMethods.dart';
import 'package:up4u/Presentation/Widgets/LoadingWidget.dart';
import 'package:up4u/Presentation/Widgets/primaryButton.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ///variable declaration
  bool isSignIn = false;
  bool isChecked = false;
  String password = "";
  bool emailOK = false;
  String email = "";
  bool _obscured = true;

  ///controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///others declarations
  final formGlobalKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(listener: (context, state) {
      if (state is AuthenticationSuccess) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else if (state is  AuthenticationFailed) {
        UsefullMethods.showMessage(Constants.loginFailedMessage);
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        color: Colors.white,
        opacity: .8,
        progressIndicator: const LoadingBar(),
        inAsyncCall: state is  AuthenticationLoading ? true : false,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  height: 90.h,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 35.h,
                        child: Image.asset(
                          "Assets/icon.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "Welkom terug",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: 45.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Form(
                            key: formGlobalKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 3.h,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: (email) {
                                    if (UsefullMethods.isEmail(
                                        email.toString())) {
                                      return null;
                                    } else {
                                      return Constants.emailError;
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'e-mailen',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(16),
                                    fillColor: const Color(0xfff6f5f5),
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  validator: (password) {
                                    if (UsefullMethods.isPasswordValid(
                                        password.toString())) {
                                      return null;
                                    } else {
                                      return Constants.passwordError;
                                    }
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  focusNode: textFieldFocusNode,
                                  obscureText: _obscured,
                                  decoration: InputDecoration(
                                      suffixIcon: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 4, 0),
                                          child: GestureDetector(
                                            onTap: _toggleObscured,
                                            child: Icon(
                                              !_obscured
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                              size: 24,
                                              color: primaryColor,
                                            ),
                                          )),
                                      hintText: 'wachtwoord',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(16),
                                      fillColor: const Color(0xfff6f5f5),
                                      prefixIcon:
                                          const Icon(Icons.lock_outline)),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                primaryButton(
                                  title: "LOGIN",
                                  onPress: () {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      FocusScope.of(context).unfocus();

                                      context.read<AuthenticationBloc>().add(
                                          loginUserEventPressed(emailController.text, passwordController.text));
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(""),
                                      GestureDetector(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   new MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           ForgotPassword()),
                                            // );
                                          },
                                          child: const Text(
                                            "",
                                            textAlign: TextAlign.end,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Heb je geen account?",
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Registration()));
                          },
                          child: const Text(
                            "  Register",
                            style: TextStyle(
                                color: Color(0xff3f6d09),
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
