import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/settingsEdit/editProfileScreen.dart';
import 'package:national_citizen/Screens/settingsEdit/settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: const Icon(
        //     Icons.keyboard_backspace_rounded,
        //     color: Color.fromRGBO(45, 38, 75, 1),
        //   ),
        // ),
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(45, 38, 75, 1)),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.settings_outlined,
              color: Color.fromRGBO(45, 38, 75, 0.8),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.edit_outlined,
              color: Color.fromRGBO(45, 38, 75, 0.8),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/profile.png',
                          ),
                          scale: 3,
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            color: Colors.pink,
                            height: 90,
                            width: 90,
                            child: Image.asset('assets/images/profileImage.png')
                            // CachedNetworkImage(
                            //   imageUrl: 'assets/images/profileImage.png',
                            //   fit: BoxFit.cover,
                            //   placeholder: (context, url) => const SkeletonItem(
                            //     child: SkeletonAvatar(
                            //       style: SkeletonAvatarStyle(
                            //         width: double.maxFinite,
                            //         height: 120,
                            //       ),
                            //     ),
                            //   ),
                            //   errorWidget: (context, url, error) => Container(
                            //     color: Colors.white,
                            //     child: const Icon(Icons.person, color: Colors.grey, size: 30)
                            //   ),
                            // ),
                            ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: InkWell(
                        onTap: () async {},
                        child: const CircleAvatar(
                          minRadius: 17,
                          backgroundColor: Color.fromRGBO(153, 34, 240, 1),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Eric Waltz',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(0, 0, 0, 1)),
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
                      const Text(
                        'Single',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.7)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
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
                        child: const RotationTransition(
                          turns: AlwaysStoppedAnimation(240 / 360),
                          child: RadiantGradientMask(
                            child: Icon(
                              Icons.female_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.7)),
                      ),
                    ],
                  )
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
                  // shape: BoxShape.circle,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Speciality',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(34, 34, 34, 0.5),
                            ),
                          ),
                          Text(
                            'Designer',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 0.7)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Born',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(34, 34, 34, 0.5)),
                          ),
                          Text(
                            '02/02/1992',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 0.7)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Height',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(34, 34, 34, 0.5),
                            ),
                          ),
                          Text(
                            '165cm',
                            style: TextStyle(
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
                      height: 30,
                    ),
                    const Text(
                      "I believe that no one should ever have to choose" +
                          "between a career we love and living our lives with" +
                          "authencity and integrity. I’m confident in the choices i make.",
                      style: TextStyle(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 94,
                          height: 28,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(233, 34, 178, 0.5),
                                ),
                                elevation:
                                    MaterialStateProperty.all<double>(0)),
                            onPressed: () {},
                            child: const Text(
                              'Design',
                              style: TextStyle(
                                  fontSize: 11.75,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(0, 0, 0, 0.4)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 94,
                          height: 28,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(161, 34, 206, 0.5),
                                ),
                                elevation:
                                    MaterialStateProperty.all<double>(0)),
                            onPressed: () {},
                            child: const Text(
                              'Cooking',
                              style: TextStyle(
                                  fontSize: 11.75,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(0, 0, 0, 0.4)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 94,
                          height: 28,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(38, 34, 233, 0.6),
                                ),
                                elevation:
                                    MaterialStateProperty.all<double>(0)),
                            onPressed: () {},
                            child: const Text(
                              'Sports',
                              style: TextStyle(
                                  fontSize: 11.75,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(0, 0, 0, 0.4)),
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
                    const Text(
                      "Product Designer",
                      style: TextStyle(
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
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color.fromRGBO(83, 83, 83, 0.7),
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Plot 1122, block 23, unity road, Lagos",
                          style: TextStyle(
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
                      children: const [
                        Icon(
                          Icons.call_outlined,
                          color: Color.fromRGBO(83, 83, 83, 0.7),
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "08123222123",
                          style: TextStyle(
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
                      children: const [
                        Icon(
                          Icons.mail_outline_rounded,
                          color: Color.fromRGBO(83, 83, 83, 0.7),
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "EricW@gmail.com",
                          style: TextStyle(
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
      ),
    );
  }
}

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
