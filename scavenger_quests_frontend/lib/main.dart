// ignore_for_file: camel_case_types

//import 'dart:html';

// 11:33 AM 4/13/2024

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter/widgets.dart';
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
  String name = WordPair.random().first;
  String discription =  "${WordPair.random().first} ${WordPair.random().first} ${WordPair.random().first} ${WordPair.random().first} ${WordPair.random().first}";
  bool status = false;
  String workout = "some Workout";
  String possibleLocation = "some Location";
  String itemOfInterest = "some item";

  mystoryObj();

  mystoryObj.setStory(this.name, this.discription, this.status, this.workout, this.possibleLocation, this.itemOfInterest);
  Icon getStatusIcon()
  {
    if(status)
    return Icon(Icons.check);

    return Icon(Icons.close);
  }
  Widget get_clues()
  {
    return ListView(
      children: [
        Padding(padding: EdgeInsets.all(100)),
        Text(name),

      ],

    );
  }
  void setName(String Name)
  {
    name = Name;
  }
  String getName()
  {
    return name;
  } 
    String getWorkout()
  {
    return workout;
  } 
    String getLocHint()
  {
    return possibleLocation;
  } 
    String getItem()
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
  var current = WordPair.random(); // add database call here
  var quests = <mystoryObj>[];

  MyAppState() {
     mystoryObj nobj = mystoryObj.setStory("new story","you begin your amazing fitness journy.\npress next to go start your first chapter",true,"walking","test","the playground");
    
    //mystoryObj.setStory(this.name, this.discription, this.status, this.workout, this.possibleLocation, this.itemOfInterest);
    quests.add(nobj);
  }
  
  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }
  
  void addQuests() {
    quests.add(mystoryObj());
    notifyListeners();
  }
  void clearQuest(){
    quests.clear();
    mystoryObj nobj = mystoryObj.setStory("new story","you begin your amazing fitness journy.\npress next to go start your first chapter",true,"walking","test","the playground");
    
    //mystoryObj.setStory(this.name, this.discription, this.status, this.workout, this.possibleLocation, this.itemOfInterest);
    quests.add(nobj);

    notifyListeners();
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
          Padding(padding: EdgeInsets.all(20),child: Text('you have ${appState.quests.length-1} quests'),),
          for(mystoryObj quest in appState.quests) 
          ListTile(
            leading: quest.getStatusIcon(),
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
 
    
return Scaffold(body: Text("map page"),);



  }
  
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
mystoryObj currentObj = appState.quests.last;

 return Scaffold(
    
    body: ListView(
      
      children: <Widget>[
        
        ElevatedButton(onPressed: (){
          appState.quests.last.status = true;

        }, child: Text("complete task")),
        Column(
          
          children: [
            const SizedBox(height: 2),
            Container(
              height: 50,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Center(child: Text(currentObj.getName()))
            ),
             Align(
              alignment: Alignment.centerLeft,
               child: Container(
                height: 2000,
                color: Theme.of(context).colorScheme.background,
                 child: Column(
                  children: <Widget>[
                 // mainAxisAlignment: MainAxisAlignment.start,
                  descriptionBox(currentObj: currentObj),
                  HintWidget(currentObj: currentObj),
                  actionWidget(currentObj: currentObj),
                               
                  ]
                 
                           ),
               ),
             ),

              ],
            )
          ],
        ),




      
      

    );



  }
  
}

class actionWidget extends StatelessWidget {
  const actionWidget({
    super.key,
    required this.currentObj,
  });

  final mystoryObj currentObj;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Row(children:[Text("ACTION: ${currentObj.getWorkout()}")]),
    );
  }
}

class HintWidget extends StatelessWidget {
  const HintWidget({
    super.key,
    required this.currentObj,
  });

  final mystoryObj currentObj;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Row(children:[Text("HINT: ${currentObj.getLocHint()}")]),
    );
  }
}

class descriptionBox extends StatelessWidget {
  const descriptionBox({
    super.key,
    required this.currentObj,
  });

  final mystoryObj currentObj;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Row(children:[Text("discription: ${currentObj.getDiscr()}")]),
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