import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostScreen extends StatefulWidget {
  PostScreen({Key? key, required this.content}) : super(key: key);
  dynamic content;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('!!!!!!!!!!!! ${widget.content}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.keyboard_backspace_rounded,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        title: const Text(
          'Post',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(45, 38, 75, 1)),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(217, 217, 217, 1)),
                    // child: ,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.content["source"]["name"],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.content["publishedAt"]
                                .toString()
                                .substring(0, 10),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.content["publishedAt"].toString().substring(11, 16)} ${int.parse(widget.content["publishedAt"].toString().substring(11, 13)) > 11.99 ? 'PM' : 'AM'}",
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: const Color.fromRGBO(255, 255, 255, 1),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.content["urlToImage"].toString() ==
                                        "null"
                                    ? Container(
                                        width: double.infinity,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: const Color.fromRGBO(
                                              218, 218, 218, 0.4),
                                        ),
                                        child: const Icon(
                                          Icons.wifi_off_outlined,
                                          size: 40,
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: const Color.fromRGBO(
                                              218, 218, 218, 0.4),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              widget.content["urlToImage"],
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.content["title"],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.content["description"],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  widget.content["content"],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // const Spacer(),
                      Container(
                        // height: 20,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(219, 227, 255, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Share.share(widget.content["url"]);
                                },
                                child: const Icon(
                                  Icons.share,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
