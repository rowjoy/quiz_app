// ignore_for_file: no_logic_in_create_state, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:quiz_app/screen/home.dart';
import 'package:quiz_app/utils/colors.dart';

// ignore: camel_case_types
class resultpage extends StatefulWidget {
 final int marks;
  const resultpage({Key? key , required this.marks}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

// ignore: camel_case_types
class _resultpageState extends State<resultpage> {

  List<String> images = [
    "images/success.jpg",
    "images/good.jpg",
    "images/sad.png",
  ];

late  String message;
late  String image;

  @override
  void initState(){
    if(marks < 20){
      image = images[2];
      // ignore: prefer_adjacent_string_concatenation
      message = "You Should Try Hard..\n" + "You Scored $marks";
    }else if(marks < 35){
      image = images[1];
      // ignore: prefer_adjacent_string_concatenation
      message = "You Can Do Better..\n" + "You Scored $marks";
    }else{
      image = images[0];
      // ignore: prefer_adjacent_string_concatenation
      message = "You Did Very Well..\n" + "You Scored $marks";
    }
    super.initState();
  }

  late int marks;
  _resultpageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
         Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const homepage()));
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.prymeryColor.withOpacity(0.5),
        // appBar: AppBar(
        //   title: const Text(
        //     "Result",
        //   ),
        // ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Your achievements ",
                style: TextStyle(
                  fontSize: 25.0,
                  color: AppColor.whiteColor,
                  fontFamily: "Quando",
                  fontWeight: FontWeight.w700,
                ),
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: ClipRect(
                  child: Image(
                    image: AssetImage(
                      image,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ),
                child: Center(
                child: Text(
                  message,
                  style:  TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18.0,
                    fontFamily: "Quando",
                  ),
                ),
              )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  OutlineButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const homepage(),
                      ));
                    },
                    child:  Text(
                      "Skip",
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 18.0,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 25.0,
                    ),
                    borderSide: const BorderSide(width: 3.0, color: Colors.white),
                    splashColor: Colors.green,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}