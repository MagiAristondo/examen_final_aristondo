import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
import 'models/persona.dart';
import 'serveis/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _PersonaHomePageState createState() => _PersonaHomePageState();

}

class _PersonaHomePageState extends State<HomeScreen> {
  List<Persona> persones = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPersones();
  }

  Future<void> fetchPersones() async {
    try {
      // Carreguem les races de l'API
      final fetchedPersones = await ApiService.getPersones();
      setState(() {
        persones = fetchedPersones.cast<Persona>();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching persones: $error');
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ), 
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: persones.length,
              itemBuilder: (context, index) {
                final nom = persones[index];


                return ListTile(
                  title: Text(
                    nom as String,
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    
                  },
                );
              },
            ),
    );
  }
}
