import 'dart:html';

import 'builder.dart';


void main() {
  List<Element> exampleButtons = document.querySelectorAll('.jar-button');
  switchMobile();
  for (var jarButton in exampleButtons) {
    jarButton.onClick.listen((event) {
      JarBuilder().build();
    });
  }

}

void switchMobile() {
  bool isMobileView = window.innerWidth?.compareTo(768) == -1;
  if (isMobileView) {
    Element? mobile = querySelector("#view-mobile");
    mobile?.style.display = "block";
  } else {
    Element? desktop = querySelector("#view-desktop");
    desktop?.style.display = "block";
  }
}
