import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/models/questions.dart';
import '../../../services/db_services.dart';

class HomeScreen extends ConsumerStatefulWidget{
  const HomeScreen({Key? key}): super(key: key);
  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>{
  @override
  Widget build(BuildContext context){
    final questions = ref.watch(dummyQuestionProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Home'),
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png',
                fit: BoxFit.fill,
              ),
            ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){},
            ),
          ],
          ),
                     SliverFillRemaining(
            child: Center(
              child: 
              questions.when(
                data: (data){
                  print(data);
                 return Text("data found");
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace){
                  return Text('Error: $error');
                },
              ),
            ),
          ),
          ],
          ),
      );
    
  }
}