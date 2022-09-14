import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ritase/cubit/ritase_cubit.dart';
import 'package:ritase/cubit/unit_cubit.dart';
import 'package:ritase/shared/theme.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Timer(const Duration(seconds: 3), () {
        context.read<UnitCubit>().getUnits();
        context.read<RitaseCubit>().getRitases();
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: cWhiteColor,
      body: BlocConsumer<RitaseCubit, RitaseState>(
        listener: (context, state) {
          if (state is RitaseSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (state is RitaseFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: cRedColor,
                dismissDirection: DismissDirection.up,
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/icons/truck.gif',
                //   height: 100,
                //   width: 120,
                // ),
                const SizedBox(height: 24),
                state is RitaseLoading
                    ? SizedBox(
                        width: 80,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballPulseSync,
                          colors: [
                            cPrimaryColor,
                            cSecondaryColor,
                            cSecondaryColor2,
                          ],
                          strokeWidth: 0.5,
                        ),
                      )
                    : Text(
                        'Ritase',
                        style: tBlackText.copyWith(
                          fontSize: 32,
                          fontWeight: medium,
                          letterSpacing: 7,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
