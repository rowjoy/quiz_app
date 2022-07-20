// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types, must_be_immutable, prefer_const_constructors


import 'dart:convert';

import 'package:flutter/material.dart';
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
            return quizpage(mydata: mydata ?? [] );
          }else if(snapshot.hasError){
            Navigator.canPop(context);
    
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}







