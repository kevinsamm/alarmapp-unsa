import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                  'Registrarse al sistema',
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        fixedSize: const Size(140, 50)
                    ),
                    onPressed: signUp,
                    child: const Text(
                        'Registrarse', style: TextStyle(fontSize: 18))
                ),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿Ya tienes una cuenta?', style: TextStyle(color: Colors.white, fontSize: 16),),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ingresar',style: TextStyle(color: Colors.yellow, fontSize: 16, decoration: TextDecoration.underline)))
                    ],
                ),
              ],
          ),
        )
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      return showDialog(
          context: context,
          //barrierDismissible: false,
          builder: (context) {
            return const AlertDialog(title: Text('Registro exitoso', style: TextStyle(fontSize: 16),));
          }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    //Navigator.pop(context);
  }
}