import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_answer_controller.dart';
import 'package:quiz_app/screens/question_answer_screen.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/widget/custom_button.dart';
class MainMenuScreen extends StatelessWidget {
MainMenuScreen({ Key? key }) : super(key: key);
 final QuestionAnswerController _answerController = Get.put(QuestionAnswerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ksecondaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: avoid_unnecessary_containers
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 2.5,
                    child: Image.asset("assets/logo/app_logo.png",)
                  ),
                  const Text("Programming Hero",
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 22,
                    ),
                  ),
                  const Text("Quiz",
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32,),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("Highscore",
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("500 point",
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    CustomButton(
                      buttonLevel: "Start",
                      onPressed: (){
                        _answerController.getQuestionAndAnswer();
                        Get.to(()=>QuestionAndAnswerScreen());
                      },
                      textColor: AppColors.kBlackColor.withOpacity(0.8),
                      color: AppColors.kWhiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}