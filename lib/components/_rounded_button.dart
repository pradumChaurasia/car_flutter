import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {
  // const RoundButton({super.key});

  RoundButton({required this.colour,required this.title, required this.onpressed});
  final Color colour;
  final String title;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child:Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(13.0),
        child:MaterialButton(
          onPressed: (){
            if(onpressed!=null){
              onpressed!();
            }
          },
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20.0
            ),
          ),
        )
      )

    );
  }
}
