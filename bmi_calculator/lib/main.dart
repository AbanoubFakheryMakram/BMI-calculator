import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gender_selection/gender_card/gender_card.dart';
import 'package:gender_selection/weight_card/weight_card.dart';

import 'height_card/height_card.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    initScreenSize();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
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

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setHeight(24),
        top: ScreenUtil().setHeight(26),
      ),
      child: Text(
        'BMI Calculator',
        style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCards() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(32),
          left: ScreenUtil().setHeight(14),
          right: ScreenUtil().setHeight(14)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GenderCard(
                    initialGender: GenderType.other,
                  ),
                ),
                Expanded(
                  child: WeightCard(initialWeight: 60),
                )
              ],
            ),
          ),
          Expanded(
            child: HeightCard(
              height: 130,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      alignment: Alignment.center,
      height: ScreenUtil().setHeight(108),
      child: Switch(
        value: true,
        onChanged: (newValue) {},
      ),
    );
  }
}
