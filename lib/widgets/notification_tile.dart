import 'package:flutter/material.dart';
import 'package:spring/ui_utils.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({Key? key}) : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.15,
        width: width * 0.87,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.77),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(3.35, 3.35),
            ),
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "29 June 2021, 7.14 PM",
                style: TextStyle(
                  color: UiUtils.lightText,
                  fontSize: 10,
                  fontFamily: UiUtils.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.7,
                  height: height * 0.07,
                  child: Text(
                    "Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem LoremLorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem LoremLorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ",
                    style: TextStyle(
                      color: UiUtils.dark,
                      fontSize: 13,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.07,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
