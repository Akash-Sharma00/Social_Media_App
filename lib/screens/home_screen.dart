import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/screens/pages/personal_chat_related/chat_page.dart';
import 'package:social_media/screens/pages/global_chat_related/global_page.dart';
import 'package:social_media/screens/pages/profiles/profile_page.dart';
import 'package:social_media/screens/pages/search_related/search_page.dart';

ValueNotifier<int> currentIndex = ValueNotifier(0);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<String?> function() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    return p.getString(AllKeys.imagelink);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, value, child) {
          List<Widget> pages = [
            const GlobalPage(),
            const SearchPage(),
            const ChatPage(),
            if (currentIndex.value == 3) const ProfilePage(),
          ];
          return IndexedStack(
            index: currentIndex.value,
            children: pages,
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            selectedItemColor: Colors.green,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.public),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
            currentIndex: currentIndex.value,
            onTap: (index) {
              currentIndex.value = index;
            },
          );
        },
      ),
    );
  }
}
