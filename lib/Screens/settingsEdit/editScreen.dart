import 'package:flutter/material.dart';
import 'package:national_citizen/custom_widgets.dart';
import 'package:national_citizen/utils/api_request.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.editValue}) : super(key: key);
  String editValue;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  List<bool> isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  
  int day = 11;
  int month = 12;
  int year = 1997;
  int loadingState = 0;
  TextEditingController editController = TextEditingController();
  final interest = [
    "Animation",
    "Art",
    "Baking",
    "Blogging",
    "Cooking",
    "Dancing",
    "Drama",
    "Editing",
    "Fashion",
    "Hacking"
  ];
  List interests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
        ),
      ),
      body: widget.editValue == "Interest"?
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              width: MediaQuery.of(context).size.width/1.5,
              height: MediaQuery.of(context).size.height/1.3,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(241, 241, 241, 1)
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: interest.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            const SizedBox(
                                    height: 20,
                                  ),
                            GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isChecked[index] = !isChecked[index];
                                      });
                                      if(isChecked[index] == true){
                                        if(interests.length < 3){
                                          interests.add(interest[index]);
                                        } else {
                                          setState(() {
                                            isChecked[index] = false;
                                          });
                                          showToast('Max of 3 interests has been selected already', const Color.fromRGBO(153, 34, 240, 0.8));
                                        }
                                        
                                      } else {
                                        if (interest.contains(interest[index])){
                                          interests.remove(interest[index]);
                                        }
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          interest[index],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(62, 66, 69, 1),),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              border: Border.all(color: const Color.fromRGBO(155, 34, 238, 1)),
                                              color: const Color.fromRGBO(246, 232, 251, 1),
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                              ) ,
                                              side: BorderSide.none,
                                              checkColor: const Color.fromRGBO(155, 34, 238, 1),
                                                value: isChecked[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    isChecked[index] = !isChecked[index];
                                                  });
                                                  if(isChecked[index] == true){
                                                    if(interests.length < 3){
                                                      interests.add(interest[index]);
                                                    } else {
                                                      setState(() {
                                                        isChecked[index] = false;
                                                      });
                                                      showToast('Max of 3 interests has been selected already', const Color.fromRGBO(153, 34, 240, 0.8));
                                                    }
                                                    
                                                  } else {
                                                    if (interest.contains(interest[index])){
                                                      interests.remove(interest[index]);
                                                    }
                                                  }
                                                },
                                                fillColor: MaterialStateProperty.all<Color>(
                                                  const Color.fromRGBO(246, 232, 251, 1),
                                                ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                              const Divider(
                                height: 1,
                                color: Color.fromRGBO(211, 211, 211, 1),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: "Confirm",
            loadingState: loadingState, 
            onpressed: () async {
              if(interests.length != 3){
                showToast('Please select a max of 3 interesrs', const Color.fromRGBO(153, 34, 240, 0.8));
              } else{
                setState(() {
                    loadingState = 1;
                });
                dynamic response = await editInterest(interests.join(','));
                if(response["status"] == "ok"){
                  setState(() {
                    loadingState = 2;
                  });
                  showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                } else {
                  setState(() {
                    loadingState = 0;
                  });
                  showMyDialog(
                    context: context,
                    text: 'Error',
                    titleSize: 22,
                    contentTextSize: 12,
                    content:
                        'Something went wrong, please check your internet connection and try again',
                    buttonText: 'OK',
                  );
                }
                
              }
            }, 
            width: 120,
          ),
        ],
      ):
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // height: 143,
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(241, 241, 241, 1)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // widget.editValue == "Date of birth"?
                  // dateOfBirth():
                  editBox(),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            loadingState = 1;
                          });
                          if(widget.editValue == 'Name'){
                            dynamic response = await editName(editController.text.toString().trim());
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content:
                                    'Something went wrong, please check your internet connection and try again',
                                buttonText: 'OK',
                              );
                            }
                          } else if(widget.editValue == 'Status'){
                            dynamic response = await editStatus();
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content:
                                    'Something went wrong, please check your internet connection and try again',
                                buttonText: 'OK',
                              );
                            }
                          } else if(widget.editValue == "Address"){
                            dynamic response = await editAddress(editController.text.toString().trim());
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content:
                                    'Something went wrong, please check your internet connection and try again',
                                buttonText: 'OK',
                              );
                            }
                          } else if(widget.editValue == "Phone number"){
                            if(editController.text.toString().length > 11){
                              setState(() {
                                  loadingState = 0;
                                });
                              showToast('Phone number too long', Colors.red[700]);

                            } else {
                              dynamic response = await editPhoneNumber(editController.text.toString().trim());
                              if(response["status"] == "ok"){
                                setState(() {
                                  loadingState = 2;
                                });
                                showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                              } else {
                                setState(() {
                                  loadingState = 0;
                                });
                                showMyDialog(
                                  context: context,
                                  text: 'Error',
                                  titleSize: 22,
                                  contentTextSize: 12,
                                  content: response["msg"],
                                  buttonText: 'OK',
                                );
                              }
                            }
                            
                          } else if(widget.editValue == "Email"){
                            dynamic response = await editEmail(editController.text.toString().trim());
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content: response["msg"],
                                buttonText: 'OK',
                              );
                            }
                          } else if(widget.editValue == "Date of birth"){
                            //Check this guy out
                            dynamic response = await editDateOfBirth("$day/$month/$year");
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content:
                                    'Something went wrong, please check your internet connection and try again',
                                buttonText: 'OK',
                              );
                            }
                          } else if(widget.editValue == "Occupation"){
                            dynamic response = await editOccupation(editController.text.toString().trim());
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content:
                                    'Something went wrong, please check your internet connection and try again',
                                buttonText: 'OK',
                              );
                            }
                          } else if(widget.editValue == "Gender"){
                            dynamic response = await editGender();
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content:
                                    'Something went wrong, please check your internet connection and try again',
                                buttonText: 'OK',
                              );
                            }
                          } else if(widget.editValue == "Height"){
                            dynamic response = await editHeight(editController.text.toString().trim());
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content:
                                    'Something went wrong, please check your internet connection and try again',
                                buttonText: 'OK',
                              );
                            }
                          } 
                         
                           else if(widget.editValue == "Bio"){
                            dynamic response = await editBio(editController.text.toString().trim());
                            if(response["status"] == "ok"){
                              setState(() {
                                loadingState = 2;
                              });
                              showMyDialog(context: context, text: 'Done', titleSize: 22, content: 'Successfully updated your profile', buttonText: 'OK', contentTextSize: 12,);
                            } else {
                              setState(() {
                                loadingState = 0;
                              });
                              showMyDialog(
                                context: context,
                                text: 'Error',
                                titleSize: 22,
                                contentTextSize: 12,
                                content: response["msg"],
                                buttonText: 'OK',
                              );
                            }
                          }
                        },
                        child: buildButtonChild()
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonChild() {
  if (loadingState == 0) {
    return const Text(
      'Save',
      style: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(154, 34, 240, 1),
        fontWeight: FontWeight.w400,
      ),
    );
  } else if (loadingState == 1) {
    return const SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(color: Color.fromRGBO(154, 34, 240, 1),),
    );
  } else {
    return const SizedBox(
      height: 20,
      width: 20,
      child: Icon(Icons.check_rounded, color: Color.fromRGBO(154, 34, 240, 1),),
    );
  }
}

  DateTime currentDate = DateTime.now();

  show_calendar() async {
    DateTime? dateOfBirth = await showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(1990),
      lastDate: DateTime(2022),
      helpText: '2022',
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Theme( 
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Color.fromRGBO(246, 232, 251, 1) ,
                  onPrimary: Color.fromRGBO(0, 0, 0, 0.64),
                  onSurface: Color.fromRGBO(0, 0, 0, 0.8)       
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color.fromRGBO(127, 126, 130, 1), // button text color
                ),
              ),
            ),
            child: child!,
          ),
        )
      },
    );
    if (dateOfBirth != null) {
      setState(() {
        day = dateOfBirth.day;
        year = dateOfBirth.year;
        month = dateOfBirth.month;
      });
    }
  }

  Widget dateOfBirth (){
    return Column(
      children: [
        const Text(
          "Date of birth",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: GestureDetector(
            onTap: () {
              show_calendar();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                              246, 232, 251, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(
                                162, 162, 162, 1),
                            width: 2,
                          ),
                          borderRadius:
                              BorderRadius.circular(4),),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Text(
                          "$day",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color:
                                Color.fromRGBO(45, 38, 75, 1),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'DD',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(45, 38, 75, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                              246, 232, 251, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(
                                162, 162, 162, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Text(
                          "$month",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(45, 38, 75, 1),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'MM',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(45, 38, 75, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                              246, 232, 251, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(
                                162, 162, 162, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Text(
                          "$year",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(45, 38, 75, 1),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'YY',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(45, 38, 75, 1),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget editBox(){
    if(widget.editValue == "Name"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input your ${widget.editValue}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        TextField(
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          controller: editController,
          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
          autofocus: true,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 34, 240, 1),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 25, 10, 0),
            // hintText: 'Eric Walt',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(62, 66, 69, 0.7),
            ),
          ),
        ),
      ],
    );
    } else if(widget.editValue == "Status"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
           'Relationship Status',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(45, 38, 75, 1),
            ),
          ),
        ),
        SizedBox(height: 15,),
        RelationshipStatus()
      ],
    );
    }
    else if(widget.editValue == "Address"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         'Input your ${widget.editValue}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        TextField(
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          controller: editController,
          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
          autofocus: true,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 34, 240, 1),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 25, 10, 0),
            // hintText: 'Plot 1121, block 44, unity road, biden, ikeja, Lagos.',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(62, 66, 69, 0.7),
            ),
          ),
        ),
      ],
    );
    } else if(widget.editValue == "Phone number"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input your ${widget.editValue}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        TextField(
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          controller: editController,
          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
          autofocus: true,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 34, 240, 1),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 25, 10, 0),
            // hintText: '07044332211',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(62, 66, 69, 0.7),
            ),
          ),
        ),
      ],
    );
    } else if(widget.editValue == "Email"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input your ${widget.editValue} address',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        TextField(
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          controller: editController,
          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
          autofocus: true,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 34, 240, 1),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 25, 10, 0),
            // hintText: 'ericWalt@gmail.com',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(62, 66, 69, 0.7),
            ),
          ),
        ),
      ],
    );
    } else if(widget.editValue == "Occupation"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your ${widget.editValue}?",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        TextField(
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          controller: editController,
          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
          autofocus: true,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 34, 240, 1),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 25, 10, 0),
            // hintText: 'Software Developer',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(62, 66, 69, 0.7),
            ),
          ),
        ),
      ],
    );
    } else if(widget.editValue == "Gender"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
           "Gender",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(45, 38, 75, 1),
            ),
          ),
        ),
        SizedBox(height: 15,),
        Gender()
      ],
    );
    } else if(widget.editValue == "Height"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.editValue,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        TextField(
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          controller: editController,
          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
          autofocus: true,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 34, 240, 1),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 25, 10, 0),
            // hintText: '120cm',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(62, 66, 69, 0.7),
            ),
          ),
        ),
      ],
    );
    } else if(widget.editValue == "Date of birth"){
      return dateOfBirth();
    } else if(widget.editValue == "Bio"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's on your mind?",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        TextField(
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          controller: editController,
          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
          autofocus: true,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 34, 240, 1),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 25, 10, 0),
            // hintText: 'The man who does not read has no advantage over the man who can not read',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(62, 66, 69, 0.7),
            ),
          ),
        ),
      ],
    );
    }
    return SizedBox();
  }

}
