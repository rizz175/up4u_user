import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:up4u/Data/Constants/constants.dart';
import 'package:up4u/Presentation/Utils/constants.dart';
import 'package:up4u/Presentation/Utils/usefulMethods.dart';
import 'package:up4u/Presentation/Widgets/LoadingWidget.dart';
import 'package:up4u/Presentation/Widgets/primaryButton.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  ///variable declaration
  bool emailOK = false;
  bool showSpinner = false;
  bool _obscured = true;

  ///controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///others
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
  void dispose() {
    // TODO: implement dispose

  usernameController.dispose();
  emailController.dispose();
  passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
      if (state is AuthenticationSuccess)
      {
        Navigator.pop(context);
        UsefullMethods.showMessage(Constants.registerSuccessMessage);
      }
      else if (state is AuthenticationFailed) {

          Navigator.pop(context);
          UsefullMethods.showMessage(state.message);

      }
    }, builder: (context, state) {
      return ModalProgressHUD(
          color: Colors.white,
          opacity: .8,
          progressIndicator: const LoadingBar(),
          inAsyncCall: state is AuthenticationLoading? true : false,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                            size: 16.sp,
                          ),
                        ),
                        Text("Maak account",
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text("Begin je reis met UP!",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: secondryColor)),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Gebruikersnaam",
                      style: TextStyle(color: primaryColor),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormField(
                      controller: usernameController,
                      validator: (username) {
                        if (username!.isNotEmpty) {
                          return null;
                        } else {
                          return Constants.usernameError;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'John Bush..',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: const Icon(Icons.perm_identity),
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: const Color(0xfff6f5f5),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "E-mail",
                      style: TextStyle(color: primaryColor),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (email) {
                        if (UsefullMethods.isEmail(email.toString())) {
                          return null;
                        } else {
                          return Constants.emailError;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'abc@mail.com',
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
                          prefixIcon: const Icon(Icons.email_outlined),
                          prefixIconColor: primaryColor),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Wachtwoord",
                      style: TextStyle(color: primaryColor),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscured,
                      validator: (password) {
                        if (UsefullMethods.isPasswordValid(
                            password.toString())) {
                          return null;
                        } else {
                          return Constants.passwordError;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                !_obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                                color: primaryColor,
                              ),
                            )),
                        hintText: 'Password',
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
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    primaryButton(
                      title: "REGISTER",
                      onPress: () {
                        if (formGlobalKey.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(
                              registerUserEventPressed(emailController.text, passwordController.text, usernameController.text));
                        }
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Heb je al een account?",
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "  LOG IN",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }));
  }
}
