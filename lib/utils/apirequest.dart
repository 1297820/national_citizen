import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/constants.dart';

String url = "https://newsapi.org/v2/everything?q=tech";
String apiKey = "apiKey=31d7878c1a9641bfb9c2adb9c3f54473";

Future<dynamic>? getNewsData(pageCount) async {
  try {
    var response = await http.get(
      Uri.parse("$url&pageSize=10&page=$pageCount&$apiKey"),
    );
    var body = jsonDecode(response.body);
    // print('>>>>>>>>>>> $body');
    return body;
  } catch (e) {
    // print('Error is $e');
    rethrow;
  }
}

String endpointUrl = "fast-woodland-39897.herokuapp.com";

Future<dynamic> signUpRequest(String email, String nin, String password) async {
  try {
    print("start signUp");
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/auth/signup"),
      body: json.encode({"email": email, "nin": nin, "password": password}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    print(decodedResponse.runtimeType);
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> logInRequest(String nin, String password) async {
  try {
    print("start signUp");
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/auth/login"),
      body: json.encode({"nin": nin, "password": password}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    print(decodedResponse.runtimeType);
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> profileRequest() async {
  try {
    print("start signUp");
    print('!!!!! ${getX.read(Constants().GETX_TOKEN)} ');
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/view_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    print(decodedResponse.runtimeType);
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> searchUsers(search, pageCount) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/search/search"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "search": search,
        "pageCount": pageCount,
        "resultPerPage": 10
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> usersProfileRequest(token, userId) async {
  try {
    print("start signUp");
    print('!!!!! ${getX.read(Constants().GETX_TOKEN)} ');
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/view_profile"),
      body: json.encode({
        "token": token,
        "userId": userId
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editName(name) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "name": name
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    if(decodedResponse["status"] == "ok"){
      getX.write(Constants().GETX_NAME, decodedResponse["user"]["name"]);
      print(getX.read(Constants().GETX_NAME));
    }
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editStatus() async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "status": getX.read(Constants().GETX_STATUS)
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editAddress(address) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "address": address
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editPhoneNumber(phoneNumber) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "phone": phoneNumber
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editEmail(email) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "email": email
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editDateOfBirth(dateOfBirth) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "date_of_birth": dateOfBirth
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editOccupation(occupation) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "occupation": occupation
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editGender() async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "gender": getX.read(Constants().GETX_GENDER)
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editHeight(height) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "height": height
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editInterest(interest) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "interest": interest
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}

Future<dynamic> editBio(bio) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(Constants().GETX_TOKEN),
        "bio": bio
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print("###### $decodedResponse");
    return decodedResponse;
  } catch (e) {
    print(e);
    // myWidgets.showSnackbar(message: "An error occured", color: Colors.red);
  }
}
