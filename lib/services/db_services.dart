import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/models/questions.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../utils/constants.dart';

class DBService{
  dynamic db, questionsCollection;
  bool isConnected = false;

  static Future<DBService> withDefaultDB() async{
    final dbService = DBService();
    await dbService.connect();
    return dbService;
  }

  Future<void> connect() async {
    if (isConnected) return;
    
    db = await Db.create(Constants.mongoUrl);
    await db.open();
    questionsCollection = db.collection(Constants.questionsCollection);
    isConnected = true;
  }

  Future<List<Question>> getQuestions(){
    return questionsCollection.find().toList().then((value) => value.map((e) => Question.fromJson(e)).toList())
      .then((value){
        print(value);
        return value;
      });
  }
  

  Future<void> addQuestion(Question question){
    return questionsCollection.insertOne(question.toJson()).then((value) => value).catchError((error) => throw error);
  }

  Future<void> updateQuestion(Question question){
    return questionsCollection.update(
      where.eq('_id', question.id),
      question.toJson()
    ).then((value) => value).catchError((error) => throw error);
  }
  Future<int> getDummyData() {
    return Future.delayed(const Duration(seconds: 2), () => 42);
  }

  Future<void> deleteQuestion(Question question){
    return questionsCollection.remove(where.eq('_id', question.id)).then((value) => value).catchError((error) => throw error);
  }
}

final dbServiceProvider = FutureProvider<DBService>((ref)  {
  final dbService =  DBService.withDefaultDB();
  return dbService;
});

final intProvider = FutureProvider.autoDispose<int>((ref)  {
  final dbService = ref.read(dbServiceProvider).requireValue;
  return dbService.getDummyData();
});

final dummyQuestionProvider = FutureProvider.autoDispose<List<Question>> ((ref) async {
  final dbService = ref.read(dbServiceProvider).requireValue;
  var d = await dbService.db.collection('questions').find().toList();
  if(d == null){
    return [];
  }
  return d.map((e) => Question.fromJson(e)).toList();
});

// create providers for questions
final questionsProvider = FutureProvider.autoDispose<List<Question>>((ref)  {

  final dbService =  ref.read(dbServiceProvider).requireValue;
  print('clling service');
  return dbService.getQuestions();
  //var d =  dbService.getQuestions();
  //print(d);
  //return d;
});
// final questionsProvider = FutureProvider.autoDispose<List<Question>>((ref) async {
//   final dbService = ref.read(dbServiceProvider);
//   return await dbService.then((value) => value.getQuestions());
// });