// ignore_for_file: use_build_context_synchronously

import 'package:chatting_app/Widgets/login_textfields.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      await context.read<AuthService>().loginUser(userNameController.text);

      Navigator.pushReplacementNamed(context, '/chat',
          arguments: userNameController.text);
    } else {
      print('not successful!');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final Uri gitUrl = Uri.parse('https://github.com/Omkar-t06');
  final Uri instaUrl = Uri.parse('https://www.instagram.com/omkar_t6/');
  final Uri linkedInUrl =
      Uri.parse('https://www.linkedin.com/in/omkar-tavva-483451256');

  Widget _buildHeader(context) {
    return Column(
      children: [
        const Text(
          'Let\'s sign you in!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        const Text(
          'Welcome back! \n You\'ve been missed!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.blueGrey),
        ),
        Image.asset(
          "assets/images/banner_image.png",
          height: 150,
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Center(child: Text("Find us on:")),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                if (!await launchUrl(gitUrl)) {
                  throw Exception('Could not launch $gitUrl');
                }
              },
              icon: const Icon(
                SocialMediaIcons.github_squared,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () async {
                if (!await launchUrl(linkedInUrl)) {
                  throw Exception('Could not launch $linkedInUrl');
                }
              },
              icon: const Icon(
                SocialMediaIcons.linkedin_squared,
                color: Colors.blue,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () async {
                if (!await launchUrl(instaUrl)) {
                  throw Exception('Could not launch $instaUrl');
                }
              },
              icon: const Icon(
                SocialMediaIcons.instagram,
                color: Colors.pinkAccent,
                size: 35,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              LoginTextField(
                hintText: "Enter your username",
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 5) {
                    return "Username must be at least 5 characters long";
                  } else if (value == null || value.isEmpty) {
                    return "Username cannot be empty";
                  }
                  return null;
                },
                controller: userNameController,
              ),
              verticalSpace(8),
              LoginTextField(
                obscureText: true,
                controller: passwordController,
                hintText: 'Enter your password',
              ),
            ],
          ),
        ),
        verticalSpace(8),
        ElevatedButton(
          onPressed: () async {
            await loginUser(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.all(16),
          ),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1000) {
              // web layout
              return Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHeader(context),
                        _buildFooter(),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(child: _buildForm(context)),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                _buildForm(context),
                _buildFooter(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
