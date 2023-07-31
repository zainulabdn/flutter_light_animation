import 'package:flutter/material.dart';
import 'package:light_bulb_animation/wire.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool islighton=true;
  Offset initialPosition=const Offset(250, 0);
  Offset switchPosition=const Offset(350, 350);
  Offset containerPosition=const Offset(350, 350);
  Offset finalPosition=const Offset(350, 350);
  double lightlength=0;
  @override
  void didChangeDependencies() {
    final size = MediaQuery.of(context).size;
    initialPosition = Offset(size.width*.9, 0);
    containerPosition =  Offset(size.width*.9, size.height*.4);
    finalPosition =  Offset(size.width*.9, size.height*.5-size.width*.1);
    if(islighton){
      switchPosition=containerPosition;

    }else{
      switchPosition=finalPosition;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:const  Color(0xff374151),
      body: Stack(
        fit: StackFit.expand,
        children: [
           Container(
             color: Colors.transparent,
             alignment: Alignment.centerLeft,

             child: Stack(
               children: [
                 AspectRatio(
                   aspectRatio: 1,

                     child: Image.asset("assets/lamp.png")),
                 Positioned(
                   top: 80, right: 85,
                   child: ClipPath(
                     clipper: MySpotLightClipper(),
                     child: AnimatedContainer(
                       duration:const  Duration(milliseconds: 100),
                       decoration: BoxDecoration(
                         color: Colors.amber,
                         borderRadius: BorderRadius.circular(10),




                       ),
                       height: lightlength,
                       width: 150,

                     ),
                   ),
                 )
               ],
             ),
           ),
          Positioned(
            top: containerPosition.dy-size.width*.1/2-1,
              left: containerPosition.dx-size.width*.1/2-5,
              child: Container(
                height: size.height*.13+10,
                width: size.width*.1+10,
                decoration: BoxDecoration(
                color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color:Colors.black.withOpacity(0.7),
                        offset:const  Offset(5.0,5.0),
                        blurRadius: 10.0,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color:Colors.grey.shade900.withOpacity(0.5),
                        offset:const  Offset(-3.0,-3.0),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
            borderRadius: BorderRadius.circular(30)
          ),)),
          Wire(
            initialPosition:initialPosition,
            toOffset: switchPosition,
          ),
          AnimatedPositioned(
            duration:const Duration(microseconds: 0),
            top: switchPosition.dy-size.width*0.1/2,
            left: switchPosition.dx-size.width*0.1/2,
            child: Draggable(
                feedback:  Container(
                    height: size.height*.1,
                    width: size.width*.1,
                    decoration:const  BoxDecoration(
                      shape: BoxShape.circle,

                    )),
              onDragEnd:(details){

                if(islighton){
                  islighton= !islighton;
                  lightlength=260;
                      switchPosition=containerPosition;

                }else{
                  islighton= !islighton;
                  lightlength=0;
                  switchPosition=finalPosition;
                }

              } ,
              onDragUpdate: (details){
                setState(() {
                  switchPosition=details.localPosition;
                });
              },
                child:
            Container(
              height: size.height*.1,
              width: size.width*.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white,width: 3),
                color: Colors.amber,
              ),

            ),),
          )
        ],

      ),
    );
  }
}
class MySpotLightClipper extends CustomClipper<Path>{
  @override


  Path getClip(Size size) {

    Path path= Path();

    path.moveTo(size.width/2-20, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width/2+25, 0);

    path.close();
    return path;
  }
  /// this must be true
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>true;
// TODO: implement shouldReclip



}