import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(key: key,
      title: "Flutter demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),

    );
  }
}
const names=['Foo' , 'Bar' , 'Boo'];
extension RandomElement<T> on Iterable<T>{
  T GetRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);
  void PickRandomName() => emit(names.GetRandomElement());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NamesCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = NamesCubit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    cubit.close();
    super.dispose();
   }

  @override
    Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test flutter'),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context , snapshot) {
          final button = TextButton(onPressed: () => cubit.PickRandomName(), child: const Text('Randomizeaza'));
        switch (snapshot.connectionState){
          case ConnectionState.none: return button;
          case ConnectionState.waiting: return button;
          case ConnectionState.active: return Column(
            children: [Text(snapshot.data ?? '') , button],
          );
          case ConnectionState.done: return const SizedBox();
        }
        },
      ),
    );
  }
}

