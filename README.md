# fade_indexed_stack

An `IndexedStack` with `FadeTransition` and lazy loading.

## Inspirations
- [diegoveloper](https://github.com/diegoveloper) for the [gist](https://gist.github.com/diegoveloper/1cd23e79a31d0c18a67424f0cbdfd7ad) on how to apply `FadeTransition` to a `IndexedStack`.
- [okaryo](https://github.com/okaryo/) for the [lazy_load_indexed_stack](https://pub.dev/packages/lazy_load_indexed_stack) package.


## Usage

You can use `FadeIndexedStack` like you would use an `IndexedStack`.

```dart
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeIndexedStack(
        index: _currentIndex,
        children: [
          FirstPage(),
          SecondPage(),
          ThirdPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(),
          NavigationDestination(),
          NavigationDestination(),
        ],
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
```

For more details, check out the [example](example/lib/main.dart) file.
