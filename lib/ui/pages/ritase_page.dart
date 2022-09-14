import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ritase/cubit/ritase_cubit.dart';
import 'package:ritase/shared/theme.dart';
import 'package:ritase/ui/widgets/header_widget.dart';
import 'package:ritase/ui/widgets/ritase_list_widget.dart';

class RitasePage extends StatelessWidget {
  const RitasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.83,
          child: SingleChildScrollView(
            child: BlocConsumer<RitaseCubit, RitaseState>(
              listener: (context, state) {
                if (state is RitaseFailed) {
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
                if (state is RitaseSuccess) {
                  return Column(
                    children: [
                      const SizedBox(height: 3),
                      const HeaderWidget(title: 'Ritase List'),
                      const SizedBox(height: 3),
                      Column(
                        children: state.ritases
                            .map((e) => RitaseListWidget(
                                  material: e.ritaseMaterial,
                                  kategori: e.ritaseKategori,
                                  time: e.ritaseTime,
                                  ritaseId: e.ritaseId,
                                ))
                            .toList(),
                      ),
                    ],
                  );
                } else if (state is RitaseLoading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SizedBox(
                        width: 80,
                        child: LoadingIndicator(
                          indicatorType: Indicator.pacman,
                          colors: [
                            cPrimaryColor,
                            cSecondaryColor,
                            cSecondaryColor2,
                          ],
                          strokeWidth: 0.5,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
