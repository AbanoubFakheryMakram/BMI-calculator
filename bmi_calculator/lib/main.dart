import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gender_selection/gender_card/gender_card.dart';
import 'package:gender_selection/result_page/result_page.dart';
import 'package:gender_selection/weight_card/weight_card.dart';
import 'package:gender_selection/widgets/fade_transition.dart';
import 'package:gender_selection/widgets/input_sammary.dart';
import 'package:gender_selection/widgets/pacman_slider.dart';
import 'package:gender_selection/widgets/transition_dots.dart';

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // animation controller
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animationController.addStatusListener((status) {
      //add a listener
      if (status == AnimationStatus.completed) {
        _goToResultPage().then((_) =>
            _animationController.reset()); //reset controller when coming back
      }
    });
  }

  _goToResultPage() async {
    return Navigator.of(context).push(FadeRoute(
      //use the FadeRoute
      builder: (context) => ResultPage(
        weight: weight,
        height: height,
        gender: gender,
      ),
    ));
  }

  // initial data
  GenderType gender = GenderType.male;
  int height = 170;
  int weight = 60;

  @override
  Widget build(BuildContext context) {
    initScreenSize();
    return Stack(
      children: <Widget>[
        Scaffold(
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
        ),
        TransitionDot(animation: _animationController),
      ],
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
                  initialWeight: 60,
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
      child: PacmanSlider(
        onSubmit: onPacmanSubmit,
        animationController: _animationController,
      ),
    );
  }

  void onPacmanSubmit() {
    // start the animation whenever the user submitting the slider
    _animationController.forward();
  }
}
