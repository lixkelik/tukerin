import 'package:flutter/material.dart';
import 'package:tukerin/page/login_page.dart';
import 'package:tukerin/page/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin 
    ? LoginPage(onClickedRegister: toggle) 
    : RegisterPage(onClickedLogin: toggle);
  
  void toggle() => setState(() => isLogin = !isLogin,);
}