import 'package:eco_kg/core/auto_route/auto_route.dart';
import 'package:eco_kg/core/style/app_colors.dart';
import 'package:eco_kg/core/style/app_text_styles.dart';
import 'package:eco_kg/core/utils/utils.dart';
import 'package:eco_kg/feature/home_feature/domain/entities/userEnum.dart';
import 'package:eco_kg/feature/splash_feature/presentation/widget/button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/user.dart';
import '../../auth_feature/presentation/widgets/appBarLeadintBack.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/userDataBloc/user_data_bloc.dart';

class UserCabinetScreen extends StatelessWidget {
  const UserCabinetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UserData.userRole==UserEnum.applicant? context.text.applicants_cabinet : context.text.auditors_cabinet),
        leading: InkWell(
            onTap: () {
              AutoRouter.of(context).pop();
            },
            child: appBarLeading(context)),
        leadingWidth: 100.w,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 62).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: BlocBuilder<UserDataBloc, UserDataState>(
                builder: (context, state) {
    return Column(
                children: [
                  buildInfo(context.text.fullName,state.userData.name ?? 'Введите ФИО',context,true),
                  space(),
                  buildInfo(context.text.email,UserData.email!,context),
                  space(),
                  buildInfo(context.text.phone,state.userData.phone ?? 'Введите телефон',context,true),
                ],
              );
  },
),
            ),

            buttonWithIcon(context.text.delete_profile,'trash.png')
          ],
        ),
      )
    );
  }
  buildInfo(String leading,String info,BuildContext context,[bool icon=false]){
    return SizedBox(
      child: Row(
        children: [
          SizedBox(width: 110.w,child: Text(leading,style: AppTextStyles.clearSansMediumS14C82F500)),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Container(child: Text(info))),
                if(icon)
                  InkWell(onTap: (){
                    print('tap Edit');
                    AutoRouter.of(context).push(const EditUserCabinetRoute());
                  },child: Image.asset('assets/icon/edit.png',width: 24.w,height: 24.h,alignment: Alignment.centerRight,))
              ],
            ),
          ),

        ],
      ),
    );
  }
  space(){
    return Divider(
      height: 20.h,
      color: AppColors.colorD9D9D9,
    );
  }
}
