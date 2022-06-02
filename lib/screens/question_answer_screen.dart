// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_answer_controller.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/utils/string.dart';

import '../widget/custom_answer_button.dart';
class QuestionAndAnswerScreen extends StatelessWidget {
  final QuestionAnswerController _answerController = QuestionAnswerController();
   QuestionAndAnswerScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ksecondaryColor,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               FutureBuilder<List<Question>>(
                  future:_answerController.getQuestionAndAnswer(),
                  builder: (context, snapSort){
                  if(snapSort.connectionState == ConnectionState.waiting){
                  }
                  if(snapSort.hasData){
                  List<Question>? _data = snapSort.data;
                  Map<String ,dynamic> _answer = _data![_answerController.index.value].answers!.toJson();
                    return ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                       itemBuilder: (context , index){
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            color: AppColors.kWhiteColor,
                            child: Obx(()=> Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:  [
                                  Text("Questions: ${_answerController.index}/${_data.length}",
                                    style: TextStyle(
                                      color: AppColors.ksecondaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text("Score :${_answerController.score.value}",
                                      style: TextStyle(
                                        color: AppColors.ksecondaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 10,
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: AppColors.kBlackColor.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: AppColors.kWhiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: 
                                      Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(_data[_answerController.index.value].score.toString()+ "Point",
                                            style: TextStyle(
                                              color: AppColors.kBlackColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                         _data[_answerController.index.value].questionImageUrl != null ? AspectRatio(
                                            aspectRatio:1.9,
                                            child: Image.network("${_data[_answerController.index.value].questionImageUrl}"),
                                          ) : SizedBox(),
                                          Text( _data[_answerController.index.value].question.toString(),
                                            style: TextStyle(
                                              color: AppColors.kBlackColor,
                                              fontSize: 16,
                                              
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _answer.length,
                              itemBuilder: (context, index){
                                // ignore: avoid_print
                                print(_answer.length);
                                var valus = _answer.values.elementAt(index);
                                return  _answer.values.elementAt(index) != null? 
                                    Obx(()=> CustomAnswerButton(
                                      title: valus.toString(),
                                      onTap: (){
                                        if(_data[_answerController.index.value].correctAnswer == _answer.keys.elementAt(index)){
                                            _answerController.correctAnswer.value = _data[_answerController.index.value].correctAnswer.toString();
                                            _answerController.score.value = _answerController.score.value + _data[_answerController.index.value].score!.toInt();
                                          }
                                        if(_data[_answerController.index.value].correctAnswer == _answer.keys.elementAt(index)){
                                          _answerController.updateIndex();
                                        }

                                        

                                      },
                                      borderColors:  _answerController.correctAnswer.value == _answer.keys.elementAt(index) ?AppColors.kPrimaryColor : AppColors.kWhiteColor,
                                      ),
                                    ) : SizedBox();
                              }
                            ),
                          ],
                        );
                      }
                    );
                  }
                  return  Center(child: CircularProgressIndicator());
                  }
                ),
            ],
        ),
      ),
    );
  }
}

