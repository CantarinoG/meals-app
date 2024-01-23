import 'package:flutter/material.dart';
import '../models/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(
      {super.key, required this.onSettingsChanged, required this.settings});

  final Function(Settings) onSettingsChanged;
  final Settings settings;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(
        title,
      ),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Configuração",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _createSwitch(
                  "Sem Glutén",
                  "Só exibe refeições sem glutén.",
                  settings.isGlutenFree,
                  (value) {
                    setState(
                      () {
                        settings.isGlutenFree = value;
                      },
                    );
                  },
                ),
                _createSwitch(
                  "Sem Lactose",
                  "Só exibe refeições sem lactose.",
                  settings.isLactoseFree,
                  (value) {
                    setState(
                      () {
                        settings.isLactoseFree = value;
                      },
                    );
                  },
                ),
                _createSwitch(
                  "Vegano(a)",
                  "Só exibe refeições veganas.",
                  settings.isVegan,
                  (value) {
                    setState(
                      () {
                        settings.isVegan = value;
                      },
                    );
                  },
                ),
                _createSwitch(
                  "Vegetariano(a)",
                  "Só exibe refeições vegetarianas.",
                  settings.isVegetarian,
                  (value) {
                    setState(
                      () {
                        settings.isVegetarian = value;
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
