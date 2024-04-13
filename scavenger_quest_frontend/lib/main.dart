import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() 
{
  // The Main function for the entire program
  runApp(MyApp()); // Start the app
}

/////////////////// Basic App Config ///////////////////
class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

/////////////////// State Watcher ///////////////////
class MyAppState extends ChangeNotifier 
{
  var current = WordPair.random();

  void getNext() 
  {
    current = WordPair.random();
    notifyListeners(); // anyone Watching MyAppState is notified on this
  }
}

/////////////////// State of App (Controller) ///////////////////
class MyHomePage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold
    (
      body: Center(
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            NewCard(),
            BigWidget(pair: pair),
        
            ElevatedButton
            (
              onPressed: () 
              {
                // print('button pressed!'); // print to console
                appState.getNext();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigWidget extends StatelessWidget {
  const BigWidget({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // gets the application theme

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary, // sets the color to the theme
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        // child: Text(pair.asLowerCase),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}

class NewCard extends StatelessWidget 
{
  const NewCard
  ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Text('A random AWESOME idea:'),
    );
  }
}