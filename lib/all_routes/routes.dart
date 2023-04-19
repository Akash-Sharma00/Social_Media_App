import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/posts/create_post.dart';
import 'package:social_media/screens/auth/log_in.dart';
import 'package:social_media/screens/auth/new_user.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/pages/personal_chat_related/message_screen.dart';
import 'package:social_media/screens/pages/profiles/search_user_profile_screen.dart';
import 'package:social_media/screens/testing_page.dart';

class Routes {
  GoRouter goRoute = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) {
          // return const MaterialPage(child: TestPage());
          FirebaseAuth auth = FirebaseAuth.instance;
          final User? user = auth.currentUser;
          if (user == null) {
            return MaterialPage(child: LogInPage());
          } else {
            return const MaterialPage(child: HomeScreen());
          }
        },
      ),
      GoRoute(
          path: '/newuser',
          name: 'newuser',
          pageBuilder: (context, state) =>
              MaterialPage(child: NewUserScreen())),
      GoRoute(
        path: '/auth',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(child: LogInPage()),
      ),
      GoRoute(
        path: '/homescreen',
        name: 'homescreen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomeScreen());
        },
      ),
      GoRoute(
        path: '/createpostscreen',
        name: 'createpostscreen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: CreatePostScreen());
        },
      ),
      GoRoute(
        path: '/searchuserprofilescreen',
        name: 'searchuserprofilescreen',
        pageBuilder: (context, state) {
          String id = state.extra as String;
          return MaterialPage(
              child: SearchUSerProfile(
            userId: id,
          ));
        },
      ),
      GoRoute(
        path: '/personalmessagescreen',
        name: 'personalmessagescreen',
        pageBuilder: (context, state) {

          return  MaterialPage(child: MessagesScreen(name: state.queryParams['name'], receiverid:  state.queryParams['receiverid'], roomid:  state.queryParams['roomid'],image:  state.queryParams['image'],),);
        },
      ),
      GoRoute(
        path: '/test',
        name: 'test',
        pageBuilder: (context, state) => const MaterialPage(child: TestPage()),
      ),
    ],
  );
}
