import 'dart:io';
import 'package:perfect_fitness/data/workout_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfect_fitness/screens/common_widgets/settings_container.dart';
import 'package:perfect_fitness/screens/common_widgets/settings_textfield.dart';
import 'package:perfect_fitness/core/const/color_constants.dart';
import 'package:perfect_fitness/core/const/path_constants.dart';
import 'package:perfect_fitness/core/const/text_constants.dart';
import 'package:perfect_fitness/core/service/auth_service.dart';
import 'package:perfect_fitness/screens/common_widgets/settings_container.dart';
import 'package:perfect_fitness/screens/edit_account/edit_account_screen.dart';
import 'package:perfect_fitness/screens/reminder/page/reminder_page.dart';
import 'package:perfect_fitness/screens/settings/bloc/bloc/settings_bloc.dart';
import 'package:perfect_fitness/screens/sign_in/page/sign_in_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  bool isNameInvalid = false;
  bool isEmailInvalid = false;
  String? photoUrl;
  late String userName;
  late String userEmail;

  @override
  void initState() {
    userName = user?.displayName ?? "No Username";
    userEmail = user?.email ?? 'No email';
    photoUrl = user?.photoURL ?? null;
    _nameController.text = userName;
    _emailController.text = userEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContext(context));
  }

  BlocProvider<SettingsBloc> _buildContext(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (_, currState) => currState is SettingsInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<SettingsBloc>(context);
          if (state is SettingsInitial) {
            bloc.add(SettingsReloadDisplayNameEvent());
            bloc.add(SettingsReloadImageEvent());
          }
          return _settingsContent(context);
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }

  Widget _settingsContent(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "No Username";
    photoUrl = user?.photoURL ?? null;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(alignment: Alignment.topRight, children: [
              Center(
                child: photoUrl == null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(PathConstants.profile),
                        radius: 60)
                    : CircleAvatar(
                        child: ClipOval(
                            child: FadeInImage.assetNetwork(
                          placeholder: PathConstants.profile,
                          image: photoUrl!,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 120,
                        )),
                        radius: 60,
                      ),
              ),
              TextButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditAccountScreen()));
                    setState(() {
                      photoUrl = user?.photoURL ?? null;
                    });
                  },
                  style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor:
                          ColorConstants.primaryColor.withOpacity(0.16)),
                  child: Icon(Icons.edit, color: ColorConstants.primaryColor)),
            ]),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(displayName,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),

            SizedBox(height: 15),
            // SettingsContainer(
            //   child: Text(TextConstants.reminder,
            //       style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            //   withArrow: true,
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (_) => ReminderPage()));
            //   },
            // ),
            if (!kIsWeb)
              //   SettingsContainer(
              //     child: Text(
              //         TextConstants.rateUsOn +
              //             '${Platform.isIOS ? 'App store' : 'Play market'}',
              //         style:
              //             TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              //     onTap: () {
              //       return launch(Platform.isIOS
              //           ? 'https://www.apple.com/app-store/'
              //           : 'https://play.google.com/store');
              //     },
              //   ),
              // SettingsContainer(
              //     onTap: () => launch('https://perpet.io/'),
              //     child: Text(TextConstants.terms,
              //         style:
              //             TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    TextConstants.fullName,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SettingsContainer(
                      child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(fontWeight: FontWeight.w600),
                    enabled: false,
                    controller: _nameController,
                  )),
                  if (isNameInvalid)
                    Text(TextConstants.nameShouldContain2Char,
                        style: TextStyle(color: ColorConstants.errorColor)),
                  Text(TextConstants.email,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SettingsContainer(
                      child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(fontWeight: FontWeight.w600),
                    enabled: false,
                    controller: _emailController,
                  )),
                  if (isEmailInvalid)
                    Text(TextConstants.emailErrorText,
                        style: TextStyle(color: ColorConstants.errorColor)),
                  SizedBox(height: 15),
                ],
              ),
            SettingsContainer(
                child: Text(TextConstants.signOut,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                onTap: () {
                  AuthService.signOut();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => SignInPage()),
                  // );
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => SignInPage()));
                }),
            SizedBox(height: 15),
            // Text(TextConstants.joinUs,
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            // SizedBox(height: 15),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextButton(
            //         onPressed: () =>
            //             launch('https://www.facebook.com/perpetio/'),
            //         style: TextButton.styleFrom(
            //             shape: CircleBorder(),
            //             backgroundColor: Colors.white,
            //             elevation: 1),
            //         child: Image.asset(PathConstants.facebook)),
            //     TextButton(
            //         onPressed: () =>
            //             launch('https://www.instagram.com/perpetio/'),
            //         style: TextButton.styleFrom(
            //             shape: CircleBorder(),
            //             backgroundColor: Colors.white,
            //             elevation: 1),
            //         child: Image.asset(PathConstants.instagram)),
            //     TextButton(
            //         onPressed: () => launch('https://twitter.com/perpetio'),
            //         style: TextButton.styleFrom(
            //             shape: CircleBorder(),
            //             backgroundColor: Colors.white,
            //             elevation: 1),
            //         child: Image.asset(PathConstants.twitter)),
            //   ],
            // )
          ]),
        ),
      ),
    );
  }
}
