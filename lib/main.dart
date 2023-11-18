import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_list/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://hvyslowrljbhagxswlch.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh2eXNsb3dybGpiaGFneHN3bGNoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk3NzcyNjQsImV4cCI6MjAxNTM1MzI2NH0.DreHlprBLTK2iL-wqqOTzs1V6jVGebFIVrPCd_fJIx0");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
