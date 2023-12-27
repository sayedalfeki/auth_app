
import 'package:auth_app/bloc/app_states.dart';
import 'package:auth_app/views/profile.dart';
import 'package:auth_app/views/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/users_bloc.dart';
import '../widget/helper_widget.dart';
import '../widget/logo.dart';
class LoginUser extends StatefulWidget{
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController passwordController=TextEditingController();

  TextEditingController userNameController=TextEditingController();



  bool remember=false;

  bool isHidden=true;

  bool showPassword=true;

  var loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppHelper appHelper=AppHelper(context);
    return BlocProvider(
      create: (context)=>UserBloc(),
      child: BlocConsumer<UserBloc,AppStates>(
        listener: (context,state){},
        builder:(context,state) {
          UserBloc model=UserBloc.instance(context);
          return Scaffold(
         // appBar: AppBar(title: LogoWidget(),),
          body: SafeArea(
            child: Container(
              width: double.infinity,
              //padding: const EdgeInsets.all(20),
              child: Form(
                key:loginKey,
                child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const LogoWidget(),
                    AppSizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppSizedBox(),
                              const AppText('login into your account'),
                              const SizedBox(height: 10,),
                              AppTextField(controller:userNameController,
                                  icon: Icons.email,
                                  label:'email',
                                  hint: 'example@email.com',
                                  onValidate: (value){
                                    if(value!.isEmpty) {
                                      return 'you must enter email';
                                    }
                                    return null;
                                  }

                              ),
                              const SizedBox(height: 10,),
                              AppTextField(controller:passwordController,
                                  label:'password',
                                  hint: 'enter your password',
                                  isPassword: isHidden,
                                  showPassword:true,
                                  icon: isHidden?Icons.lock:Icons.lock_open,
                                  onshowPassword: (){
                                    setState(() {
                                      isHidden=!isHidden;
                                    });
                                  },
                                  onValidate: (value){
                                    if(value!.isEmpty) {
                                      return 'you must enter password';
                                    }
                                    return null;
                                  }
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Checkbox(
                                      value:model.remember, onChanged:(value)
                                  {
                                    model.rememberMe();
                                  }),
                                  Expanded(child: AppText('remember me ',fontSize: 15)),

                                  TextButton(onPressed: (){}, child:AppText('Forget password?',
                                      fontSize: 15,textDecoration: TextDecoration.underline)),


                                ],
                              ),
                              const SizedBox(height: 10,),
                              WrapableContainer(
                                color: Colors.blue,
                                child: TextButton(onPressed:()async{
                                 // appHelper.navigate(UserProfile(id:1));
                                  if(loginKey.currentState!.validate()) {
                                    String userName = userNameController.text;
                                    String password = passwordController.text;
                                    Map loggedMap=await UserBloc().signIn(userName, password);
                                    if(loggedMap['logged'])
                                    {
                                      int id=loggedMap['data'];
                                     if(model.remember) {
                                       model.rememberUser(id);
                                     }
                                     appHelper.navigate(UserProfile(id:id));
                                    }
                                    else
                                    {
                                      appHelper.showSnackBar(loggedMap['data']);
                                    }
                                    //test-logIn(userName, password);
                                  }
                                }, child: AppText('log in',color: Colors.white,fontSize: 15)),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  AppText("Don't have an account ?",fontSize: 12,fontWeight: FontWeight.normal,),

                                  TextButton(onPressed: (){
                                    AppHelper(context).navigate(RegisterUser());
                                    //Navigator.pushReplacementNamed(context, RouteGenerator.registerPage);
                                  }, child:AppText('Register',

                                      fontSize: 15,textDecoration: TextDecoration.underline)),


                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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


