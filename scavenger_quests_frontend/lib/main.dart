// ignore_for_file: camel_case_types

import 'package:english_words/english_words.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const scav_quest_ui());


}

class scav_quest_ui extends StatelessWidget {
  const scav_quest_ui({super.key});



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => MyAppState(),
    child:MaterialApp(
        title: 'namer app',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
      ), 
    );
  }
}

class mystoryObj  {
  
  

  
  String name = "test";
  String discription =  "testdes";
  bool status = false;
  

  String getName()
  {
    return name;
  } 
   String getDiscr()
  {
    return discription;
  }
  bool getStatus()
  {
    return status;
  }
  
  
  

}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  
  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }
  var quests = <mystoryObj>[];
  void addQuests() {
    quests.add(mystoryObj());
  }
  void clearQuest(){
    quests.clear();
  }
}
// Active state 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  @override
NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
      page = const StatsPage();
      break;
      case 1:
      page = const MapPage();
      break;
      case 2:
      page = const MystoryDetails();
      break;
      default:
      throw UnimplementedError("no widget for $selectedIndex");
      
    }
    return LayoutBuilder(
      builder: (context,constraints) {
        
        return Scaffold(
        
       bottomNavigationBar:NavigationBar(
            labelBehavior: labelBehavior,
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.pages),
                label: 'STATS',
                
              ),
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                label: 'MAP',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.bookmark),
                icon: Icon(Icons.bookmark_border),
                label: 'DETAIS',
              ),
            ],
          ),
          body:page,
         
         
       
        );
      }
    );
  }
}


class MystoryDetails extends StatelessWidget {
  const MystoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

      return  ListView(
        
        
        children: [
          ElevatedButton(onPressed: () {
            
            appState.addQuests();
          } ,child: Text("add obj")),
          ElevatedButton(onPressed: () {
            
            appState.clearQuest();
          } ,child: Text("clear obj")),
          Padding(padding: EdgeInsets.all(20),child: Text('you have ${appState.quests.length} quests'),),
          for(mystoryObj quest in appState.quests) 
          ListTile(
            leading: Icon(Icons.one_x_mobiledata),
            title: Text(quest.getName()),
            subtitle: Text(quest.getDiscr()),
          ),
        ],
      );
    
  



  }
  
}
class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    IconData icon;
 
    
    return const Center(
      
      child: Text("map page"),
      
    );



  }
  
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return const Center(
      child: Text("this is the stats page"),
    
    );



  }
  
}
class styledButton extends StatelessWidget {
  const styledButton({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(pair.asLowerCase,style: style, semanticsLabel: "${pair.first} ${pair.second}",),
      ),
    );
  }
}