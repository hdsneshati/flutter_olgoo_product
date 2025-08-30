import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_olgoo_product/config/asset/icons_path.dart';
import 'package:flutter_olgoo_product/config/extentions/gap_space_extension.dart';
import 'package:flutter_olgoo_product/core/widgets/primary_button.dart';
import 'package:flutter_olgoo_product/core/widgets/primary_textbox.dart';
import 'package:flutter_olgoo_product/core/widgets/snackbar.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/bloc/auth/auth.bloc.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/bloc/auth/auth_status.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignupDetailsScreen extends StatelessWidget {
  SignupDetailsScreen({
    required this.companyNameController,
    required this.ownerNameController,
    
    super.key});
  final TextEditingController companyNameController ;
  final TextEditingController ownerNameController ;
  
  @override
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController instagramNameController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (MediaQuery.of(context).size.height * 0.14).verticalSpace,
            Padding(
              padding: const EdgeInsets.only(right: 20),
              //! app bar ------------------------------------------------------
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ثبت نام در الگو',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  (MediaQuery.of(context).size.height * 0.013).verticalSpace,
                  Text(
                    'یک حساب کاربری بسازید و شروع کنید',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            (MediaQuery.of(context).size.height * 0.025).verticalSpace,
            //! forms ------------------------------------------------------------
            PrimaryTextBox(
              controller: phonenumberController,
              iconPath: IconPath.company,
              title: "  شماره واتساپ (اگه دارید) ",
              hint: "شماره واتساپتون رو وارد کنید",
            ),
            8.0.verticalSpace,
            PrimaryTextBox(
              controller: instagramNameController,
              iconPath: IconPath.profile,
              title: " پیج اینستاگرام(اگه دارید)  ",
              hint: "اسم پیجتون رو وارد کنید",
            ),
            8.0.verticalSpace,
             //! action button ----------------------------------------------
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status is ErrorAuthStatus) {
                      SnackBars.errorSnackBar(context, "یه مشکلی پیش اومده",
                          (state.status as ErrorAuthStatus).errorMessage);
                    } else if (state.status is SuccessRegisterUser) {
                      context.goNamed("/giftSubscription");
                    }
                  },
                  builder: (context, state) {
                    return Center(
                        child: PrimaryButton(
                            action: () {
                              if (state.status is! LoadingAuthStatus) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    RegisterUserEvent(
                                        username: ownerNameController.text,
                                        companyName:
                                            companyNameController.text));
                              }
                            },
                            isPrimaryColor: true,
                            child: state.status is! LoadingAuthStatus
                                ? Text(
                                    "ادامه ",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  )
                                : LoadingAnimationWidget.threeArchedCircle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 30)));
                  },
                ),
                25.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
