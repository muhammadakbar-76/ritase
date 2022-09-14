import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ritase/cubit/page_cubit.dart';
import 'package:ritase/cubit/ritase_cubit.dart';
import 'package:ritase/cubit/unit_cubit.dart';
import 'package:ritase/db/unit_db_operation.dart';
import 'package:ritase/shared/theme.dart';
import 'package:ritase/ui/widgets/custom_button_widget.dart';
import 'package:ritase/ui/widgets/form_field_widget.dart';
import 'package:ritase/ui/widgets/header_widget.dart';

class RitaseEditPage extends HookWidget {
  RitaseEditPage({
    super.key,
    required this.ritaseId,
    required this.kodeUnit,
  });

  final int ritaseId;

  final int kodeUnit;

  final UnitDBOperation unitDbOperation = UnitDBOperation();

  @override
  Widget build(BuildContext context) {
    final formkey = useState(GlobalKey<FormState>());
    final unitKode = useState(1);
    final materialController = useTextEditingController();
    final kategoriController = useTextEditingController();
    final keteranganController = useTextEditingController();

    return Scaffold(
      backgroundColor: cWhiteColor,
      body: SafeArea(
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
              materialController.text = data.ritaseMaterial;
              kategoriController.text = data.ritaseKategori;
              keteranganController.text = data.ritaseKeterangan;

              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HeaderWidget(
                        title: 'Edit Ritase',
                        subTitle: 'Fill all input to edit Ritase',
                        back: true,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Form(
                          key: formkey.value,
                          child: Column(
                            children: [
                              BlocBuilder<UnitCubit, UnitState>(
                                builder: (context, state) {
                                  if (state is UnitSuccess) {
                                    return Column(
                                      children: [
                                        DropdownButtonFormField(
                                          value: kodeUnit,
                                          items: state.units.map(
                                            (e) {
                                              return DropdownMenuItem(
                                                value: e.unitKode,
                                                child: Text(e.name),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (newValue) {
                                            unitKode.value =
                                                int.parse(newValue!.toString());
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                              const SizedBox(height: 24),
                              FormFieldWidget(
                                label: 'Ritase Material',
                                hint: 'Input Material Ritase',
                                controller: materialController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Value can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              FormFieldWidget(
                                label: 'Ritase Kategori',
                                hint: 'Input Kategori Ritase',
                                controller: kategoriController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Value can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              FormFieldWidget(
                                label: 'Ritase Keterangan',
                                hint: 'Input Keterangan Ritase',
                                controller: keteranganController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Value can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              CustomButtonWidget(
                                title: 'Submit',
                                eventFunc: () {
                                  if (formkey.value.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    context.read<RitaseCubit>().editRitase(
                                          ritaseId: ritaseId,
                                          ritaseMaterial:
                                              materialController.text,
                                          ritaseKategori:
                                              kategoriController.text,
                                          ritaseKeterangan:
                                              keteranganController.text,
                                          kodeUnit: unitKode.value,
                                        );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is RitaseLoading) {
              return Center(
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
