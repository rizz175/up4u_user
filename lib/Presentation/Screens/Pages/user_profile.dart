import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:up4u/Presentation/Utils/constants.dart';

import '../../../Bloc/AuthenticationBloc/authentication_bloc.dart';
import '../../../Bloc/UserBloc/user_bloc.dart';
import '../../../Data/Model/userModel.dart';
import '../../../Data/Model/userResponseModel.dart';
import '../../../Data/local/user_utils.dart';
import '../../Widgets/LoadingWidget.dart';
import '../Authenication/loginScreen.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  UserInfo userInfo = UserInfo();
  bool showSpinner = false;
  String name = "";
  String email = "";
  @override
  void initState() {
    // TODO: implement initState

    getData();

    super.initState();
  }

  getData() async {
    userInfo = await UserUtils().getUser();

    setState(() {
      name = userInfo.username!;
      email = userInfo.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    userModel user = BlocProvider.of<UserBloc>(context).user;

    var width = getWidth(context);
    var height = getHeight(context);
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: LoadingBar(),
        child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              child: Column(
                children: [
                  Text(
                    "Mijn profiel",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.028),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    width: width * 0.3,
                    height: height * 0.15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    child: Center(
                        child: Text(
                      name != "" ? name!.substring(0, 1).toUpperCase() : "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: height * 0.08),
                    )),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.024),
                  ),
                  SizedBox(
                    height: height * 0.001,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        color: Colors.black45, fontSize: height * 0.015),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  // Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: primaryColor.withOpacity(.05),
                  //     ),
                  //     child: ListTile(
                  //       leading: Icon(
                  //         Icons.key,
                  //         color: primaryColor,
                  //         size: 23,
                  //       ),
                  //       trailing: const Icon(
                  //         Icons.arrow_forward_ios_outlined,
                  //         color: Colors.black54,
                  //         size: 16,
                  //       ),
                  //       title: Text(
                  //         "Change Password",
                  //         style: TextStyle(
                  //           color: Colors.black87,
                  //           fontSize: height * 0.02,
                  //         ),
                  //       ),
                  //     )),
                  // SizedBox(
                  //   height: height * 0.01,
                  // ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor.withOpacity(.05),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.privacy_tip,
                          color: primaryColor,
                          size: 23,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                          size: 16,
                        ),
                        title: Text(
                          "Privacybeleid",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: height * 0.02,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor.withOpacity(.05),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.work_rounded,
                          color: primaryColor,
                          size: 23,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                          size: 16,
                        ),
                        title: Text(
                          "Over ons",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: height * 0.02,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor.withOpacity(.05),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.share,
                          color: primaryColor,
                          size: 23,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black54,
                          size: 16,
                        ),
                        title: Text(
                          "Deel app",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: height * 0.02,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  BlocListener<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) async {
                        if (state is AuthenticationSuccess) {
                          final status = await UserUtils().logoutMe(context);
                          if (status) {
                            setState(() {
                              showSpinner = false;
                            });

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                                (Route<dynamic> route) => false);
                          } else {
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } else if (state is AuthenticationLoading) {
                          setState(() {
                            showSpinner = true;
                          });
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor.withOpacity(.05),
                          ),
                          child: ListTile(
                            onTap: () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(logoutUserEventPressed());
                            },
                            leading: Icon(
                              Icons.logout,
                              color: primaryColor,
                              size: 23,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black54,
                              size: 16,
                            ),
                            title: Text(
                              "Uitloggen",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: height * 0.02,
                              ),
                            ),
                          ))),
                ],
              ),
            )));
  }
}
