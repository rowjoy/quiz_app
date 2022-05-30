import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String buttonLevel;
  final Color?  color;
  final Color? textColor;
  final VoidCallback?  onPressed;
  final double? borderRadius;
  const CustomButton({
    Key? key, required this.buttonLevel, this.color, this.onPressed,this.textColor, this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
          child: Text(
            buttonLevel,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: color,
              textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:  BorderRadius.circular(borderRadius ?? 8)
              ),
            ),
          ),
      ),
    );
  }
}