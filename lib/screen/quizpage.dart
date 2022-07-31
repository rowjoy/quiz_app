// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types, must_be_immutable, prefer_const_constructors


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_app/data/keys.dart';
import 'package:quiz_app/screen/exam_bren.dart';
import 'package:quiz_app/screen/quiz_bren.dart';


class getjson extends StatefulWidget {
  // accept the langname as a parameter

  late String? langname;
  getjson(this.langname, {Key? key}) : super(key: key);

  @override
  State<getjson> createState() => _getjsonState();
}

class _getjsonState extends State<getjson> {
 late String assettoload;
 final box = GetStorage();

  // a function
  setasset() {
    if (widget.langname == "Flutter") {
      assettoload = "assets/flutter.json";
    } else if (widget.langname == "Dart") {
      assettoload = "assets/dart.json";
    } else if (widget.langname == "Kotlin") {
      assettoload = "assets/kotlin.json";
    } else if (widget.langname == "Python") {
      assettoload = "assets/python.json";
    } else if (widget.langname == "Java"){
      assettoload = "assets/java.json";
    }else if(widget.langname == "Javascript"){
      assettoload = "assets/js.json";
    }else if(widget.langname == "C++"){
      assettoload = "assets/cpp.json";
    }else if(widget.langname == "Exam"){
       assettoload = "assets/exam.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    return WillPopScope(
      onWillPop: () async {
          final snack = SnackBar(content: Text('Please complete your exam'),duration: Duration(seconds: 2),);
          ScaffoldMessenger.of(context).showSnackBar(snack);
         return  false;
      },
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List? mydata = json.decode(snapshot.data.toString());
            return  quizpage(mydata: mydata ?? [] );
          }else if(snapshot.hasError){
            Navigator.canPop(context);
    
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}







