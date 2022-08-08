import 'package:eco_process/repository/firestore.dart';
import 'package:eco_process/routes/routes.dart';
import 'package:eco_process/routes/navi_repository.dart';
import 'package:eco_process/views/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocs/post/bloc.dart';
import 'blocs/post_controller.dart';
import 'blocs/user_repository/bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyCmWiDuaCM4EJM5jpFrFI3xaQjUaAyXE5U",
      appId: "1:29092948700:web:d119a537d3d9be67ae6219",
      messagingSenderId: "29092948700",
      projectId: "ecorichprocess",
      storageBucket: "ecorichprocess.appspot.com",
    ),
  );

  final FireStoreDB _firestore = FireStoreDB();
  Get.put(PostController());

  runApp(
    MultiProvider(
      providers: [
        Provider<NaviRepository>(
          lazy: false,
          // dispose: (_, service) => service.dispose(),
          create: (_) => NaviRepository(),
        ),
        BlocProvider<PostBloc>(
            lazy: false,
            create: (BuildContext context) => PostBloc(
                initialState: const GetInit(postList: []),
                fireStoreDB: _firestore)),
        BlocProvider<UserRepositoryBloc>(
            lazy: false,
            create: (BuildContext context) => UserRepositoryBloc(initialState: UserInitStatus())),
      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _rootNavi = context.read<NaviRepository>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '로그인',
      // theme: _themeStore.darkMode ? themeDataDark : themeData,
      routes: Routes.routes,
      navigatorKey: _rootNavi.mainKey,
      // navigatorKey: NaviRepository.mainKey,
      home: SignInDemo(),
    );
  }
}
