import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/use_case/denyAuditTest.dart';
part 'accept_audit_test_event.dart';
part 'accept_audit_test_state.dart';

class AcceptAuditTestBloc extends Bloc<AcceptAuditTestEvent, AcceptAuditTestState> {
  final storage = const FlutterSecureStorage();
  final DenyAuditTestUseCase denyAuditTestUseCase;
  AcceptAuditTestBloc({required this.denyAuditTestUseCase}) : super(AcceptAuditTestInitial()) {
    on<OnTapAcceptEvent>(_acceptAuditTest);
    on<CheckAcceptEvent>(_checkAccept);
    on<OnTapDenyEvent>(_denyAuditTest);
  }

  _acceptAuditTest(OnTapAcceptEvent event,Emitter emit)async{
    emit(LoadingAcceptAuditTestState());
    final String? accepted = await storage.read(key: 'acceptedAuditTestList');
    Set<String> acceptedList={};
    if(accepted!=null){
      acceptedList=accepted.split(',').toSet();
    }
    acceptedList.remove('');
    acceptedList.add(event.auditTestId);
    await storage.write(
        key: 'acceptedAuditTestList', value: acceptedList.toString().replaceAll('{','').replaceAll('}', '').replaceAll(' ', ''));
    emit(const AcceptedAuditTestState());
  }

  _denyAuditTest(OnTapDenyEvent event,Emitter emit)async{
    emit(LoadingAcceptAuditTestState());
    final either=await denyAuditTestUseCase.call(event.auditTestId);
    either.fold((error) => emit(ErrorAcceptAuditTestState(error: error)), (auditTestList){
      emit(const LoadedDenyAuditTestState());
    });
  }

  _checkAccept(CheckAcceptEvent event,Emitter emit)async{
    emit(LoadingAcceptAuditTestState());
    final String? accepted = await storage.read(key: 'acceptedAuditTestList');
    Set<String> acceptedList={};
    if(accepted!=null){
      acceptedList=accepted.split(',').toSet();
    }
    print(acceptedList.toString());
    acceptedList.remove('');
    if(acceptedList.contains(event.auditTestId)){
      emit(const AcceptedAuditTestState());
    }else{
      emit(const NewAuditTestState());
    }
  }
}
