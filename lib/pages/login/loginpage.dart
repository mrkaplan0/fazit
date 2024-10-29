import 'package:easy_localization/easy_localization.dart';
import 'package:fazit/contrast.dart';
import 'package:fazit/pages/login/register_page.dart';
import 'package:fazit/main.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/widgets/animated_progr_indicator.dart';
import 'package:fazit/widgets/animation_switcher.dart';
import 'package:fazit/widgets/email_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late String _password;

  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final String _passwordLabelText = 'Passwort';
  final String _passwordHintText = 'Passwort eingeben.';

  final String _invalidPassword =
      "Das Passwort muss mindestens 6 Zeichen lang sein";
  final String loginButtontext = "Anmelden";

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AnimatedSwitcherWidget(
              duration: 2,
              widget1:
                  const ContainerProgressIndicator(width: 150, height: 150),
              /* Image.asset(
                "assets/fazit_logo.png",
                width: 500,
                height: 500,
              ), */
              widget2: SizedBox(
                width: 500,
                height: 500,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        const Text("Anmeldung", style: myBigTitleTextStyle),
                        EmailFormField(
                            textEditingController: _emailController,
                            focusNode: focusNode,
                            focusNode2: focusNode2,
                            context: context),
                        passwordFormfield(context),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                              onPressed: _login, child: Text(loginButtontext)),
                        ),
                        const Spacer(flex: 3),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                                "Haben Sie Ihr Kennwort vergessen?")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ));
                            },
                            child: const Text("Registrieren"))
                      ],
                    )),
              ),
            ),
          ),
        ));
  }

  TextFormField passwordFormfield(BuildContext context) {
    return TextFormField(
      focusNode: focusNode2,
      initialValue: "1234555",
      obscureText: true,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: _passwordLabelText,
          hintText: _passwordHintText,
          suffixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.lock_outline_rounded),
          )),
      validator: (value) => value!.length < 6 ? _invalidPassword : null,
      onFieldSubmitted: (value) {
        focusNode2.unfocus();
      },
      onSaved: (String? gelenSifre) {
        _password = gelenSifre!;
      },
    );
  }

  Future _login() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        var createdUser = await ref
            .read(userViewModelProvider)
            .signInWithEmailAndPassword(_emailController.text, _password);
        if (createdUser != null) {
          debugPrint(createdUser.toString());
          if (mounted) {
            Navigator.popAndPushNamed(context, '/LandingPage');
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e);
      // ignore: use_build_context_synchronously
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text("${'Hata'.tr()}!"),
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Kapat".tr()))
          ],
        );
      },
    );
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.'.tr();
      case 'wrong-password':
        return 'Incorrect password.'.tr();
      case 'invalid-email':
        return 'Invalid email address.'.tr();
      case 'user-disabled':
        return 'This user account has been disabled.'.tr();
      case 'email-already-in-use':
        return 'The email has already been registered. Please login or reset your password.'
            .tr();
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}
