import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchInput = '';
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
                // controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchInput = value;
                  });
                },
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
                      itemCount: 15,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
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
                              padding: const EdgeInsets.fromLTRB(10, 10, 8, 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/profileImage.png',
                                        ),
                                      ),
                                    ),
                                    // child: Image.asset(
                                    //   'assets/images/profileImage.png',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Alex Johnson',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'AlexJohnson@gmail.com',
                                        style: TextStyle(
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
