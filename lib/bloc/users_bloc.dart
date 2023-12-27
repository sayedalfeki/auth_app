

import 'package:auth_app/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/app_states.dart';
class UserBloc extends Cubit<AppStates> {
  UserBloc() :super(InitState());
  static UserBloc instance(BuildContext context) => BlocProvider.of(context);
  Dio dio = Dio();
  UserModel userModel=UserModel();
  Map userInfo={};
bool remember=false;
int? id;
rememberMe()
{
  remember=!remember;
  emit(RememberState());
}


Future<Map<String, dynamic>> signIn(String userName, String password) async
  {

    try {

      Map user =
      {
        'username': userName,
        'password': password
      };
      Response response = await dio.post('https://dummyjson.com/auth/login', data: user);
      if (response.statusCode == 200) {
        if (response.data['username'] == userName) {
          return
           {
             'logged':true,
             'data':response.data['id']
           };
        }
        else
        {
          return
            {
              'logged':false,
              'data':response.data
            };
        }

      }
      else
      {
        return
          {
            'logged':false,
            'data':null,

          };
      }

    }
    catch (e) {
      print(e.toString());
      return
        {
          'logged':false,
          'data':e.toString()
        };

    }
  }

  Future<Map<String, dynamic>> signUp(String userName, String email, String password) async
  {
    try {

        Map user =
        {
          'username': userName,
          'email': email,
          'password': password
        };
        user.remove('username');
        Response response = await dio.post('https://reqres.in/api/register', data: user);
        if (response.statusCode == 200) {
          return
            {
              'registered': true,
              'data': response.data
            };
        }
        else {
          return
            {
              'registered': false,
              'data': response.data['error']
            };
        }
      }
      catch (e) {
        return
          {
            'registered': false,
            'data': e.toString()
          };
      }
    }


  rememberUser(int id)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setInt('id',id);
  }
  forgetUser()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove('id');
  }
  Future<int?>? getId()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getInt('id');
  }
  getUserById(int id)async
  {
    Response response=await dio.get('https://dummyjson.com/users/$id');
    if(response.statusCode==200)
    {
      userInfo=response.data;
      emit(UserInfoState());
    }
  }
}