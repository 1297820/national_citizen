import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/usersProfile.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/apirequest.dart';
import 'package:national_citizen/utils/constants.dart';
import 'package:skeletons/skeletons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchInput = '';
  bool search = false;
  Map<String, dynamic>? searchUser;
  List<dynamic>? users;
//   List <Map<String, dynamic>> student = [
//   {
//    "user_id": 1,
//    "name": John
//   }
//   {
//    “user_id”: 2,
//    “name”: “Lisa”
//   }
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 24, 14, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 245, 250, 1),
                  borderRadius: BorderRadius.circular(6)),
              child: TextField(
                // cursorColor: const Color.fromRGBO(154, 34, 240, 1),
                cursorHeight: 25,
                onChanged: (value) async {
                  if (value.isEmpty) {
                    setState(() {
                      searchInput = value;
                      search = false;
                    });
                  } else if (value.isNotEmpty) {
                    searchUser = await searchUsers(value, 1);
                    setState(() {
                      users = searchUser!['users'];
                      searchInput = value;
                      search = true;
                    });
                  }
                  print('######### ${users!.length}');
                },
                // onChanged: (value) {
                //   setState(() {
                //     searchInput = value;
                //   });
                // },
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: const Color.fromRGBO(45, 38, 75, 1),
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 5, 5),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.tune_rounded),
                  ),
                  suffixIconColor: const Color.fromRGBO(45, 38, 75, 1),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            searchInput.isNotEmpty
                ? Text(
                    "Search result: '$searchInput'",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  )
                : const SizedBox(),
            // const Spacer(),
            searchInput.isNotEmpty
                ? Expanded(
                    flex: 10,
                    child: ListView.builder(
                      itemCount:
                          searchUser!['msg'] == "success" ? users!.length : 0,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UsersProfileScreen(
                                  token: getX.read(user_details.GETX_TOKEN),
                                  // userId: "6363b9421839a2fff6a1be98",
                                  userId: users![i]['_id'],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                            child: Container(
                              width: double.infinity,
                              // height: 54,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(4),
                                // shape: BoxShape.circle,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 8, 10),
                                child: Row(
                                  children: [
                                    users![i]["img"].toString().isEmpty
                                        ? Container(
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  218, 218, 218, 0.4),
                                            ),
                                            child: const Icon(
                                              Icons.person,
                                              size: 20,
                                              color: Colors.black54,
                                            ),
                                          )
                                        : Container(
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  218, 218, 218, 0.4),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: users![i]["img"],
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const SkeletonItem(
                                                child: SkeletonAvatar(
                                                  style: SkeletonAvatarStyle(
                                                    width: double.maxFinite,
                                                    height: 120,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                color: Colors.white,
                                                child: const Icon(
                                                  Icons.person,
                                                  color: Colors.grey,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          users![i]['name'].toString().isEmpty
                                              ? 'Unkown'
                                              : users![i]['name'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          users![i]['email'].toString().isEmpty
                                              ? 'Unkown@gmail.com'
                                              : users![i]['email'],
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.more_vert_outlined,
                                      color: Color.fromRGBO(45, 38, 75, 0.6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/Searching.png',
                        scale: 3.5,
                      ),
                    ),
                  ),

            // SvgPicture.asset(
            //   'assets/images/Searching.svg',
            //   color: const Color.fromRGBO(164, 34, 231, 1),
            //   // scale: 3,
            // ),
            // const Spacer()
          ],
        ),
      ),
    );
  }
}
