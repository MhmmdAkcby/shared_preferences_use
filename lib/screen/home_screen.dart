import 'package:flutter/material.dart';
import 'package:shared_preference/cache/shared_manager.dart';
import 'package:shared_preference/product/language/language_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends LoadingStatefull<HomeScreen> {
  String _currentValue = LanguageItem.appBarName.languageItems();
  late final SharedManager _manager;

  @override
  void initState() {
    super.initState();
    _manager = SharedManager();
    _initilaze();
  }

  Future<void> _initilaze() async {
    _changeLoading();
    await _manager.init();
    _changeLoading();

    _defaultValue();
  }

  Future<void> _defaultValue() async {
    _onChangeValue(_manager.getString(SharedKeys.action) ?? '');
  }

  void _onChangeValue(String value) {
    setState(() {
      _currentValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        title: Text(
          LanguageItem.appBarName.languageItems(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: _ColorsWidget().whiteColor),
        ),
        actions: [_isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink()],
      ),
      body: Column(children: [
        _CardWidget(currentValue: _currentValue),
        Padding(
          padding: _PaddingWidget.normalPadding,
          child: TextField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(), hintText: LanguageItem.textFieldHintText.languageItems()),
            onChanged: (value) {
              _onChangeValue(value);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_saveButton(), _removeButton()],
        )
      ]),
    );
  }

  ElevatedButton _removeButton() {
    return ElevatedButton(
        onPressed: () async {
          _changeLoading();
          await _manager.remove(SharedKeys.action);
          _changeLoading();
        },
        child: const Icon(Icons.delete));
  }

  ElevatedButton _saveButton() {
    return ElevatedButton(
        onPressed: (() async {
          _changeLoading();
          await _manager.saveString(SharedKeys.action, _currentValue);
          _changeLoading();
        }),
        child: Text(LanguageItem.elevatedButtonName.languageItems()));
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    super.key,
    required String currentValue,
  }) : _currentValue = currentValue;

  final String _currentValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: _WidgetSizes.height.value(),
      child: Card(
        color: _ColorsWidget().cardColor,
        child: Center(child: Text(_currentValue)),
      ),
    );
  }
}

class _PaddingWidget {
  static const normalPadding = EdgeInsets.all(8.0);
}

enum _WidgetSizes { height }

extension _WidgetSizesExtensions on _WidgetSizes {
  double value() {
    switch (this) {
      case _WidgetSizes.height:
        return 200;
    }
  }
}

class _ColorsWidget {
  final cardColor = Colors.grey[300];
  final whiteColor = Colors.white;
}

//Generic
abstract class LoadingStatefull<T extends StatefulWidget> extends State<T> {
  bool _isLoading = false;
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
