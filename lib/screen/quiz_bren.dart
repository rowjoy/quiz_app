// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_app/screen/home.dart';

import 'package:quiz_app/screen/resultpage.dart';
import 'package:quiz_app/utils/colors.dart';
import 'dart:math';
import 'dart:async';


// ignore: camel_case_types
class quizBren extends StatefulWidget {
  final List? mydata;

  const quizBren({Key? key, required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}
// ignore: camel_case_types
class _quizpageState extends State<quizBren> {
  final List? mydata;
  _quizpageState(this.mydata);
  final box = GetStorage();
  Color colortoshow = AppColor.whiteColor;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 0;
  bool disableAnswer = false;
  // extra varibale to iterate
  int j = 0;
  int timer = 30;
  String showtimer = "30";
  List? random_array;
  int questionCounter = 1;


  Map<String, Color> btncolor = {
    "a": AppColor.whiteColor,
    "b": AppColor.whiteColor,
    "c": AppColor.whiteColor,
    "d": AppColor.whiteColor,
  };

  bool canceltimer = false;

  genrandomarray(){
     // ignore: unnecessary_new
     var rand = new Random();
    var distinctIds = [];
    // ignore: unnecessary_new
      for (int i = 0; ;) {
      distinctIds.add(rand.nextInt(20));
        random_array = distinctIds.toSet().toList();
        if(random_array!.length < 20){
          continue;
        }else{
          break;
        }
      }
  }


  @override
  void initState() {
    starttimer();
    genrandomarray();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (j < 20) {
        i = random_array![j];
        print("random $random_array");
        print("I $i");

        j++;

        print("J$j");
        questionCounter ++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = AppColor.whiteColor;
      btncolor["b"] = AppColor.whiteColor;
      btncolor["c"] = AppColor.whiteColor;
      btncolor["d"] = AppColor.whiteColor;
      disableAnswer = false;
    });
    starttimer();
  }

  void checkanswer(String k) {
    if (mydata![2][i.toString()] == mydata![1][i.toString()][k]) {
      marks = marks + 5;
      colortoshow = right;
    } else {
      colortoshow = wrong;
      if(mydata![1][i.toString()].toString().contains(mydata![2][i.toString()])){
        Map data = mydata![1][i.toString()];
        if(data["a"].toString() == mydata![2][i.toString()].toString()){
          setState(() {
            btncolor["a"] = right;
          });
        }else if(data["b"].toString() == mydata![2][i.toString()].toString()){
         setState(() {
            btncolor["b"] = right;
        });
        }else if(data["c"].toString() == mydata![2][i.toString()].toString()){
          setState(() {
            btncolor["c"] = right;
          });
        }else if(data["d"].toString() == mydata![2][i.toString()].toString()){
          setState(() {
            btncolor["d"] = right;
          });
        }

        // if(data.values.contains(mydata![2][i.toString()]) ){
        //   print("KYS ${data["a"]}");

        // }
        // print("AVAV$data");
        // print("Value ${mydata![2][i.toString()]}");
      }
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(const Duration(seconds: 1), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ()=>checkanswer(k),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: btncolor[k],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 2,color: AppColor.whiteColor)
          ),
          child: Text("${mydata![1][i.toString()][k]}",
            style:  TextStyle(
              color: AppColor.prymeryColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Alike",
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Quiz'),
              content: Text(
                'You close exam press exit',
              ),
              actions: [
                FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => homepage(),
                        ));
                        canceltimer = true;
                      },
                      child: Text(
                        'Exit',
                  ),
                ),
                FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Continue',
                  ),
                ),
              ],
            ),
          );
         return  false;

      },
      child: Scaffold(
        backgroundColor: AppColor.prymeryColor.withOpacity(0.9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.prymeryColor.withOpacity(0),
          elevation: 0,
          leading: IconButton(
            onPressed: (){
               Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => homepage(),
                        ));
              canceltimer = true;
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title:  Text(
            "Question " + "$questionCounter / ${random_array!.length + 1}",
            style: TextStyle(
              fontFamily: "Quando",
            ),
          ),
        ),
        body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              // ignore: prefer_adjacent_string_concatenation
              child: Text( "($questionCounter) " + "${mydata![0][i.toString()]}",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16.0,
                  fontFamily: "Quando",
                ),
              ),
            ),
            AbsorbPointer(
              absorbing: disableAnswer,
                // ignore: avoid_unnecessary_containers
                child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    choicebutton('a'),
                    choicebutton('b'),
                    choicebutton('c'),
                    choicebutton('d'),
    
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.topCenter,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    "Your answer time $showtimer",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    FlatButton(
                          onPressed: () {
                            canceltimer = false;
                            timer = 30;
                            setState(() {
                              if (j < 20) {
                                i = random_array![j];
                                print("random $random_array");
                                print("I $i");

                                j++;

                                print("J$j");
                                questionCounter ++;
                              } else {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => resultpage(marks: marks),
                                ));
                              }
                              btncolor["a"] = AppColor.whiteColor;
                              btncolor["b"] = AppColor.whiteColor;
                              btncolor["c"] = AppColor.whiteColor;
                              btncolor["d"] = AppColor.whiteColor;
                              disableAnswer = false;
                            });
                          },
                          child: Text(
                            'Skip',
                          style: TextStyle(color: AppColor.whiteColor),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
