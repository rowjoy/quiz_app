import 'package:flutter/material.dart';

import '../screen/quizpage.dart';
import '../utils/colors.dart';
class Customcard extends StatelessWidget {
  const Customcard({
    Key? key,
    required this.context,
    required this.langname,
    required this.image,
    required this.des,
    required this.color,
  }) : super(key: key);

  final BuildContext context;
  final String langname;
  final String image;
  final String des;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            // in changelog 1 we will pass the langname name to ther other widget class
            // this name will be used to open a particular JSON file 
            // for a particular language
            builder: (context) => getjson(langname),
          ));
        },
        child: Material(
          color:color,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(100.0),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    // changing from 200 to 150 as to look better
                    height: 60.0,
                    width: 60.0,
                    child: ClipOval(
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          image,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Text(
                          langname,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: AppColor.whiteColor,
                            fontFamily: "Quando",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            des,
                            style:  TextStyle(
                              fontSize: 12.0,
                              color: AppColor.whiteColor,
                              fontFamily: "Alike"
                            ),
                            maxLines: 5,
                            textAlign: TextAlign.justify,
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}