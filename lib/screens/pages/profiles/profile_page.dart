import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/all_routes/routes_const.dart';
import 'package:social_media/common/my_widget.dart';
import 'package:social_media/posts/ui_commons.dart';
import 'package:social_media/screens/pages/profiles/sliverappbar.dart';

import '../../../allblocs/userpostbloc/user_post_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    // double wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: Colors.white,
              actions: [
                PopupMenuButton<String>(
                  color: Colors.black,
                  onSelected: (value) {
                    handleClick(value, context);
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Settings', "Edit Profile"}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
              expandedHeight: ht * 0.3,
              flexibleSpace: const FlexibleSpaceBar(
                background: MyFlexiableAppBar(),
              )),
          BlocBuilder<UserPostBloc, UserPostState>(
            builder: (context, state) {
              if (state is UserPostInitial) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, int index) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }, childCount: 1));
              } else if (state is UserPostLoadedState) {
                if (state.model.isEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, int index) {
                      return const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Center(
                          child: Text(
                              "Seems you haven't posted anything yet😕\nCreate your first post by click ➕ below"),
                        ),
                      );
                    }, childCount: 1),
                  );
                }
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, int index) {
                  return UiCommons.postCard(
                      model: state.model[index],
                      likeClick: false,
                      context: context);
                }, childCount: state.model.length));
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(RouteName.createpostscreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void handleClick(String value, BuildContext context) {
    switch (value) {
      case 'Edit Profile':
        mySnackBar(context, value);
        break;
      case 'Settings':
        mySnackBar(context, value);
        break;
    }
  }
}
