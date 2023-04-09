import 'dart:html';
import 'dart:math';
import 'env.dart';
import 'statement.dart';
import 'statementScore.dart';
import 'test/mock_repository.dart';

class JarBuilder {
  late Iterable<Statement> statementsList;
  Map<String, StatementScored> statementMap = {};

  void build() {
    var jar = DivElement();
    jar.classes.add("jar");
    var textInJar = DivElement();
    jar.classes.add("text-in-jar");
    jar.append(textInJar);

    var content = querySelector('#output');
    content?.innerHtml = "";
    content?.append(jar);
    MockRepo().fetchStatements().then((value) => {
          statementsList = value,
          covertData(),
          textInJar.children.addAll(statementMap.values.map(newLI))
        });
  }

  void covertData() {
    for (var one in statementsList) {
      if (one.comment == "") {
        continue;
      }
      var scored = statementMap[one.comment];
      if (scored == null) {
        scored = StatementScored(statement: one);
        statementMap[one.comment] = scored;
        continue;
      }
      if (scored.statement.description == one.description) {
        continue;
      }
      scored.support();
    }
  }

  LIElement newLI(StatementScored one) {
    // isMobileView duplicates with main file, be careful
    bool isMobileView = window.innerWidth?.compareTo(768) == -1;
    // different max font size depends device
    int maxSize = isMobileView ? 24 : 48;
    var link = AnchorElement();
    link.href = "https://send.monobank.ua/jar/$jarPath?&t=${one.statement.comment}";
    link.text = one.statement.comment;
    // dynamic font size that's depends on supportedCnt
    var fontSize = min(maxSize, 12 + (3 * one.supportedCnt) - 3);
    link.style.fontSize = "${fontSize}px";
    link.target = "_blank";
    // tooltips styles didn't set up yet
    link.classes.add("tooltip");
    // don't remember why we need this hardcode
    link.style.left = "200px";
    var liElem = LIElement();
    // the requirement is to avoid text structure and place the text in the random position
    // in the jar, in order to achieve some chaos of the "dreams"
    // this is fast solution, maybe we can improve it
    var r = Random().nextInt(3);
    liElem.style.textAlign = r == 0
        ? "left"
        : r == 1
            ? "center"
            : "right";
    liElem.children.add(link);
    return liElem;
  }
}
