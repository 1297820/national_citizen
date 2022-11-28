import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:national_citizen/utils/api_request.dart';

class UsersProfileScreen extends StatefulWidget {
  UsersProfileScreen({Key? key, required this.token, required this.userId})
      : super(key: key);
  String token;
  String userId;

  @override
  State<UsersProfileScreen> createState() => _UsersProfileScreenState();
}

class _UsersProfileScreenState extends State<UsersProfileScreen> {
  Future<dynamic>? profile;

  @override
  void initState() {
    super.initState();
    profile = usersProfileRequest(widget.token, widget.userId);
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
          'Profile',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(45, 38, 75, 1)),
        ),
      ),
      body: FutureBuilder(
        future: profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const FlutterLogo();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
            } else if (snapshot.hasData) {
              dynamic users = snapshot.data;
              if (users["status"] == "error") {
                return const CircularProgressIndicator();
              } else if (users["status"] == "ok") {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: users!['user']["img"].toString().isEmpty
                              ? Container(
                                  width: 120,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(218, 218, 218, 0.4),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.black54,
                                  ),
                                )
                              : Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color.fromRGBO(
                                        218, 218, 218, 0.4),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        users!['user']["img"],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          users['user']['name'].toString().isEmpty
                              ? 'Unknown'
                              : users['user']['name'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        const Text(
                          'Nigeria',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 0.5)),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        const Text(
                          'Jesus loves you, seek him',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(34, 34, 34, 0.5)),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 54,
                                  height: 54,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: const RadiantGradientMask(
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  users['user']['status'].toString().isEmpty
                                      ? "N/A"
                                      : users['user']['status'],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(0, 0, 0, 0.7)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          // height: 54,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                                blurRadius: 5,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Height',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(34, 34, 34, 0.5),
                                      ),
                                    ),
                                    Text(
                                      users['user']['height'].toString().isEmpty
                                          ? "N/A"
                                          : users['user']['height'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(0, 0, 0, 0.7)),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Gender',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(34, 34, 34, 0.5)),
                                    ),
                                    Text(
                                      users['user']['gender'].toString().isEmpty
                                          ? "N/A"
                                          : users['user']['gender'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(0, 0, 0, 0.7)),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'D.O.B',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(34, 34, 34, 0.5),
                                      ),
                                    ),
                                    Text(
                                      users['user']['date_of_birth']
                                              .toString()
                                              .isEmpty
                                          ? "N/A"
                                          : users['user']['date_of_birth'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(0, 0, 0, 0.7),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'BIO',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                users['user']['bio'].toString().isEmpty
                                    ? "No biological data available"
                                    : users['user']['bio'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(83, 83, 83, 1),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'INTEREST',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 98,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(233, 34, 178, 0.5),
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Center(
                                      child: Text(
                                        users['user']['interest'].toString() ==
                                                '[]'
                                            ? "interest 1"
                                            : users['user']['interest'][0],
                                        style: const TextStyle(
                                          fontSize: 11.75,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 98,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(161, 34, 206, 0.5),
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Center(
                                      child: Text(
                                        users['user']['interest'].toString() ==
                                                '[]'
                                            ? "interest 2"
                                            : users['user']['interest'][1],
                                        style: const TextStyle(
                                            fontSize: 11.75,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.4)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 98,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(38, 34, 233, 0.6),
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Center(
                                      child: Text(
                                        users['user']['interest'].toString() ==
                                                '[]'
                                            ? "interest 3"
                                            : users['user']['interest'][2],
                                        style: const TextStyle(
                                          fontSize: 11.75,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'OCCUPATION',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                users['user']['occupation'].toString().isEmpty
                                    ? "Unavailable"
                                    : users['user']['occupation'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(83, 83, 83, 1),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'CONTACT',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color.fromRGBO(83, 83, 83, 0.7),
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    users['user']['address'].toString().isEmpty
                                        ? "Unavailable"
                                        : users['user']['address'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(83, 83, 83, 1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.call_outlined,
                                    color: Color.fromRGBO(83, 83, 83, 0.7),
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    users['user']['phone'].toString().isEmpty
                                        ? "Unavailable"
                                        : users['user']['phone'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(83, 83, 83, 1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.mail_outline_rounded,
                                    color: Color.fromRGBO(83, 83, 83, 0.7),
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    users['user']['email'].toString().isEmpty
                                        ? ""
                                        : users['user']['email'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(83, 83, 83, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          }
          //What displays when device is connected to the internet before data is been fetched
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(154, 34, 240, 1),
            ),
          );
        },
      ),
    );
  }
}

//Help builds a gradient color to be applied on an icon
class RadiantGradientMask extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromRGBO(242, 34, 172, 1),
          Color.fromRGBO(151, 34, 242, 1),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
