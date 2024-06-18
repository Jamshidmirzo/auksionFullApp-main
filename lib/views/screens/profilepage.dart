import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auksion_app/views/screens/loginpage.dart';
import 'package:auksion_app/views/screens/orderpage.dart';
import 'package:auksion_app/views/widgets/profilepagewidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  bool isDark = false;
  String smth = 'Change mode to dark';
  String smth1 = 'Change mode to light';
  String name = 'Alex';
  String photoURL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgsaRe2zqH_BBicvUorUseeTaE4kxPL2FmOQ&s';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('profile')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(photoURL), fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () async {
                final responce = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return const Profilepagewidget();
                    },
                  ),
                );
                if (responce != null) {
                  name = responce['name'];
                  photoURL = responce['url'];
                  setState(() {});
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr('update_profile'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Orderpage();
                    },
                  ),
                );
              },
              child: ListTile(
                leading: const Icon(CupertinoIcons.cart),
                title: Text(
                  context.tr('my_orders'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: ZoomTapAnimation(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Orderpage();
                        },
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_right_outlined,
                    size: 33,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr('language'),
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    value: context.locale,
                    items: const [
                      DropdownMenuItem(
                        value: Locale('uz'),
                        child: Text('🇺🇿'),
                      ),
                      DropdownMenuItem(
                        value: Locale('en'),
                        child: Text('🇺🇸'),
                      ),
                      DropdownMenuItem(
                        value: Locale('ru'),
                        child: Text('🇷🇺'),
                      )
                    ],
                    onChanged: (value) {
                      context.setLocale(value!);
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () async {
                SharedPreferences sharedpref =
                    await SharedPreferences.getInstance();
                sharedpref.remove('userData');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loginpage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr('logout'),
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () async {
                final themeMode = await AdaptiveTheme.getThemeMode();
                setState(() {
                  isDark = themeMode == AdaptiveThemeMode.dark;
                  if (isDark) {
                    AdaptiveTheme.of(context).setLight();
                  } else {
                    AdaptiveTheme.of(context).setDark();
                  }
                  isDark = !isDark;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isDark ? smth1 : smth,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
