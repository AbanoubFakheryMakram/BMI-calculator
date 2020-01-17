import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gender_selection/gender_card/gender_card.dart';
import 'package:gender_selection/weight_card/weight_card.dart';
import 'package:gender_selection/widgets/input_sammary.dart';
import 'package:gender_selection/widgets/pacman_slider.dart';

import 'height_card/height_card.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.white, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    ));
  });
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GenderType gender = GenderType.male;
  int height = 170;
  int weight = 60;

  @override
  Widget build(BuildContext context) {
    initScreenSize();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputSummaryCard(
              gender: gender,
              weight: weight,
              height: height,
            ),
            Expanded(child: _buildCards()),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  initScreenSize() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        width: screenWidth, height: screenHeight, allowFontScaling: true);
  }

  Widget _buildCards() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(8),
          left: ScreenUtil().setHeight(14),
          right: ScreenUtil().setHeight(14)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GenderCard(
                    initialGender: GenderType.male,
                    onChange: (type) => setState(() => gender = type),
                  ),
                ),
                Expanded(
                    child: WeightCard(
                  initialWeight: 70,
                  onChage: (val) => setState(() => weight = val),
                ))
              ],
            ),
          ),
          Expanded(
            child: HeightCard(
              height: 170,
              onChanged: (val) => setState(() => height = val),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setHeight(16.0),
        right: ScreenUtil().setHeight(16.0),
        bottom: ScreenUtil().setHeight(22.0),
        top: ScreenUtil().setHeight(14.0),
      ),
      child: PacmanSlider(),
    );
  }
}
