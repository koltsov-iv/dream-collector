import 'statement.dart';

class StatementScored {
  final Statement statement;
  int supportedCnt = 1;

  StatementScored({
    required this.statement,
  });

  factory StatementScored.create(Statement statement) {
    return StatementScored(statement: statement);
  }

  void support() {
    supportedCnt += 1;
  }
}
