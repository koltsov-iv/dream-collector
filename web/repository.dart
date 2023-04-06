import 'package:http/http.dart' as http;
import 'dart:convert';
import 'env.dart';
import 'statement.dart';

class MonoRepository {
  Future<Iterable<Statement>> fetchStatements() async {
    final response = await http.get(Uri.parse('$serverAddress/jar'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      var result = <Statement>[];
      for (var element in data) {
        result.add(Statement.fromJson(element));
      }
      return result;
    }
    throw Exception("Failed to load statement");
  }
}