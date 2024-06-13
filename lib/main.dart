import 'package:flutter/material.dart';
import 'package:map_project/homepage.dart';
import 'package:map_project/models/cartModel.dart';
import 'package:map_project/user_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:map_project/log_in.dart';
import 'package:map_project/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDX--n817MRodzGctY-N0_QhtFUQtbtKsQ",
            authDomain: "map-project-86de7.firebaseapp.com",
            projectId: "map-project-86de7",
            storageBucket: "map-project-86de7.appspot.com",
            messagingSenderId: "498666861049",
            appId: "1:498666861049:web:17860e48b0a19a7a38cd28"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
