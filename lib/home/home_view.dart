import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/custom_floating_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/home/settings/setting_body.dart';
import 'package:todo_app/home/task_list/task_list_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/login/login_view.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/provider/list_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'Home View';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> bodies = const [TaskListBody(), SettingBody()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.todo_list,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.tasksList = [];
                authProvider.user = null;
                Navigator.pushReplacementNamed(context, LoginView.id);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            index = value;

            setState(() {});
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: AppLocalizations.of(context)!.task_list,
            ),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.settings,
                ),
                label: AppLocalizations.of(context)!.setting),
          ]),
      floatingActionButton: const CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: bodies[index],
    );
  }
}
