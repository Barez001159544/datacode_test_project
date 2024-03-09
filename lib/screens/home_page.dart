import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Fetch and display\nreal-time prices for BitCoin", style: TextStyle(color: Colors.purpleAccent, fontSize: 34), textAlign: TextAlign.center,),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/exchange',);
              },
              child: const Text("Proceed"),),
          ],
        ),
      ),
    );
  }
}
