import 'package:eco_kg/feature/test_feature/domain/entities/beginTestEntity.dart';
import 'package:eco_kg/feature/test_feature/domain/entities/nextQuestionEntity.dart';
import 'package:eco_kg/feature/test_feature/domain/entities/testIngoForBegin.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error_journal/error_journal.dart';
import '../../domain/entities/audit_test_list_entity.dart';
import '../../domain/repository/repository.dart';
import '../data_source/audit_server.dart';

@Injectable(as: AuditRepository)

class AuditRepositoryImpl implements AuditRepository{
  final AuditDataSource auditDataSource;
  AuditRepositoryImpl({required this.auditDataSource});

  @override
  Future<Either<Failure, List<AuditTest>>> auditTestList() {
    return _auditTestList();
  }

  Future<Either<Failure,List<AuditTest>>> _auditTestList() async{
    try{
      final auditTestList=await auditDataSource.auditTestList();
      return Right(auditTestList);
    }on Failure catch(e){
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure, List<AuditTest>>> auditConsultList() {
    return _auditConsultList();
  }

  Future<Either<Failure,List<AuditTest>>> _auditConsultList() async{
    try{
      final auditConsultList=await auditDataSource.auditConsultList();
      return Right(auditConsultList);
    }on Failure catch(e){
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure,bool>> denyAuditTestList(String testId){
    return _denyAuditTestList(testId);
  }

  Future<Either<Failure,bool>> _denyAuditTestList(String testId)async{
    try{
      final denyAuditTest=await auditDataSource.denyAuditTestList(testId);
      return Right(denyAuditTest);
    }on Failure catch(e){
      throw Left(ServerError(error: e));
    }
  }

  @override
  Future<Either<Failure,bool>> confirmAuditConsultList(String testId){
    return _confirmAuditConsultList(testId);
  }

  Future<Either<Failure,bool>> _confirmAuditConsultList(String testId)async{
    try{
      final confirmAuditConsult=await auditDataSource.confirmAuditConsultList(testId);
      return Right(confirmAuditConsult);
    }on Failure catch(e){
      throw Left(ServerError(error: e));
    }
  }

}