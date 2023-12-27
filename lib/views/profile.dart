import 'package:auth_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_states.dart';
import '../bloc/users_bloc.dart';
import '../widget/helper_widget.dart';
import '../widget/logo.dart';

class UserProfile extends StatelessWidget {
   UserProfile({Key? key,required this.id}) : super(key: key);
  var profileKey=GlobalKey<FormState>();
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>UserBloc()..getUserById(id),
      child: BlocConsumer<UserBloc,AppStates>(
        listener: (context,state){},
        builder:(context,state) {
          //print('$id');
          UserBloc model=UserBloc.instance(context);
          //model.getUserById(id);
          String userName='',email='',gender='',image='';
          if(model.userInfo.isNotEmpty) {
             userName = model.userInfo['username'];
             email = model.userInfo['email'];
             gender = model.userInfo['gender'];
             image = model.userInfo['image'];
          }
          String profImage='https://reqres.in/img/faces/2-image.jpg';
          TextEditingController userNameController=TextEditingController(text:userName);
          TextEditingController emailController=TextEditingController(text:email);
          TextEditingController genderController=TextEditingController(text: gender);


          return Scaffold(
            // appBar: AppBar(title: LogoWidget(),),
            body: SafeArea(
              child:model.userInfo.isEmpty?const Center(
                child: CircularProgressIndicator(),
              ): Container(
                width: double.infinity,
                //padding: const EdgeInsets.all(20),
                child:Form(
                  key:profileKey,
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       LogoWidget(imageData:image,),
                      AppSizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppSizedBox(),
                                const SizedBox(height: 10,),
                                AppTextField(controller:userNameController,
                                    label:'user name',
                                    hint: '',

                                ),
                                const SizedBox(height: 10,),
                                AppTextField(controller:emailController,
                                  label:'email',
                                    hint: '',
                                ),
                                const SizedBox(height: 10,),
                                AppTextField(controller:genderController,
                                    label:'gender',
                                    hint: '',
                                ),
                                const SizedBox(height: 10,),
                                WrapableContainer(
                                  color: Colors.red,
                                  child: TextButton(onPressed:()async{
                                      model.forgetUser();
                                      AppHelper(context).navigate(const LoginUser());
                                  }, child: const AppText('log out',color: Colors.white,fontSize: 15)),
                                ),
                                const SizedBox(height: 10,),

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
