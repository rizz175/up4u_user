import 'package:flutter/material.dart';
import 'package:up4u/Presentation/Screens/Authenication/loginScreen.dart';
import 'package:up4u/Presentation/Utils/constants.dart';

import '../Authenication/registrationScreen.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({Key? key}) : super(key: key);

  @override
  _OnboardingscreenState createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  late AssetImage assetImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    assetImage = AssetImage('Assets/boarding.jpg');
    precacheImage(assetImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: getWidth(context),
              height: getHeight(context),
              child: Image(
                  image: AssetImage('Assets/boarding.jpg'), fit: BoxFit.fill)),
          Container(
            width: getWidth(context),
            height: getHeight(context),
            color: Colors.black.withOpacity(0.3),
          ),
          Positioned(
              bottom: 10,
              left: 30,
              right: 30,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find Famous &\nBest Restuarants",
                      style: TextStyle(
                          fontSize: getHeight(context) * 0.04,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: getWidth(context),
                      child: Text(
                        "Browse a lot of interesting tourist offers and choose something for ourself. The world is waiting!",
                        style: TextStyle(
                            fontSize: getHeight(context) * 0.02,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: getWidth(context),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text("lets Start"))),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Registration()));
                      },
                      child: Center(
                          child: Text(
                        "Create Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline),
                      )),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
