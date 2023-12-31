import 'package:eco_kg/core/style/app_text_styles.dart';
import 'package:eco_kg/feature/auth_feature/presentation/widgets/button.dart';
import 'package:eco_kg/feature/consultation_feature/presentation/consultation_screen.dart';
import 'package:eco_kg/feature/splash_feature/presentation/widget/button_with_icon.dart';
import 'package:eco_kg/feature/test_feature/domain/entities/finishTestEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../get_certificate/presentation/get_certificate_screen.dart';
import '../../../home_feature/widget/bottom_background_image.dart';
import '../bloc/test_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});
  FinishTestEntity? finishTestEntity;
  String email='';
  String? testId;
  String? testType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right:16,top:62,bottom: 122).r,
            child: BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        if(state is LoadedResultTestState){
          finishTestEntity=state.finishTestEntity;
          email=state.email;
          testId=state.testId;
          testType=state.testType;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(finishTestEntity!.score!>57 ? 'assets/img/result_success.png' : 'assets/img/result_bad.png', height: 100.h, width: 100.w),
                    SizedBox(height: 62.h),
                    Text(testType=='auditTest' ? 'Балл заявителя: ${finishTestEntity!.score!}':'Ваш балл: ${finishTestEntity!.score!}',style: AppTextStyles.clearSansMediumS22W500CBlack,),
                  ],
                ),
                // SizedBox(height: 16.h),
                Text(finishTestEntity!.achievment!,style: AppTextStyles.clearSansS16cl82,textAlign: TextAlign.center),
                getCertificate(),
                Column(
                  children: [
                    Text(testType=='auditTest' ? 'Почта заявителя с результатами теста:':'Ваша почта с результатами теста:',style: AppTextStyles.clearSansS12C82F400,textAlign: TextAlign.center),
                    Text(email,style: AppTextStyles.clearSansS12C82F400,textAlign: TextAlign.center),
                  ],
                ),
                buttonNext(context,testType!)
              ],
            );
      },
          ),
          ),
          bottomBackgroungImage(context)
        ],
      ),
    );
  }
  getCertificate(){
    if(finishTestEntity!.score! > 73 && finishTestEntity!.score!<83) {
      return Column(
        children: [
          Image.asset('assets/icon/certificateGold.png', height: 100.h, width: 100.w),
        ],
      );
    } else if(finishTestEntity!.score! > 64 && finishTestEntity!.score!<74) {
      return Column(
        children: [
          Image.asset('assets/icon/certificateSilver.png',
              height: 100.h, width: 100.w),
        ],
      );
    } else if(finishTestEntity!.score! > 57 && finishTestEntity!.score!<65) {
      return Column(
        children: [
          Image.asset('assets/icon/certificateBronze.png',
              height: 100.h, width: 100.w),
        ],
      );
    } else if(finishTestEntity!.score! > 82 && finishTestEntity!.score!<101) {
      return Column(
        children: [
          Image.asset('assets/icon/certificatePlatinum.png',
              height: 100.h, width: 100.w),
        ],
      );
    }else{
      return const SizedBox();
    }
  }
  buttonNext(BuildContext context,String testTypeTemp){
    if(finishTestEntity!.score!<57) {
      return Column(
        children: [
          InkWell(child: buttonWithIcon('Получить консультацию', 'message-search.png'),onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ConsultationScreen(testId: testId!)));
          },),
          SizedBox(height: 32.h),
          InkWell(child: button(text: 'Пройти тест повторно'),onTap: (){
            AutoRouter.of(context).pop();
          },)
        ],
      );
    } else {
      return Column(
      children: [
        InkWell(child: button(text: testTypeTemp=='auditTest' ? 'Вернуться':'Пройти сертификацию'),onTap: (){
          testTypeTemp=='auditTest'? AutoRouter.of(context).pop() :
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>const GetCertificatScreen()));
        },)
      ],
    );
    }
  }
}
