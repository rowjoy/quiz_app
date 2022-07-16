// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types, must_be_immutable, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screen/resultpage.dart';

class getjson extends StatefulWidget {
  // accept the langname as a parameter

  late String? langname;
  getjson(this.langname, {Key? key}) : super(key: key);

  @override
  State<getjson> createState() => _getjsonState();
}

class _getjsonState extends State<getjson> {
 late String assettoload;

  // a function
  setasset() {
    if (widget.langname == "Python") {
      assettoload = "assets/python.json";
    } else if (widget.langname == "Java") {
      assettoload = "assets/java.json";
    } else if (widget.langname == "Javascript") {
      assettoload = "assets/js.json";
    } else if (widget.langname == "C++") {
      assettoload = "assets/cpp.json";
    } else {
      assettoload = "assets/linux.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assettoload is avialable to the DefaultAssetBuilder
    // and now we return the FutureBuilder to load and decode JSON
    setasset();
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List? mydata = json.decode(snapshot.data.toString());
          return quizpage(mydata: mydata ?? [] );
        }else if(snapshot.hasError){
          Navigator.canPop(context);

        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}







class quizpage extends StatefulWidget {
  final List? mydata;

  const quizpage({Key? key, required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}
class _quizpageState extends State<quizpage> {
  final List? mydata;
  _quizpageState(this.mydata);

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  // extra varibale to iterate
  int j = 1;
  int timer = 30;
  String showtimer = "30";
  List? random_array;

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  // code inserted for choosing questions randomly
  // to create the array elements randomly use the dart:math module
  // -----     CODE TO GENERATE ARRAY RANDOMLY

  genrandomarray(){
    var distinctIds = [];
    // ignore: unnecessary_new
    var rand = new Random();
      // ignore: unused_local_variable
      for (int i = 0;  ;) {
      distinctIds.add(rand.nextInt(10));
        random_array = distinctIds.toSet().toList();
        if(random_array!.length < 10){
          continue;
        }else{
          break;
        }
      }
      // ignore: avoid_print
      print("Rendom arrey $random_array");
    
  }

    
  // overriding the initstate function to start timer as this screen is created
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
      if (j < 10) {
        i = random_array![j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
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
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(const Duration(seconds: 2), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text("${mydata![1][i.toString()][k]}",
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text("${mydata![0][i.toString()]}",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Quando",
                ),
              ),
            ),
          ),
          Expanded(
              flex: 6,
              child: AbsorbPointer(
                absorbing: disableAnswer,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                      choicebutton('d'),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              child: Center(
                child: Text(
                  showtimer,
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
