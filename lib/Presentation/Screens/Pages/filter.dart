import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Data/Constants/constants.dart';

import 'package:up4u/Presentation/Utils/constants.dart';
import 'package:up4u/Presentation/Widgets/primaryButton.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String cityName = "";
  double rating=0;
  String ratingString="";

  @override
  Widget build(BuildContext context) {
    var height = getHeight(context);
    var width = getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 9.h,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.arrow_left_circle_fill,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        centerTitle: true,
        title: Text("Filterrestaurant",
            style: TextStyle(
                fontSize: 16.sp,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 2.h, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Selecteer stad",
              style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xfff6f5f5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownFormField<Map<String, dynamic>>(
                emptyActionText: "",
                onEmptyActionPressed: () async {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  suffixIcon: Icon(CupertinoIcons.arrow_down_circle,color:primaryColor,),
                ),
                onSaved: (dynamic str) {},
                onChanged: (dynamic str) {
                  setState(() {
                    cityName = str['city'];
                  });
                },
                validator: (dynamic str) {},
                displayItemFn: (dynamic item) => Text(
                  (item ?? {})['city'] ?? '',
                  style: TextStyle(fontSize: 10.sp),
                ),
                findFn: (dynamic str) async => Constants.citiesList,
                selectedFn: (dynamic item1, dynamic item2) {
                  if (item1 != null && item2 != null) {
                    return item1['city'] == item2['city'];
                  }
                  return false;
                },
                filterFn: (dynamic item, str) =>
                    item['city'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
                dropdownItemFn: (dynamic item, int position, bool focused,
                        bool selected, Function() onTap) =>
                    ListTile(
                  title: Text(
                    item['city'],
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  tileColor: focused
                      ? Color.fromARGB(20, 0, 0, 0)
                      : Colors.transparent,
                  onTap: onTap,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Waarderingen",
              style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(

              width:100.w,
              child:  Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10.0,
                      trackShape: const RoundedRectSliderTrackShape(),
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: Colors.black12,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 14.0,
                        pressedElevation: 8.0,
                      ),
                      thumbColor:secondryColor,
                      overlayColor:secondryColor.withOpacity(0.2),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
                      tickMarkShape: const RoundSliderTickMarkShape(),
                      activeTickMarkColor: secondryColor,
                      inactiveTickMarkColor: Colors.white,
                      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: Colors.black,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    child: Slider(
                      min: 0.0,
                      max: 5.0,
                      value:rating,
                      divisions: 5,
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                          ratingString=value.toString();

                          // _status = 'active (${_value.round()})';
                          // _statusColor = Colors.green;
                        });
                      },
                      onChangeStart: (value) {
                        setState(() {
                          // _status = 'start';
                          // _statusColor = Colors.lightGreen;
                        });
                      },
                      onChangeEnd: (value) {
                        setState(() {
                          // _status = 'end';
                          // _statusColor = Colors.red;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$rating ",style:TextStyle(fontSize:18.sp),),Icon(Icons.star,color: secondryColor,),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            primaryButton(title:"Voeg filter toe", onPress: (){
              var data={
                "city":cityName,"rating":ratingString.toString()

              };

              Navigator.pop(context,data);
            })
          ],
        ),
      ),
    );
  }
}
