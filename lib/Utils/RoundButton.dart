
import 'package:flutter/material.dart';
import 'package:prohour_assignment/Provider/NumberCheckingProvider.dart';
import 'package:prohour_assignment/Utils/utilsColors.dart';
// import 'package:loveria/Utils/AppComponentsColor.dart';
import 'package:provider/provider.dart';



class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback onpress;
  const RoundButton({Key? key, required this.title,  required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authprovider = Provider.of<Authprovider>(context,listen: false);

    return ElevatedButton(
        onPressed: (){
          onpress();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Componentscolor.primary),
            fixedSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.06)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Set the circular border radius here
              ),
            ),
          ),
          child: Consumer<NumberProvider>(
        builder: (context, phoneProvider, child)
    {
      return Text("kuchh nh");
    })
          // return phoneProvider.setenable(true)
          //     ? Center(
          //     child: CircularProgressIndicator(backgroundColor: Colors.white))
          //     : Center(
          //   child: Text(
          //     title,
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 16
          //     ),
          //   ),
          // );
        // }
        //   ),

    );






  }
}
