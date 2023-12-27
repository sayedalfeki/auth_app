import 'package:auth_app/widget/helper_widget.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key,this.imageData}) : super(key: key);
final String? imageData;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          child: Image.asset('assets/images/frame.png'),
        ),
        Positioned(
          bottom:1,
          child: Stack(
            alignment: Alignment.center,
            children:[
              Transform.translate(
                offset: Offset(0, 40),
                child: WrapableContainer(
                    child: SizedBox(),
                  color: Colors.white,
                  width: 120,
                  height: 120,
                  radius: 10,
                  borderColor: Colors.white
                ),
              ),
              Transform.translate(
              offset: Offset(0,40),
              child:imageData!=null?
                    profileImageWidget(imageData!):
                  logoContainer()
              )],
          ),
          ),
      ],
    );
  }
  logoContainer()
  {
    return Container(
      height: 100,
      child:Image.asset('assets/images/intern.png'),
    );
  }
  profileImageWidget(String src)
  {
      return ClipOval(
clipBehavior: Clip.hardEdge,
          child:Image.network(src,width: 110,height: 110,fit: BoxFit.cover,)) ;

  }
}