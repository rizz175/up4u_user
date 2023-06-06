import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Presentation/Screens/Pages/show_all_places.dart';
import 'package:up4u/Presentation/Screens/Pages/detailed_place.dart';
import 'package:up4u/Presentation/Utils/constants.dart';
import '../../../Bloc/NearbyBloc/nearby_bloc.dart';
import '../../../Data/Model/userResponseModel.dart';
import '../../../Data/local/user_utils.dart';
import '../../Widgets/LoadingWidget.dart';
import '../../Widgets/PlaceBoxWidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  UserInfo userInfo = UserInfo();
  bool showSpinner = false;
  String name = "";

  @override
  void initState() {
    // TODO: implement initState

    getData();
    BlocProvider.of<nearbyBloc>(context).add(PlacesNearbyEvent(context));

    super.initState();
  }

  getData() async {
    userInfo = await UserUtils().getUser();

    setState(() {
      name = userInfo.username!;

    });
  }


  @override
  Widget build(BuildContext context) {
    var width = getWidth(context);
    var height = getHeight(context);
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hoi, ${name} !",
                    style: TextStyle(
                        fontSize: 18.sp, color: Colors.black)),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: primaryColor),
                  child: Center(
                      child: Text(
                   name!=""? name!.substring(0, 1).toUpperCase():"",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  )),
                )
              ],
            ),

            SizedBox(
              height: 1.h,
            ),
            Text("Ontdek de",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                )),
            Text(
              "Beste beroemde restaurants",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
              maxLines: 2,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>showAllPlaces(false)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                color: primaryColor.withOpacity(.5),
                                fontSize: 14.sp),

                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                TyperAnimatedText('Bekijk alle restaurants'),

                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),

                        ],
                      ),

                    ]),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Het dichtst bij jou",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: height * 0.025,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => showAllPlaces(true)));
                  },
                  child: Text("Bekijk alles",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: height * 0.02,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              height: 30.h,
              width: width,
              child: BlocConsumer<nearbyBloc, NearbyState>(
                  builder: (context, state) {
                    if (state is NearbyLoading) {
                      return const Center(child: LoadingBar());
                    }

                    if (state is NearbySuccessfull) {
                      return ListView.builder(
                        itemCount: state.placeList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailedScreen(
                                          state.placeList[index])));
                            },
                            child: PlaceBox(
                              placeList: state.placeList[index],
                            ),
                          );
                        }),
                      );
                    } else {
                      return Container();
                    }

                  },
                  listener: (context, state) {}),
            )
          ],
        ),
      ),
    );
  }
}
