import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/screens/home_screen.dart';

class SearchUSerProfile extends StatelessWidget {
  final String? userId;
  const SearchUSerProfile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              currentIndex.value = 2;
              GoRouter.of(context).pop();
            },
            child: Text(userId!),),
      ),
    );
  }
}
