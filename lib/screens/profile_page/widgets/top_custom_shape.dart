import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/user.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';
import 'package:shop_app/screens/profile_page/components/CustomShape.dart';


class TopCustomShape extends StatefulWidget {
  const TopCustomShape({Key? key}) : super(key: key);

  @override
  _TopCustomShapeState createState() => _TopCustomShapeState();
}

class _TopCustomShapeState extends State<TopCustomShape> {
  @override
  Widget build(BuildContext context) {
      var provider = Provider.of<UserProvider>(context, listen: false);

    return SizedBox(
      height: SizeConfig.screenHeight!/2.84,               /// 240.0
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: SizeConfig.screenHeight!/4.56,       /// 150.0
              color: buttonColor,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: SizeConfig.screenHeight!/4.88,         /// 140.0
                  width: SizeConfig.screenWidth!/2.93,           /// 140.0
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: SizeConfig.screenWidth!/51.37),
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/main/avatar.png")
                      )
                  ),
                ),
                Text("${provider.user.user!.name}", style: TextStyle(fontSize: 22),),
                SizedBox(height: SizeConfig.screenHeight!/136.6,),              /// 5.0
                Text("${provider.user.user!.email}", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black45),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
