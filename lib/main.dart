import 'package:Cates/Provider/AuthProvider.dart';
import 'package:Cates/Provider/CatererProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'View/Screens/screen.dart';
import 'View/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<CatererProvider>(
            create: (context) => CatererProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: GoogleFonts.roboto().toString(),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/Login': (context) => Login(),
          '/Signup': (context) => SignUp(),
          '/HomeScreen': (context) => HomeScreen(),
          '/ForgotPasswordScreen': (context) => ForgotPassword(),
          '/BookMarkedCatererScreen': (context) => BookMarkedCaterersPage(),
        },
      ),
    );
  }
}
