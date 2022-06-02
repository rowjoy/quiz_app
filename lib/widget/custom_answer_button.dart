import 'package:flutter/material.dart';

import '../utils/colors.dart';
class CustomAnswerButton extends StatelessWidget {
  final String? title;
  final Color? borderColors;
  final void Function()? onTap;

  const CustomAnswerButton({
    Key? key,
    this.title,
    this.onTap,
    this.borderColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Card(
          elevation: 10,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          color: borderColors,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                 borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}