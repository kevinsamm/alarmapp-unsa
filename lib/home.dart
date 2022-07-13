import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            height: 100,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Text('Estado: Activado/Desactivado',
              style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
          const SizedBox(height: 50),
          ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  primary: Colors.blueAccent,
                  fixedSize: const Size(250, 80)
              ),
              child: const Text('Activar',
                style: TextStyle(color: Colors.white, fontSize: 20),)
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  primary: Colors.red,
                  fixedSize: const Size(250, 80)
              ),
              child: const Text('Desactivar',
                style: TextStyle(color: Colors.white, fontSize: 20),)
          )
        ]
      ),
    );
  }
}