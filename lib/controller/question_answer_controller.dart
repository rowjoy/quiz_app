import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/provider/api_provider.dart';

import '../utils/string.dart';

class QuestionAnswerController extends GetxController{

var index = 0.obs;
var score = 0.obs;
var correctAnswer = Strings.not.obs;
var tapCount = 0.obs;
// ignore: prefer_const_constructors

void updateIndex (){
      index +1;
      update();
}


final ApiProvider _apiProvider = ApiProvider();
  Future<List<Question>> getQuestionAndAnswer () async {
   var responce = await  _apiProvider.getData(
        baseUrl: Strings.apiUrl,
        url: Strings.quizurl
      );
    List data = [];
    for(var i in responce["questions"]){
        data.add(i);
    }
    return data.map((e) => Question.fromJson(e)).toList();
  }

  





//   late int _counter;
//   late Timer _timer;

//   void startTimer() {
//     _counter = 10;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_counter > 0) {
//         _counter--;
//         if(_counter == 1){
//           updateIndex ();
//         }
//         update();
//       } else {
//         _timer.cancel();
//       }
//     });
//   }

}