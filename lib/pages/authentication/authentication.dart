import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/functions.dart';
import 'package:flutter_web_dashboard/helpers/helper_functions.dart';
import 'package:flutter_web_dashboard/logic/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationPage extends StatefulWidget {


  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  final _controllerEmail=TextEditingController();
  final _controllerPassword=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(token);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.asset("assets/images/logo.png", width: 40,height: 40,)),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text("تسجيل الدخول",
                          style: GoogleFonts.roboto(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "مرحبًا بك مرة أخرى في لوحة الإدارة.",
                        color: lightGrey,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "example : Abc123@",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Checkbox(value: true, onChanged: (value) {}),
                  //         CustomText(text: "Remeber Me",),
                  //       ],
                  //     ),
                  //
                  //     CustomText(
                  //         text: "Forgot password?",
                  //         color: active
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if(isValidate()){
                        AuthCubit.get(context).loginAdmin(
                          userName: _controllerEmail.text.trim(),
                          password: _controllerPassword.text.trim(),onSuccess: (){
                           Navigator.pushNamed(context, "/");
                        }
                        );

                      }

                    },
                    child: Container(
                      height: 50,

                      decoration: BoxDecoration(color: active,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: AuthCubit.get(context).loadLogin?
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                      :
                      CustomText(
                        text: "Login",
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  // RichText(text: TextSpan(
                  //     children: [
                  //       TextSpan(text: "Do not have admin credentials? "),
                  //       TextSpan(
                  //           text: "Request Credentials! ", style: TextStyle(
                  //           color: active))
                  //     ]
                  // ))

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isValidate() {
    if(_controllerEmail.text.isEmpty){
      HelperFunctions.slt.notifyUser( context: context,color: Colors.black,
      message: "من فضلك ادخل الايميل");
      return false;
    }else if(_controllerPassword.text.isEmpty){

      HelperFunctions.slt.notifyUser( context: context,color: Colors.black,
          message: "من فضلك ادخل الرقم السرى");
      return false;
    }else{

      return true;
    }

  }
}
