// ignore_for_file: must_be_immutable

import 'package:fazit/homepage.dart';
import 'package:fazit/login/loginpage.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/viewModels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoginStatus { Logined, NotLogin }

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userViewModelProvider).user;

    if (ref.watch(userViewModelProvider.notifier).state == ViewState.idle) {
      if (user == null) {
        return const LoginPage();
      } else if (user.isAdmin == true) {
        return  HomePage();
      } else {
        debugPrint("router home user $user");
        return const Scaffold(
          body: Center(
            child: Text("Wrong Way"),
          ),
        );
      }
    } else {
      return Container(
        color: Colors.white,
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.cyan,
        )),
      );
    }
  }
}
