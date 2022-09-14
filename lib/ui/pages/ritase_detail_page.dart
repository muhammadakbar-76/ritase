import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ritase/cubit/page_cubit.dart';
import 'package:ritase/cubit/ritase_cubit.dart';
import 'package:ritase/cubit/unit_cubit.dart';
import 'package:ritase/db/unit_db_operation.dart';
import 'package:ritase/shared/theme.dart';
import 'package:ritase/ui/pages/ritase_edit_page.dart';
import 'package:ritase/ui/widgets/custom_button_widget.dart';
import 'package:ritase/ui/widgets/header_widget.dart';

class RitaseDetailPage extends StatelessWidget {
  RitaseDetailPage({
    super.key,
    required this.ritaseId,
  });

  final int ritaseId;

  final UnitDBOperation unitDbOperation = UnitDBOperation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: BlocConsumer<RitaseCubit, RitaseState>(
            listener: (context, state) {
              if (state is RitaseSended) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.meta['message']),
                    backgroundColor: cGreenColor,
                    dismissDirection: DismissDirection.up,
                  ),
                );
                Timer(const Duration(seconds: 3), () {
                  context.read<RitaseCubit>().getRitases();
                  context.read<PageCubit>().setPage(0);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                });
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
              if (state is RitaseSuccess) {
                var data =
                    state.ritases.firstWhere((e) => e.ritaseId == ritaseId);
                return Column(
                  children: [
                    const HeaderWidget(
                      title: 'Ritase Details',
                      subTitle: 'Edit or Delete data here',
                      back: true,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 150,
                      width: 150,
                      margin: const EdgeInsets.only(right: 12),
                      child: CircleAvatar(
                        backgroundColor: cSecondaryColor2,
                        child: Icon(
                          Icons.tram,
                          size: 110,
                          color: cSecondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text(
                            'Material : ',
                            style: tBlackText.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            data.ritaseMaterial,
                            style: tBlackText.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text(
                            'Kategori : ',
                            style: tBlackText.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            data.ritaseKategori,
                            style: tBlackText.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text(
                            'Keterangan : ',
                            style: tBlackText.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              data.ritaseKeterangan,
                              style: tBlackText.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text(
                            'Unit : ',
                            style: tBlackText.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                          BlocBuilder<UnitCubit, UnitState>(
                            builder: (context, state) {
                              if (state is UnitSuccess) {
                                var unit = state.units.firstWhere(
                                    (e) => e.unitKode == data.kodeUnit);
                                return Text(
                                  unit.name,
                                  style: tBlackText.copyWith(
                                    fontSize: 20,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text(
                            'Date : ',
                            style: tBlackText.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            data.ritaseDate,
                            style: tBlackText.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text(
                            'Time : ',
                            style: tBlackText.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            data.ritaseTime,
                            style: tBlackText.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CustomButtonWidget(
                        title: 'Edit',
                        eventFunc: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RitaseEditPage(
                                ritaseId: ritaseId,
                                kodeUnit: data.kodeUnit,
                              ),
                            ),
                          );
                        },
                        type: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CustomButtonWidget(
                        title: 'Delete',
                        eventFunc: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Are you sure?"),
                              content: const Text(
                                  "Item can't be retrieved after deleting"),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () =>
                                      Navigator.pop(context, "Cancel"),
                                ),
                                TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () async {
                                    Navigator.pop(context, "Yes");
                                    context
                                        .read<RitaseCubit>()
                                        .deleteRitase(ritaseId: ritaseId);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        type: 2,
                      ),
                    ),
                    const SizedBox(height: 70),
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
    );
  }
}
