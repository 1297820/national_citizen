import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/postScreen.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/api_request.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isLoadingIndicator = false;
  bool _hasNextPage = true;
  int pageIndex = 1;
  double value = 0.0;
  int valueI = 0;
  // int? score22;

  Future<dynamic>? feeds;
  List<dynamic> news = <dynamic>[];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    profilePercentage();
    //the "feeds" variable contains the response from the "getNewsData" function
    feeds = getNewsData(1);

    //This function helps us handle pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent / 1.25) {
        //If the user scrolls down to 80% of the available screen, the "_getMoreData" function will be executed
        _getMoreData();
      }
      if (_scrollController.offset >=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          isLoadingIndicator =
              true; // Helps render a loading widget on the buttom of the screen
        });
      }
    });
  }

  //This function calculates the percentage of user profile completion
  profilePercentage() {
    int email =
        getX.read(user_details.GETX_EMAIL).toString().isNotEmpty ? 10 : 0;
    int name = getX.read(user_details.GETX_NAME).toString().isNotEmpty ? 10 : 0;
    int status =
        getX.read(user_details.GETX_STATUS).toString().isNotEmpty ? 5 : 0;
    int address =
        getX.read(user_details.GETX_ADDRESS).toString().isNotEmpty ? 10 : 0;
    int phoneNumber =
        getX.read(user_details.GETX_PHONE_NUMBER).toString().isNotEmpty
            ? 10
            : 0;
    int dateOfBirth =
        getX.read(user_details.GETX_DOB).toString().isNotEmpty ? 10 : 0;
    int occupation =
        getX.read(user_details.GETX_OCCUPATION).toString().isNotEmpty ? 10 : 0;
    int gender =
        getX.read(user_details.GETX_GENDER).toString().isNotEmpty ? 10 : 0;
    int height =
        getX.read(user_details.GETX_HEIGHT).toString().isNotEmpty ? 5 : 0;
    int interest =
        getX.read(user_details.GETX_INTEREST).toString() == '[]' ? 0 : 5;
    int bio = getX.read(user_details.GETX_BIO).toString().isNotEmpty ? 5 : 0;
    int image =
        getX.read(user_details.GETX_IMAGE).toString().isNotEmpty ? 10 : 0;
    setState(() {
      value = (email +
              name +
              status +
              address +
              phoneNumber +
              dateOfBirth +
              occupation +
              gender +
              height +
              interest +
              bio +
              image) /
          100;
      valueI = email +
          name +
          status +
          address +
          phoneNumber +
          dateOfBirth +
          occupation +
          gender +
          height +
          interest +
          bio +
          image;
    });
    // print("###### $value");
  }

  @override
  Widget build(BuildContext context) {
    // score22 = 2;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 34,
            ),
            const Text(
              'Feeds',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            value == 1.0
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your profile is $valueI% complete',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      LinearProgressIndicator(
                        minHeight: 7,
                        value: value,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(156, 34, 237, 1),
                        ),
                        backgroundColor: const Color.fromRGBO(211, 211, 211, 1),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 18,
            ),
            FutureBuilder(
              future: feeds,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const SizedBox();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: SkeletonItem(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SkeletonParagraph(
                                        style: SkeletonParagraphStyle(
                                          lines: 5,
                                          spacing: 6,
                                          lineStyle: SkeletonLineStyle(
                                            randomLength: true,
                                            height: 10,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            minLength: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      flex: 1,
                                      child: SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 8),
                                    SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 10,
                                        width: 100,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const Spacer(),
                                    SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 10,
                                        width: 65,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                  } else if (snapshot.hasData) {
                    dynamic users = snapshot.data;
                    if (users["status"] == "error") {
                      return const CircularProgressIndicator();
                    } else if (users["status"] == "ok") {
                      news = users["articles"];
                      return Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: news.length,
                          itemBuilder: (context, int i) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PostScreen(
                                          content: news[i],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(13),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        news[i]["description"]
                                                                .toString()
                                                                .isEmpty
                                                            ? "Unknown"
                                                            : news[i]
                                                                ["description"],
                                                        maxLines: 5,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    news[i]["urlToImage"]
                                                                .toString() ==
                                                            "null"
                                                        ? Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    218,
                                                                    218,
                                                                    218,
                                                                    0.4),
                                                              ),
                                                              child: const Icon(
                                                                Icons
                                                                    .wifi_off_outlined,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          )
                                                        : Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    218,
                                                                    218,
                                                                    218,
                                                                    0.4),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      CachedNetworkImageProvider(
                                                                    news[i][
                                                                        "urlToImage"],
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  219, 227, 255, 1),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        news[i]["source"]
                                                                    ["name"]
                                                                .toString()
                                                                .isEmpty
                                                            ? "Unknown"
                                                            : news[i]["source"]
                                                                ["name"],
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Icon(
                                                        Icons.circle,
                                                        size: 4,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        "2d",
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      const Text(
                                                        "View more >>",
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                news.length - 1 == i
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: _buildProgressIndicator(),
                                      )
                                    : const SizedBox()
                              ],
                            );
                          },
                        ),
                      );
                    }
                  }
                }
                //What displays when device is connected to the internet and before data is been fetched
                return Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: SkeletonItem(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: SkeletonParagraph(
                                      style: SkeletonParagraphStyle(
                                        lines: 5,
                                        spacing: 6,
                                        lineStyle: SkeletonLineStyle(
                                          randomLength: true,
                                          height: 10,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          minLength: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    flex: 1,
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 8),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 10,
                                      width: 100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const Spacer(),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 10,
                                      width: 65,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // This widget builds a loading indicator for pagination
  Widget _buildProgressIndicator() {
    return isLoadingIndicator
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : const SizedBox();
  }

  //This function gets more news content from the server
  void _getMoreData() async {
    if (!isLoading && _hasNextPage) {
      setState(() {
        isLoading = true;
      });

      pageIndex += 1;
      var response = await https
          .get(
            Uri.parse("$url&pageSize=10&page=$pageIndex&$apiKey"),
          )
          .catchError((e) {});

      dynamic decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      if (decodedResponse['status'] == 'ok') {
        List<dynamic> tempList = <dynamic>[];

        for (int i = 0; i < decodedResponse['articles'].length; i++) {
          tempList.add(decodedResponse['articles'][i]);
        }

        if (tempList.isNotEmpty) {
          if (tempList.length == 10) {
            setState(() {
              isLoading = false;
              news.addAll(tempList);
            });
          } else {
            //if up to 10 items were not fetched it means we have reached the end of the list
            setState(() {
              isLoading = false;
              news.addAll(tempList);
              _hasNextPage = false;
            });
          }
        } else {
          // This means there is no more data
          // and therefore, we will not send another request
          setState(() {
            isLoading = false;
            _hasNextPage = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
