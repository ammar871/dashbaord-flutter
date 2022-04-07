
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class Helpers {
  static double widthScreen = 0.0;
  static double heightScreen = 0.0;
}

pop(context) {
  Navigator.of(context).pop();
}

pushPage({context, page}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

showSheet(BuildContext context, child) {
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return Wrap(
        children: [child],
      );
    },
  );
}



replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}


popMultiplePages(context, count) {
  for (int i = 0; i < count; i++) {
    Navigator.of(context).pop();
  }
}


flexSpace(int f) {
  return Flexible(flex: f, child: Container());
}
