import 'package:flutter/material.dart';
import 'package:projects/home.dart';
import 'package:projects/login.dart';
import 'package:projects/serial.dart';
import 'package:projects/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de alarma',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(backgroundColor: Colors.red));
          } else if (snapshot.hasError){
            return const Center(child: Text('Un error ocurrió :('));
          } else if (snapshot.hasData){
            return const MyHomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const SerialPage(),
      const SettingsPage()
    ];
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Sistema de Alarma'),
        backgroundColor: Colors.red.shade900,
        ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.menu_open, color: Colors.white),
              title: const Text('Opciones de usuario', style: TextStyle(color: Colors.white),),
              tileColor: Colors.red[900],
            ),
            ListTile(
              title: const Text('Registrado como'),
              subtitle: Text(user.email!),
              leading: const Icon(Icons.account_circle_outlined),
            ),
            ListTile(
              title: const Text("Cerrar sesión"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.red.shade900,
        unselectedItemColor: Colors.black38,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_object),
            label: 'Serial data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red[900],
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

