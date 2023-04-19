import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/allblocs/profilebloc/get_profile_bloc.dart';

class MyFlexiableAppBar extends StatelessWidget {
  const MyFlexiableAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wd = MediaQuery.of(context).size.width;

    return SafeArea(
      child: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (_, state) {
          if (state is GetProfileInitial) {
            BlocProvider.of<GetProfileBloc>(context)
                .add(const GetProfileEvent());
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is ProfileLoaded) {
            List<String> hobbies = state.profileModel.hobby!.split(" ");
            return Column(
              children: [
                SizedBox(
                  height: ht * 0.1,
                  child: CachedNetworkImage(
                    imageUrl: state.profileModel.imagelink!,
                    imageBuilder: (context, imageProvider) => Container(
                      width: wd * 0.2,
                      height: wd * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset("assets/images/add_profiles.png");
                    },
                  ),
                ),
                Text("${state.profileModel.username}"),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: ht * 0.05,
                  width: double.infinity,
                  child: Text(
                    state.profileModel.description ?? "Not Added",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        hobbies.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            label: Text(hobbies[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Text("${state.props.last}");
          }
        },
      ),
    );
  }
}
