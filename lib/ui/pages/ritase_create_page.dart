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

class RitaseCreatePage extends HookWidget {
  const RitaseCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = useState(GlobalKey<FormState>());
    final unitKode = useState(1);
    final materialController = useTextEditingController();
    final kategoriController = useTextEditingController();
    final keteranganController = useTextEditingController();

    final UnitDBOperation unitDbOperation = UnitDBOperation();

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
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HeaderWidget(
                        title: 'Create Ritase',
                        subTitle: 'Fill all input to create Ritase',
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
                                    return DropdownButtonFormField(
                                      value: unitKode.value,
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
                                    context.read<RitaseCubit>().createRitase(
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
                              const SizedBox(height: 100),
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
