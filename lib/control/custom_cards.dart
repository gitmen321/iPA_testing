import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String currentTime;
  final String currentValue;
  final IconData icon;
  const CustomCard({
    super.key,required this.currentValue,required this.currentTime, required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16)
        ),
        child:  Column(
          children: [
            Text(currentTime,style: const TextStyle(
                color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10,),
             Icon(icon,color: Colors.white,size: 30,),
            const SizedBox(height: 10,),
            Text(currentValue,style: const TextStyle(
              color: Colors.white,fontSize: 16,),
            ),
          ],
        ),
      ),
    );
  }
}
