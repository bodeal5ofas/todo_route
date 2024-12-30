import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/provider/app_config_provider.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: provider.appMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.changeLanguage('english');
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.english,
                              style: provider.appLanguage == "english"
                                  ? Theme.of(context).textTheme.titleSmall
                                  : Theme.of(context).textTheme.titleMedium,
                            ),
                            provider.appLanguage == 'english'
                                ? Icon(
                                    Icons.done,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Text(''),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.changeLanguage('arabic');
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.arabic,
                              style: provider.appLanguage == "arabic"
                                  ? Theme.of(context).textTheme.titleSmall
                                  : Theme.of(context).textTheme.titleMedium,
                            ),
                            provider.appLanguage == 'arabic'
                                ? Icon(
                                    Icons.done,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Text(''),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'arabic'
                        ? AppLocalizations.of(context)!.arabic
                        : AppLocalizations.of(context)!.english,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MyTheme.primaryLight),
                  ),
                  Icon(
                    Icons.arrow_downward_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: provider.appMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.changeTheme(ThemeMode.light);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.light,
                              style: provider.appMode == ThemeMode.light
                                  ? Theme.of(context).textTheme.titleSmall
                                  : Theme.of(context).textTheme.titleMedium,
                            ),
                            provider.appMode == ThemeMode.light
                                ? Icon(
                                    Icons.done,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Text(''),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.changeTheme(ThemeMode.dark);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dark,
                              style: provider.appMode == ThemeMode.dark
                                  ? Theme.of(context).textTheme.titleSmall
                                  : Theme.of(context).textTheme.titleMedium,
                            ),
                            provider.appMode == ThemeMode.dark
                                ? Icon(
                                    Icons.done,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Text(''),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appMode == ThemeMode.dark
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MyTheme.primaryLight),
                  ),
                  Icon(
                    Icons.arrow_downward_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
