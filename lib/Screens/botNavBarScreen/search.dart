import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/usersProfile.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/apirequest.dart';
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
  int? week;
  int? month;
  int? year;
  int? week_N;
  String? sort_option;
  int date = DateTime.now().day;

  @override
  void initState() {
    super.initState();
    print('date    $date');

    if (date <= 7) {
      week_N = 1;
    } else if (date > 7 && date <= 14) {
      week_N = 2;
    } else if (date > 14 && date <= 21) {
      week_N = 3;
    } else if (date > 21 && date <= 28) {
      week_N = 4;
    } else {
      week_N = 5;
    }
    print('week_N>>>>>>>> $week_N');
  }

  //Creates a popup menu for our sort search options
  sortOption() {
    return PopupMenuButton(
      icon: const Icon(
        Icons.tune_rounded,
        color: Colors.black45,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          // row has two child icon and text.
          child: Row(
            children: const [
              Text(
                'Search filter',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'Sort by',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 0.5,
                color: Color.fromRGBO(211, 211, 211, 1),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              week = week_N;
              month = DateTime.now().month;
              year = DateTime.now().year;
              sort_option = 'Week';
            });
          },
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'This week',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 0.5,
                color: Color.fromRGBO(211, 211, 211, 1),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              week = null;
              month = DateTime.now().month;
              year = DateTime.now().year;
              sort_option = 'Month';
            });
          },
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'This month',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 0.5,
                color: Color.fromRGBO(211, 211, 211, 1),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              week = null;
              month = null;
              year = DateTime.now().year;
              sort_option = 'Year';
            });
          },
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'This year',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

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
            sort_option!.isNotEmpty
                ? Text(
                    "$sort_option",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  )
                : const SizedBox(),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 245, 250, 1),
                  borderRadius: BorderRadius.circular(6)),
              child: TextField(
                cursorHeight: 25,
                onChanged: (value) async {
                  if (value.isEmpty) {
                    setState(() {
                      searchInput = value;
                      search = false;
                    });
                  } else if (value.isNotEmpty) {
                    searchUser = await searchUsers(value, 1, week, month, year);
                    setState(() {
                      users = searchUser!['users'];
                      searchInput = value;
                      search = true;
                    });
                  }
                },
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  prefixIconColor: const Color.fromRGBO(45, 38, 75, 1),
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 5, 5),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                  suffixIcon: sortOption(),
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
            searchInput.isNotEmpty
                ? searchUser!['msg'] != "success"
                    ? Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/noSearch.png',
                            scale: 1.5,
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 10,
                        child: ListView.builder(
                          itemCount: searchUser!['msg'] == "success"
                              ? users!.length
                              : 0,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UsersProfileScreen(
                                      token: getX.read(user_details.GETX_TOKEN),
                                      userId: users![i]['_id'],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                                child: Container(
                                  width: double.infinity,
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
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 8, 10),
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
                                                  color: Colors.transparent,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  child: CachedNetworkImage(
                                                    imageUrl: users![i]["img"],
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            const SkeletonItem(
                                                      child: SkeletonAvatar(
                                                        style:
                                                            SkeletonAvatarStyle(
                                                          width:
                                                              double.maxFinite,
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
                                              ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              users![i]['name']
                                                      .toString()
                                                      .isEmpty
                                                  ? 'Unkown'
                                                  : users![i]['name'],
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              users![i]['email']
                                                      .toString()
                                                      .isEmpty
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
                                          color:
                                              Color.fromRGBO(45, 38, 75, 0.6),
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
                        scale: 6,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
