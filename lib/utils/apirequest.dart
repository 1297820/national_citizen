import 'package:http/http.dart' as https;
import 'dart:convert';
import 'dart:async';

String url = "https://newsapi.org/v2/everything?q=feed&";
String apiKey = "apiKey=31d7878c1a9641bfb9c2adb9c3f54473";


Future<dynamic>? getNewsData(pageCount) async {
  try {
    var response = await https.get(Uri.parse("https://newsapi.org/v2/everything?q=feed&pageSize=10&page=$pageCount&apiKey=31d7878c1a9641bfb9c2adb9c3f54473"),);
    var body = jsonDecode(response.body);

    print('>>>>>>>>>>> $body');
    return body;

  } catch (e) {
    print('Error is $e');
    rethrow;
  }
}




