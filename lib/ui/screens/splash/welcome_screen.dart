import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recipe_app/logic/blocs/auth/auth_bloc.dart';
import 'package:recipe_app/logic/blocs/auth/auth_event.dart';
import 'package:recipe_app/logic/blocs/auth/auth_state.dart';
import 'package:recipe_app/ui/screens/main/home_screen.dart';
import 'package:recipe_app/ui/screens/splash/onboarding_screen.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AppStartedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Future.delayed(Duration(seconds: 1), () {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          } else if (state is AuthUnauthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SplashScreen2()),
            );
          }
        });
      },
      child: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: 860,
            decoration: BoxDecoration(
              color: Color.fromRGBO(63, 180, 177, 1),
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(240),
                Image.asset(
                  'assets/images/logo.png',
                  color: Colors.white,
                  width: 234,
                  height: 234,
                ),
                Text(
                  'Meals On\n Demand',
                  style: TextStyle(
                      height: 1,
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return SplashScreen2();
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 209,
                    height: 60,
                    child: Center(
                      child: Text(
                        'Let’s start',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
