import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/allblocs/globalpostbloc/global_post_bloc.dart';

import '../../../posts/ui_commons.dart';

class GlobalPage extends StatelessWidget {
  const GlobalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social"),
      ),
      body: BlocBuilder<GlobalPostBloc, GlobalPostState>(
        builder: (context, state) {
          if (state is GlobalPostLoadedState) {
            return ListView.builder(
                itemCount: state.model.length,
                itemBuilder: (context, index) => UiCommons.postCard(
                    model: state.model[index], likeClick: true,context: context));
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
