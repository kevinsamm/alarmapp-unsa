import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projects/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.red[700],
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 150),
            const Text(
              'Sistema de Alarma',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: Colors.red),
                    floatingLabelStyle: TextStyle(color: Colors.red),
                    border: InputBorder.none,
                    labelText: 'Correo electrónico',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                )
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.red),
                    floatingLabelStyle: TextStyle(color: Colors.red),
                    border: InputBorder.none,
                    labelText: 'Contraseña',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                )
            ),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                          fixedSize: const Size(140, 50)
                      ),
                      onPressed: signIn,
                      child: const Text(
                          'Ingresar', style: TextStyle(fontSize: 18))
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                          fixedSize: const Size(140, 50)
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                          'Registrarse', style: TextStyle(fontSize: 18))
                  )
                ]
            ),
            const SizedBox(height: 160,),
            Column(
              children: const [
                Text('Universidad Nacional de San Agustín',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Facultad de Ingeniería de Producción y Servicios',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Escuela profesional de Ingeniería Electrónica',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Proyecto de Fin de Carrera',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(height: 20),
                Text('Alumnos:', style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                Text('Colque Lopez, Edgar',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Sammillan Yupanqui, Kevin',
                  style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            )
          ]
        ),
      )
    );
  }
  User? user;
  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator())
    );
    try {
      user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      )) .user;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    var email = user?.email;
    Navigator.pop(context);
  }
}