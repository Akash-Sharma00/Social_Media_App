import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/all_routes/routes.dart';
import 'package:social_media/allblocs/chatroombloc/chatroom_bloc.dart';
import 'package:social_media/allblocs/commentbloc/commets_bloc.dart';
import 'package:social_media/allblocs/globalpostbloc/global_post_bloc.dart';
import 'package:social_media/allblocs/profilebloc/get_profile_bloc.dart';
import 'package:social_media/allblocs/userpostbloc/user_post_bloc.dart';
import 'package:social_media/repos/all_apis.dart';

import 'allblocs/authbloc/google_auth_bloc.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

Routes allroutes = Routes();

double ht = 0;
double wd = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repositories(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GoogleAuthBloc(),
          ),
          BlocProvider(
            create: (context) => GetProfileBloc(),
          ),
          BlocProvider(
            create: (context) => UserPostBloc()..add(const UserPostEvent()),
          ),
          BlocProvider(
            create: (context) => GlobalPostBloc()..add(const GlobalPostEvent()),
          ),
          BlocProvider(
            create: (context) => CommetsBloc(),
          ),
          BlocProvider(
            create: (context) => ChatroomBloc()..add(LoadChatRoomEvent()),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(useMaterial3: true, primarySwatch: Colors.green),
          debugShowCheckedModeBanner: false,
          routeInformationParser: allroutes.goRoute.routeInformationParser,
          routerDelegate: allroutes.goRoute.routerDelegate,
        ),
      ),
    );
  }
}
