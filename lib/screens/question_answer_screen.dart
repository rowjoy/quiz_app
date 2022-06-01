// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_answer_controller.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/utils/colors.dart';

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
                Map<String ,dynamic> _answer = _data![2].answers!.toJson();
                  return ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                     itemBuilder: (context , index){
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          color: AppColors.kWhiteColor,
                          child: Row(
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
                                        Text(_data[0].score.toString()+ "Point",
                                          style: TextStyle(
                                            color: AppColors.kBlackColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text( _data[0].question.toString(),
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
                              print(_answer.length);
                              var valus = _answer.values.elementAt(index);
                              return CustomAnswerButton(
                                title: valus.toString(),
                                onTap: (){
                                 
                                },
                              );
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

