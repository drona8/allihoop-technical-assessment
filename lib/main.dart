import 'screens/app_wrapper_builder.dart';
import 'services/auth/auth_service.dart';

import 'styles/custom_app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/app_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: AppWrapperBuilder(
        builder: (context, userSnapshot) {
          return MaterialApp(
            theme: CustomAppTheme.lightTheme,
            home: AppWrapper(userSnapshot: userSnapshot),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
