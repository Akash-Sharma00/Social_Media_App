// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/main.dart';

import '../../all_routes/routes_const.dart';
import '../../allblocs/authbloc/google_auth_bloc.dart';
import 'google_signin.dart';

// ignore: must_be_immutable
class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ht = MediaQuery.of(context).size.height;
    wd = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Social Media",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: ht * 0.25,
                  width: double.infinity,
                  child: LottieBuilder.asset(
                    "assets/lottiefiles/login-intruction-popup.json",
                    reverse: true,
                    repeat: false,
                    fit: BoxFit.contain,
                  ),
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome back here,\nenter details to continue",
                      style: TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valide mail';
                      } else if (!value.endsWith("@gmail.com")) {
                        return 'Please enter valide mail';
                      }
                      return null;
                    },
                    controller: email,
                    decoration:
                        const InputDecoration(hintText: "Enter email/username"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valide mail';
                      } else if (value.length < 6) {
                        return "Password is too weak";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: password,
                    decoration:
                        const InputDecoration(hintText: "Enter password"),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Forgot password?"),
                  ),
                ),
                SizedBox(
                  height: ht * 0.02,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user = await AuthFeature()
                          .logInWithmail(email.text, password.text, context);
                      if (user != null) {
                        GoRouter.of(context)
                            .pushReplacementNamed(RouteName.homescreen);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(double.infinity, ht * 0.06),
                  ),
                  child: const Text("Sign In"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.grey,
                      ),
                    ),
                    Text("OR"),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<GoogleAuthBloc, GoogleAuthState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: wd * 0.1),
                      child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                            minimumSize: Size(double.infinity, ht * 0.06),
                          ),
                          onPressed: () {
                            BlocProvider.of<GoogleAuthBloc>(context)
                                .add(GoogleSignInRequested(context: context));
                           
                          },
                          icon: state is AuthLoading
                              ? const CircularProgressIndicator.adaptive()
                              : const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.red,
                                ),
                          label: const Text("Continue with google")),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).pushNamed(RouteName.newuser);
                  },
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 17),
                      children: [
                        TextSpan(
                          text: "Don't have account yet?",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Create now!",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  goTonextPage(BuildContext context, String name) {
    GoRouter.of(context).pushReplacementNamed(name);
  }
}
