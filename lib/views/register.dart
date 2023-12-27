
import 'package:auth_app/bloc/app_states.dart';
import 'package:auth_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/users_bloc.dart';

import '../widget/helper_widget.dart';
import '../widget/logo.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController userNameController=TextEditingController();

  var registerForm=GlobalKey<FormState>();

  bool isHidden=true;
  @override
  Widget build(BuildContext context) {
    AppHelper appHelper=AppHelper(context);
    return BlocProvider(
      create: (context)=>UserBloc(),
      child: BlocConsumer<UserBloc,AppStates>(
        listener:(context,state){} ,
        builder:(context,state) {
          UserBloc model=UserBloc.instance(context);
          return Scaffold(
         // appBar: AppBar(title: AppText('register page'),),
          body: SafeArea(
            child: Container(
              width: double.infinity,
              //padding: const EdgeInsets.all(20),
              child: Form(
                key: registerForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LogoWidget(),
                    AppSizedBox(width: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppSizedBox(),
                              AppText('create new  account'),
                              const SizedBox(height: 10,),
                              AppTextField(controller:userNameController,
                                  icon: Icons.person,
                                  label:'user name',
                                  hint: 'enter user name',
                                  onValidate: (value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return 'you must enter user name';
                                    }
                                    return null;
                                  }
                              ),
                              const SizedBox(height: 10,),
                              AppTextField(controller:emailController,
                                  icon: Icons.email,
                                  label:'email',
                                  hint: 'example@email.com',
                                  onValidate: (value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return 'you must enter email';
                                    }
                                    return null;
                                  }
                              ),
                              const SizedBox(height: 10,
                              ),
                              AppTextField(controller:passwordController, label:'password',
                                  hint: 'enter password',
                                  isPassword: isHidden,
                                  icon: isHidden?Icons.lock:Icons.lock_open,
                                  showPassword: true,
                                  onshowPassword: ()
                                  {
                                    setState(() {
                                      isHidden=!isHidden;
                                    });
                                  },
                                  onValidate: (value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return 'you must enter password';
                                    }
                                    return null;
                                  }
                              ),
                              Row(

                                children: [
                                  Checkbox(
                                      value:model.remember, onChanged:(value)
                                  {
                                   model.rememberMe();
                                  }),
                                  Expanded(child: AppText('remember me ',fontSize: 15)),
                                  TextButton(onPressed: (){}, child:AppText('Have a problem?',
                                      fontSize: 15,textDecoration: TextDecoration.underline)),
                                ],
                              ),
                              AppSizedBox(),
                              WrapableContainer(
                                color: Colors.blue,
                                child: TextButton(onPressed: ()async{
                                  if(registerForm.currentState!.validate()) {
                                    String email = emailController.text;
                                    String userName = userNameController.text;
                                    String password = passwordController.text;
                                    Map data=await UserBloc().signUp(userName, email, password);
                                    if(data['registered'])
                                    {
                                     appHelper.showSnackBar('registered successfully');
                                      appHelper.navigate(const LoginUser());
                                    }
                                    else
                                    {
                                      appHelper.showSnackBar(data['data'].toString());
                                    }
                                  }

                                }, child: AppText('Register',color: Colors.white,fontSize: 15)),
                              ),
                              AppSizedBox(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  AppText('Already have an account ?',fontSize: 12,fontWeight: FontWeight.normal,),

                                  TextButton(onPressed: (){
                                    AppHelper(context).navigate(LoginUser());
                                    // Navigator.pushReplacementNamed(context, RouteGenerator.loginPage);
                                  }, child:AppText('Login',

                                      fontSize: 15,textDecoration: TextDecoration.underline)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        );
        },
      ),
    );
  }

}