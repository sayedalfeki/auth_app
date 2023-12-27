import 'package:auth_app/bloc/users_bloc.dart';
import 'package:auth_app/views/login.dart';
import 'package:auth_app/views/profile.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  int? id=await UserBloc().getId();
  if(id!=null)
  {
    print(id);
  }
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: id!=null?UserProfile(id: id):const LoginUser(),
      )
      );
}

