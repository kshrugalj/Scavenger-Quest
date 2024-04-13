import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import 'API.dart';
import 'dart:convert';

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
      page = MystoryDetails();
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


class MystoryDetails extends StatefulWidget {
  const MystoryDetails({super.key});

  @override
  _MystoryDetails createState() => _MystoryDetails();
}

class _MystoryDetails extends State<MystoryDetails> {
  String url = '';

  var Data;
  String QueryText = 'Query';
  
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

      return  ListView(
        
        
        children: [
             
          //communicates with python code
          TextField(
            onChanged: (value) {
                  url = 'http://127.0.0.1:5000/api?Query=' + value.toString();
                  print('button pressed! url is $url');
                },
                decoration: InputDecoration(
                    hintText: 'Search Anything Here',
                    suffixIcon: GestureDetector(
                        onTap: () async {
                          print('we tapped!');
                          Data = await Getdata(url);
                          var DecodedData = jsonDecode(Data);
                          print('onTap called! data is $Data');
                          setState(() {
                            QueryText = DecodedData['Query'];
                          });
                        },
                        child: Icon(Icons.search))),
            ),
            //
          
          ElevatedButton(onPressed: () {
            
            appState.addQuests();
          } ,child: Text("add obj")),
          ElevatedButton(onPressed: () {
            
            appState.clearQuest();
            
           
          } ,child: Text("clear obj")),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              QueryText,
               style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),)
         , for(mystoryObj quest in appState.quests) 
          ListTile(
            leading: quest.getStatusIcon(),
            title: Text(quest.getName()),
            subtitle: Text(quest.getDiscr()),
          ),
        ],
      );
  }
  
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}


class _MapPageState extends State<MapPage> {
  ///////////////////////
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  LocationData? _userLocation;

  // This function will get user location
  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      _userLocation = locationData;
    });
  }
  ///////////////////////

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    IconData icon;
 
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Location'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: _getUserLocation,
                  child: const Text('Check Location')),
              const SizedBox(height: 25),
              // Display latitude & longtitude
              _userLocation != null
                  ? Wrap(
                      children: [
                        Text('Your latitude: ${_userLocation?.latitude}'),
                        const SizedBox(width: 10),
                        Text('Your longtitude: ${_userLocation?.longitude}')
                      ],
                    )
                  : const Text(
                      'Please enable location service and grant permission')
            ],
          ),
        ),
      ),
  );



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