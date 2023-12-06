import 'package:chatting_app/Widgets/login_textfields.dart';
import 'package:chatting_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  void loginUser(context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);

      Navigator.pushReplacementNamed(context, '/chat',
          arguments: userNameController.text);
      print("Login User");
    } else {
      print("Invalid");
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Uri gitUrl = Uri.parse('https://github.com/Omkar-t06');
    final Uri linkedInUrl =
        Uri.parse('https://www.linkedin.com/in/omkar-tavva-483451256');
    final theme = Theme.of(context);
    final elevatedButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: theme.primaryColor,
      foregroundColor: theme.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey),
              ),
              Image.asset(
                "assets/images/banner_image.png",
                height: 150,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginTextField(
                      controller: userNameController,
                      hintText: 'Enter your email',
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 5) {
                          return "Username must be at least 5 characters long";
                        } else if (value == null || value.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(8),
                    LoginTextField(
                      obscureText: true,
                      controller: passwordController,
                      hintText: "Enter your password",
                    ),
                  ],
                ),
              ),
              verticalSpace(8),
              ElevatedButton(
                onPressed: () {
                  loginUser(context);
                },
                style: elevatedButtonStyle,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(gitUrl)) {
                    throw Exception('Could not launch $gitUrl');
                  }
                },
                child: const Column(
                  children: [
                    Text("Find us on:"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton.github(
                    url: gitUrl.toString(),
                  ),
                  SocialMediaButton.linkedin(
                    url: linkedInUrl.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
