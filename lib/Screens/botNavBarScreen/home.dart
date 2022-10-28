import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/postScreen.dart';
import 'package:national_citizen/utils/apirequest.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0.5;
  Future<dynamic>? feeds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feeds = getNewsData();
    print('feeds >>>>>> $feeds');
  }

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Your profile is 50% complete',
              style: TextStyle(
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
              // color: const Color.fromRGBO(153, 34, 240, 1),
              backgroundColor: const Color.fromRGBO(211, 211, 211, 1),
            ),
            const SizedBox(
              height: 18,
            ),
            FutureBuilder(
              future: feeds,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const FlutterLogo();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const FlutterLogo();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return FlutterLogo();
                  } else if (snapshot.hasData) {
                    dynamic users = snapshot.data;
                    if (users["status"] == "error") {
                      return FlutterLogo();
                    } else if (users["status"] == "ok") {
                      
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: users["totalResults"],
                          itemBuilder: (context, int i) {
                            return Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: const Color.fromRGBO(255, 255, 255, 1),
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
                                                  users["articles"][i]["description"],
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: const Color.fromRGBO(
                                                        218, 218, 218, 0.4),
                                                    image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                        users["articles"][i]["urlToImage"],
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    // const Spacer(),
                                    Container(
                                      // height: 80,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(219, 227, 255, 1),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
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
                                                  users["articles"][i]["source"]["name"],
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PostScreen(content: users["articles"][i],),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    "View more >>",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
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
                            );
                          },
                        ),
                      );
                    }
                  }
                }
                return FlutterLogo();
              },
            )
          ],
        ),
      ),
    );
  }
}
