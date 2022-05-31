import 'package:get/get.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/provider/api_provider.dart';

import '../utils/string.dart';

class QuestionAnswerController extends GetxController{


final ApiProvider _apiProvider = ApiProvider();

List<QuestionModel> _questionlist = [];
List<Answers> _answerList =[];
  Future getQuestionAndAnswer () async {
     await  _apiProvider.getData(
        baseUrl: Strings.apiUrl,
        url: Strings.quizurl
      ).then((value){

        for(var i in value["questions"]){
          print(i);
        }
      });
  }

}