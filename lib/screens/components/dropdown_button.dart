import 'package:flutter/material.dart';
import 'package:shop_app/screens/components/colors.dart';
import 'package:shop_app/screens/components/size_config.dart';

/// Flutter code sample for [DropdownMenu].

class ApplicationDropdownMenu extends StatefulWidget {
  const ApplicationDropdownMenu();

  @override
  State<ApplicationDropdownMenu> createState() =>
      _ApplicationDropdownMenuState();
}

class _ApplicationDropdownMenuState extends State<ApplicationDropdownMenu> {
  List<String> list = <String>['ZWL', 'USD'];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth! / 20.55,
            SizeConfig.screenHeight! / 68.3,
            SizeConfig.screenWidth! / 20.55,
            SizeConfig.screenHeight! / 34.15),
        child: DropdownButtonFormField<String>(
          onChanged: (value) {},
          value: list.first,
          items: list
              .map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ))
              .toList(),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.payment_outlined),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    width: SizeConfig.screenWidth! / 205.5, color: textColor),

                /// 2
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: texthint),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: "Select currency",
              hintStyle: TextStyle(color: texthint.withOpacity(0.3)),
              labelText: "Select currency",
              labelStyle: TextStyle(color: texthint.withOpacity(0.6))),
        ),
      ),
    );
  }
}
