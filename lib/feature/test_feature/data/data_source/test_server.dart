import 'package:eco_kg/feature/test_feature/domain/entities/beginTestEntity.dart';
import 'package:eco_kg/feature/test_feature/domain/entities/nextQuestionEntity.dart';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:eco_kg/core/constants/api_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/finishTestEntity.dart';
import '../../domain/entities/testIngoForBegin.dart';
import '../../domain/entities/testIngoForNext.dart';

abstract interface class ITestDataSource {
  Future<BeginTestEntity> postBeginTest(TestInfoForBegin testInfoForBegin);
}

@injectable
class TestDataSource implements ITestDataSource {
  final storage = const FlutterSecureStorage();
  @override
  Future<BeginTestEntity> postBeginTest(TestInfoForBegin testInfoForBegin) async {
    var uri = Uri(
      scheme: scheme,
      host: ip,
      path: 'api/test/begin-test',
    );

    final String? authKey = await storage.read(key: 'authKey');
    print('server $authKey');

    var json={
      'company_name' : testInfoForBegin.companyName,
      'company_director' : testInfoForBegin.companyDirector,
      'category_id' : testInfoForBegin.categoryId,
      'region' : testInfoForBegin.region,
      'phone' : testInfoForBegin.phone,
      'company_area' : testInfoForBegin.areaCompany
    };
    print(json);

    var response = await http.post(uri,body: json,headers: {'Authorization': 'Bearer $authKey'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      return BeginTestEntity.fromJson(jsonDecode(response.body).last);
    } else {
      //throw exception and catch it in UI
      print('error not found');
      print(response.statusCode);
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<BeginTestEntity> postBeginAuditTest(String testId) async {
    var uri = Uri(
      scheme: scheme,
      host: ip,
      path: 'api/test/auditor-check-test',
    );

    final String? authKey = await storage.read(key: 'authKey');
    print('server $authKey');

    var json={
      'test_id' : testId
    };
    print(json);

    var response = await http.post(uri,body: json,headers: {'Authorization': 'Bearer $authKey'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      return BeginTestEntity.fromJson(jsonDecode(response.body).last);
    } else {
      //throw exception and catch it in UI
      print('error not found');
      print(response.statusCode);
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<NextQuestionEntity> postNextTest(TestInfoForNext testInfoForNext) async {
    String? path;
    if(testInfoForNext.testType=='userTest'){
      path='api/test/next-question';
    }else{
      path='api/test/auditor-next-question';
    }
    print(path);
    var uri = Uri(
      scheme: scheme,
      host: ip,
      path: path,
    );

    final String? authKey = await storage.read(key: 'authKey');
    print('server $authKey');

    var json={
      'test_id' : testInfoForNext.test_id,
      'question_id' : testInfoForNext.question_id,
      'number' : testInfoForNext.number,
      'answer_id' : testInfoForNext.answer_id,
      'category_id' : testInfoForNext.category_id
    };
    print(json);

    var response = await http.post(uri,body: json,headers: {'Authorization': 'Bearer $authKey'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      return NextQuestionEntity.fromJson(jsonDecode(response.body));
    } else {
      //throw exception and catch it in UI
      print('error not found');
      print(response.statusCode);
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<FinishTestEntity> finishTest(TestInfoForNext testInfoForNext) async {
    var uri = Uri(
      scheme: scheme,
      host: ip,
      path: 'api/test/next-question',
    );

    final String? authKey = await storage.read(key: 'authKey');
    print('server $authKey');

    var json={
      'test_id' : testInfoForNext.test_id,
      'question_id' : testInfoForNext.question_id,
      'number' : testInfoForNext.number,
      'answer_id' : testInfoForNext.answer_id,
      'category_id' : testInfoForNext.category_id
    };
    print(json);

    var response = await http.post(uri,body: json,headers: {'Authorization': 'Bearer $authKey'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      return FinishTestEntity.fromJson(jsonDecode(response.body));
    } else {
      //throw exception and catch it in UI
      print('error not found');
      print(response.statusCode);
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }
}

