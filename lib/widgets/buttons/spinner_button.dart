import 'package:flutter/material.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';

class AsyncButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;
  final String label;
  const AsyncButton(
      {Key? key,
      required this.onPressed,
      required this.isLoading,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 7.59,
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 45.54),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 1.0],
            colors: [
              buttonColor,
              lightColor,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(
                SizeConfig.screenWidth! / 1.37,
                SizeConfig.screenHeight! / 13.66)),
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('PLEASE WAIT...',
                        style: TextStyle(
                          fontSize: SizeConfig.screenHeight! / 42.68,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ))
                  ],
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: SizeConfig.screenHeight! / 42.68,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
