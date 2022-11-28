import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/constants.dart';

String url = "https://newsapi.org/v2/everything?q=tech";
String apiKey = "apiKey=31d7878c1a9641bfb9c2adb9c3f54473";
Constants user_details = Constants();

Future<dynamic>? getNewsData(pageCount) async {
  try {
    var response = await http.get(
      Uri.parse("$url&pageSize=10&page=$pageCount&$apiKey"),
    );
    var body = jsonDecode(response.body);
    return body;
  } catch (e) {
    rethrow;
  }
}

String endpointUrl = "fast-woodland-39897.herokuapp.com";

Future<dynamic> signUpRequest(String email, String nin, String password) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/auth/signup"),
      body: json.encode({"email": email, "nin": nin, "password": password}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> logInRequest(String nin, String password) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/auth/login"),
      body: json.encode({"nin": nin, "password": password}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> profileRequest() async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/view_profile"),
      body: json.encode({
        "token": getX.read(user_details.GETX_TOKEN),
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> searchUsers(search, pageCount, week, month, year) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/search/search"),
      body: json.encode({
        "token": getX.read(user_details.GETX_TOKEN),
        "search": search,
        "pageCount": pageCount,
        "resultPerPage": 10,
        "week": week ?? "",
        "month": month ?? "",
        "year": year ?? "",
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> usersProfileRequest(token, userId) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/user/view_user"),
      body: json.encode({"token": token, "userId": userId}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}


Future<dynamic> editName(name) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json
          .encode({"token": getX.read(user_details.GETX_TOKEN), "name": name}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_NAME, decodedResponse["user"]["name"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editStatus() async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(user_details.GETX_TOKEN),
        "status": getX.read(user_details.GETX_STATUS)
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editAddress(address) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode(
          {"token": getX.read(user_details.GETX_TOKEN), "address": address}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_ADDRESS, decodedResponse["user"]["address"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editPhoneNumber(phoneNumber) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode(
          {"token": getX.read(user_details.GETX_TOKEN), "phone": phoneNumber}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_PHONE_NUMBER, decodedResponse["user"]["phone"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editEmail(email) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode(
          {"token": getX.read(user_details.GETX_TOKEN), "email": email}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_EMAIL, decodedResponse["user"]["email"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editDateOfBirth(dateOfBirth) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(user_details.GETX_TOKEN),
        "dateOfBirth": dateOfBirth
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_DOB, decodedResponse["user"]["date_of_birth"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editOccupation(occupation) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(user_details.GETX_TOKEN),
        "occupation": occupation
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_OCCUPATION, decodedResponse["user"]["occupation"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editGender() async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode({
        "token": getX.read(user_details.GETX_TOKEN),
        "gender": getX.read(user_details.GETX_GENDER)
      }),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_GENDER, decodedResponse["user"]["gender"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editHeight(height) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode(
          {"token": getX.read(user_details.GETX_TOKEN), "height": height}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_HEIGHT, decodedResponse["user"]["height"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editInterest(interest) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json.encode(
          {"token": getX.read(user_details.GETX_TOKEN), "interest": interest}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_INTEREST, decodedResponse["user"]["interest"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}

Future<dynamic> editBio(bio) async {
  try {
    http.Client client = http.Client();
    http.Response response = await client.post(
      Uri.https(endpointUrl, "/profile/edit_profile"),
      body: json
          .encode({"token": getX.read(user_details.GETX_TOKEN), "bio": bio}),
      headers: {"Content-Type": "application/json"},
    );
    dynamic decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "ok") {
      getX.write(user_details.GETX_BIO, decodedResponse["user"]["bio"]);
    }
    return decodedResponse;
  } catch (e) {
    print(e);
  }
}
