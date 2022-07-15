// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/custom_widget/customcard_widget.dart';
import 'package:quiz_app/data/list_data.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}
// ignore: camel_case_types
class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.prymeryColor,
        title: const Text(
          "Programming hero",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: Datas.images.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(seconds: 1),
              child:  SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Customcard(context: context, langname: Datas.langname[index], image: Datas.images[index], des: Datas.des[index], color: colorsList[index],),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}