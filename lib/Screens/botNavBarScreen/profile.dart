import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/settingsEdit/editProfileScreen.dart';
import 'package:national_citizen/Screens/settingsEdit/settings.dart';
import 'package:national_citizen/utils/apirequest.dart';
import 'package:national_citizen/utils/constants.dart';
import 'package:skeletons/skeletons.dart';
import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<dynamic>? profile;
  File? image;

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        getX.write(user_details.GETX_IMAGE, this.image);
      });
    } catch (e) {
      return print(e);
    }
  }

  setProfilePicture(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select from:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.camera);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromRGBO(153, 34, 240, 1),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Camera",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromRGBO(153, 34, 240, 1),
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  Future<dynamic>? profileDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(" name  ${getX.read(user_details.GETX_NAME)}");
    profileFunction();
    profileDetails = profileRequest();
  }

  profileFunction() async {
    print('******** rannnnnn');
    Map<String, dynamic> response;
    response = await profileRequest();
    if (response["status"] == "ok") {
      getX.write(user_details.GETX_NAME, response['user']["name"]);
      print(" name updated  ${getX.read(user_details.GETX_NAME)}");
      getX.write(user_details.GETX_STATUS, response['user']["status"]);
      getX.write(user_details.GETX_ADDRESS, response['user']["address"]);
      getX.write(user_details.GETX_PHONE_NUMBER, response['user']["phone"]);
      getX.write(user_details.GETX_EMAIL, response['user']["email"]);
      getX.write(user_details.GETX_DOB, response['user']["date_of_birth"]);
      getX.write(user_details.GETX_OCCUPATION, response['user']["occupation"]);
      getX.write(user_details.GETX_GENDER, response['user']["gender"]);
      getX.write(user_details.GETX_HEIGHT, response['user']["height"]);
      getX.write(user_details.GETX_INTEREST, response['user']["interest"]);
      getX.write(user_details.GETX_BIO, response['user']["bio"]);
    } else {
      // showToast(response["msg"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    profileFunction();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  )
                  .then((value) => setState(() {}));
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
      body: FutureBuilder(
        future: profileDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const FlutterLogo();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
            } else if (snapshot.hasData) {
              dynamic details = snapshot.data;
              if (details["status"] == "error") {
                return const CircularProgressIndicator();
              } else if (details["status"] == "ok") {
                print('@@@@@@ $details');
                return profileBody(
                  details['user']["img"],
                  getX.read(user_details.GETX_NAME).toString().isEmpty
                      ? 'Name'
                      : getX.read(user_details.GETX_NAME),
                  // details['user']["name"].toString().isEmpty ? 'Name': details['user']["name"],
                  // details['user']["status"].toString().isEmpty
                  //     ? 'status'
                  //     : details['user']["status"],
                  getX.read(user_details.GETX_STATUS).toString().isEmpty
                      ? 'status'
                      : getX.read(user_details.GETX_STATUS),
                  // details['user']["height"].toString().isEmpty
                  // ? 'in cm'
                  // : details['user']["height"],
                  getX.read(user_details.GETX_HEIGHT).toString().isEmpty
                      ? 'in cm'
                      : getX.read(user_details.GETX_HEIGHT),
                  // details['user']["gender"].toString().isEmpty
                  //     ? 'F/M'
                  //     : details['user']["gender"],
                  getX.read(user_details.GETX_GENDER).toString().isEmpty
                      ? 'F/M'
                      : getX.read(user_details.GETX_GENDER),
                  // details['user']["date_of_birth"].toString().isEmpty
                  //     ? 'DD/MM/YY'
                  //     : details['user']["date_of_birth"],
                  getX.read(user_details.GETX_DOB).toString().isEmpty
                      ? 'DD/MM/YY'
                      : getX.read(user_details.GETX_DOB),
                  // details['user']['bio'].toString().isEmpty
                  //     ? 'Tell us something about yourself'
                  //     : details['user']['bio'],
                  getX.read(user_details.GETX_BIO).toString().isEmpty
                      ? 'Tell us something about yourself'
                      : getX.read(user_details.GETX_BIO),
                  'Cooking',
                  'Dancing',
                  'Singing',
                  // details['user']['occupation'].toString().isEmpty
                  //     ? 'What do you do'
                  //     : details['user']['occupation'],
                  getX.read(user_details.GETX_OCCUPATION).toString().isEmpty
                      ? 'What do you do'
                      : getX.read(user_details.GETX_OCCUPATION),
                  // details['user']['address'].toString().isEmpty
                  //     ? 'Where do you live'
                  //     : details['user']['address'],
                  getX.read(user_details.GETX_ADDRESS).toString().isEmpty
                      ? 'Where do you live'
                      : getX.read(user_details.GETX_ADDRESS),
                  // details['user']['phone'].toString().isEmpty
                  //     ? 'Your phone number'
                  //     : details['user']['phone'],
                  getX.read(user_details.GETX_PHONE_NUMBER).toString().isEmpty
                      ? 'Your phone number'
                      : getX.read(user_details.GETX_PHONE_NUMBER),
                  // details['user']['email'].toString().isEmpty
                  //     ? 'Your email address'
                  //     : details['user']['email'],
                  getX.read(user_details.GETX_EMAIL).toString().isEmpty
                      ? 'Your email address'
                      : getX.read(user_details.GETX_EMAIL),
                );
              }
            }
          }
          return SizedBox();
        },
      ),
    );
  }

  profileBody(image, name, status, height, gender, dateOfBirth, bio, interest1,
      interest2, interest3, occupation, address, number, email) {
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
                        color: const Color.fromRGBO(240, 240, 240, 1),
                        height: 90,
                        width: 90,
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SkeletonItem(
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: double.maxFinite,
                                height: 120,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.white,
                            child: const Icon(Icons.person,
                                color: Colors.grey, size: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: InkWell(
                      onTap: () async {
                        setProfilePicture(context);
                      },
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
            Text(
              name,
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
                      status,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
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
                          height,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
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
                              color: Color.fromRGBO(34, 34, 34, 0.5)),
                        ),
                        Text(
                          gender,
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
                          dateOfBirth,
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
                    height: 30,
                  ),
                  Text(
                    bio,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 94,
                        height: 28,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(233, 34, 178, 0.5),
                              ),
                              elevation: MaterialStateProperty.all<double>(0)),
                          onPressed: () {},
                          child: Text(
                            interest1,
                            style: const TextStyle(
                              fontSize: 11.75,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        height: 28,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(161, 34, 206, 0.5),
                              ),
                              elevation: MaterialStateProperty.all<double>(0)),
                          onPressed: () {},
                          child: Text(
                            interest2,
                            style: const TextStyle(
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(38, 34, 233, 0.6),
                              ),
                              elevation: MaterialStateProperty.all<double>(0)),
                          onPressed: () {},
                          child: Text(
                            interest3,
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
                    occupation,
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
                        address,
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
                        number,
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
                        email,
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
