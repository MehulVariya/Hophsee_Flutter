import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final void Function() onClick;

  const CustomDatePicker(
      {Key? key,
       required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onClick,
        child:Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration( border: Border.all(
            width: 2,
            color: Colors.grey.shade500
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),),
          child: Row(children: [
            const Icon(
              Icons.calendar_month,
              color: Colors.grey,
            ),
            const SizedBox(width: 14,),
            Text("Date Of Birth",style: TextStyle(fontSize: 16,color: Colors.grey.shade600),)
          ],),
        )
      ),
    );
  }
}