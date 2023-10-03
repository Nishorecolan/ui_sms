import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomSheetNew(),
    );
  }
}

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final String email = 'sample@gmail.com';

  int remainingMinutes = 15;

  @override
  void initState(){
    super.initState();


    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        if (remainingMinutes > 0) {
          remainingMinutes--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back, color: Colors.black),
          actions: [
            const CircleAvatar(
                child: Icon(Icons.question_mark, size: 18), radius: 12),
            const SizedBox(width: 20),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.close, size: 30, color: Colors.black),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(0, 255, 255, 255),
              Color.fromARGB(100, 133, 177, 232)
            ],
          )),
          child: Column(
            children: [
              LinearProgressIndicator(
                  value: 0.1, backgroundColor: Colors.grey.shade300),
              const SizedBox(height: 50),
              buildText(name: 'VERIFY IDENTITY', fontSize: 15),
              const SizedBox(height: 10),
              buildText(
                  name: 'Enter the code sent to:',
                  fontColor: Colors.blue.shade900,
                  fontSize: 25),
              const SizedBox(height: 10),
              buildText(name: maskEmail(email), fontSize: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildText(name: 'Verification Code'),
                    ),
                    const SizedBox(height: 30),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      cursorColor: Colors.black,
                      pinTheme: PinTheme(
                        activeColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        selectedColor: Colors.grey,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 70,
                        fieldWidth: 40,
                        activeFillColor: Colors.black,
                      ),
                      onCompleted: (val) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MobileNumber()));
                      },
                    ),
                    const SizedBox(height: 20),
                    buildText(
                        name:
                            'The code will expire in $remainingMinutes ${remainingMinutes == 1 ? "minute" : "minutes"} . If you haven\'t received it after a few minutes, check your junk folder.'),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildText(
                          name: 'Resend code', fontColor: Colors.blue.shade900),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  String maskEmail(String email) {

    List<String> parts = email.split('@');

    if (parts.length == 2) {
      String username = parts[0];
      String domain = parts[1];

      // Mask characters in username, keeping the first character and adding asterisks for the rest
      String maskedUsername = username[0] + '*' * (username.length - 2) + username[username.length - 1];

      // Get the first character of the domain
      String domainFirstChar = domain.isNotEmpty ? domain[0] : '';

      return '$maskedUsername@$domainFirstChar****.com';
    } else {
      // Invalid email address format
      return email;
    }
  }

  buildText({name,double fontSize = 15,fontColor}) {
    return Text(name,style: TextStyle(fontSize: fontSize,color: fontColor));
  }
}

class MobileNumber extends StatelessWidget {
  const MobileNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back, color: Colors.black),
          actions: [
            const CircleAvatar(
                child: Icon(Icons.question_mark, size: 18), radius: 12),
            const SizedBox(width: 20),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.close, size: 30, color: Colors.black),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(0, 255, 255, 255),
                Color.fromARGB(100, 133, 177, 232)
              ],
            )),
            child: Column(children: [
              LinearProgressIndicator(
                  value: 0.1, backgroundColor: Colors.grey.shade300),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                child: Column(
                  children: [
                    buildText(name: 'COMMUNICATION OPTIONS'),
                    const SizedBox(height: 30),
                    buildText(name: 'Enroll in text messaging(SMS) for your account.',fontColor: Colors.blue.shade900,fontSize: 25),
                    const SizedBox(height: 50),
                    const TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      decoration: InputDecoration(
                        counterText: '',
                          hintText: 'Mobile Number',
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left:20,right: 20,bottom: 40),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.grey.shade700),
                        child: Center(child: buildText(name: 'Continue', fontColor: Colors.white)),
                      ),
                      const SizedBox(height: 30),
                      buildText(name: 'Skip for now', fontColor: Colors.blue),
                    ],
                  ),
                ),
              ),
            ])));
  }

  buildText({name,double fontSize = 15,fontColor}) {
    return Text(name,style: TextStyle(fontSize: fontSize,color: fontColor));
  }
}

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  int remainingMinutes = 15;
  String phNumber = '9999994003';

  @override
  void initState(){
    super.initState();


    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        if (remainingMinutes > 0) {
          remainingMinutes--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: const [
            CircleAvatar(
                radius: 12,
                child: Icon(Icons.question_mark, size: 18)),
            SizedBox(width: 20),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.close, size: 30, color: Colors.black),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(0, 255, 255, 255),
                Color.fromARGB(100, 133, 177, 232)
              ],
            )),
            child: Column(children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                child: Column(
                  children: [
                    buildText(name: 'COMMUNICATION OPTIONS'),
                    const SizedBox(height: 30),
                    Padding(padding: const EdgeInsets.only(left:20,right: 20),child:
                    buildText(name: 'A confirmation text was sent to:',fontColor: Colors.blue.shade900,fontSize: 25)),
                    const SizedBox(height: 20),
                    buildText(name: '(***)***-${phNumber.substring(6)}',fontColor: Colors.black,fontSize: 22),
                    const SizedBox(height: 30),
                    buildText(name: 'Respond to complete SMS enrollment',fontColor: Colors.grey.shade700,fontSize: 16),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              const SizedBox(height: 100,width: 100,child:
              CircularProgressIndicator(strokeWidth: 6)),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left:20,right: 20,bottom: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      buildText(
                          name:
                              'The confirmation text will expire in $remainingMinutes ${remainingMinutes == 0 ? 'minute' : 'minutes' }'),
                      const SizedBox(height: 20),
                      buildText(
                          name: 'Resend confirmation',
                          fontColor: Colors.blue.shade900),
                    ],
                  ),
                ),
              ),
            ])));
  }

  buildText({name,double fontSize = 15,fontColor}) {
    return Text(name,style: TextStyle(fontSize: fontSize,color: fontColor),textAlign: TextAlign.center,);
  }
}

class BottomSheetNew extends StatefulWidget {
  const BottomSheetNew({super.key});

  @override
  State<BottomSheetNew> createState() => _BottomSheetNewState();
}

class _BottomSheetNewState extends State<BottomSheetNew> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                child: const Text("Bottom Sheet"),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                              color: Colors.white),
                          height: MediaQuery.of(context).size.height - 70,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Scrollbar(
                                      thickness: 6,
                                      radius: Radius.circular(10),
                                      thumbVisibility: true,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20),
                                            Container(
                                                color: Colors.grey,
                                                width: 30,
                                                height: 5),
                                            SizedBox(height: 40),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 30),
                                                child: buildText(
                                                    name:
                                                        'New York Life Electronic Consent and Discloure',
                                                    textAlign: TextAlign.center,
                                                    fontSize: 20,
                                                    fontColor: Colors.indigo)),
                                            SizedBox(height: 40),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 30),
                                              child: Column(
                                                children: [
                                                  buildText(
                                                      name:
                                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                                  SizedBox(height: 30),
                                                  Align(
                                                    child: buildText(
                                                        name:
                                                            "Lorem ipsum dolor sit amet, consectetur",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontColor: Colors.black,
                                                        fontSize: 16),
                                                    alignment: Alignment.topLeft,
                                                  ),
                                                  SizedBox(height: 20),
                                                  buildText(
                                                      name:
                                                          "Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."),
                                                  SizedBox(height: 20),
                                                  buildText(
                                                      name:
                                                          "In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains."),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Divider(color: Colors.black),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Checkbox(
                                                value: false,
                                                onChanged: (val) {}),
                                          ),
                                          Flexible(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0),
                                                  child: buildText(
                                                      name:
                                                          'I have read and agree to the New York Life Electronic Consent and Disclosure')))
                                        ],
                                      ),
                                      SizedBox(height: 50),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, bottom: 40),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.grey.shade700),
                                                child: Center(
                                                    child: buildText(
                                                        name: 'Continue',
                                                        fontColor:
                                                            Colors.white)),
                                              ),
                                              const SizedBox(height: 30),
                                              buildText(
                                                  name: 'Skip for now',
                                                  fontColor: Colors.blue),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                      context: context);
                })));
  }

  buildText({name,double fontSize = 15,fontColor,fontWeight = FontWeight.w400,textAlign = TextAlign.left}) {
    return Text(name,style: TextStyle(fontSize: fontSize,color: fontColor,fontWeight: fontWeight),textAlign: textAlign);
  }
}
