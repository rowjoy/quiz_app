// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';

import '../widget/custom_answer_button.dart';
class QuestionAndAnswerScreen extends StatelessWidget {
  const QuestionAndAnswerScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ksecondaryColor,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                color: AppColors.kWhiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text("Questions: X/Y",
                      style: TextStyle(
                        color: AppColors.ksecondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text("Score : 300",
                      style: TextStyle(
                        color: AppColors.ksecondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32,),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("value not found"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return  CustomAnswerButton(
                    title: "Css",
                    borderColors: index == 2 ?  AppColors.kPrimaryColor :AppColors.kWhiteColor ,
                    onTap: (){
                      
                    },
                  );
                },
              ),
            ],
        ),
      ),
    );
  }
}

