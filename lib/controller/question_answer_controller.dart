import 'package:get/get.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/provider/api_provider.dart';

import '../utils/string.dart';

class QuestionAnswerController extends GetxController{

var index = 0.obs;

void updateIndex (){
  if(index.value < 9){
      index +1;
  }else{
    index --;
  }
  // update();
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

}