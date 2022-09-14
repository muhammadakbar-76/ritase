import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ritase/cubit/page_cubit.dart';
import 'package:ritase/shared/theme.dart';
import 'package:ritase/ui/pages/info_page.dart';
import 'package:ritase/ui/pages/ritase_create_page.dart';
import 'package:ritase/ui/pages/ritase_page.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  Widget pages(int index) {
    switch (index) {
      case 1:
        return const RitaseCreatePage();
      case 2:
        return const InfoPage();
      default:
        return const RitasePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<PageCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              pages(state),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: defaultBorder,
                      color: cSecondaryColor2,
                    ),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => context.read<PageCubit>().setPage(0),
                          child: Icon(
                            Icons.tram_rounded,
                            size: 40,
                            color: cSecondaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.read<PageCubit>().setPage(1),
                          child: Icon(
                            Icons.book,
                            size: 40,
                            color: cSecondaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.read<PageCubit>().setPage(2),
                          child: Icon(
                            Icons.info,
                            size: 40,
                            color: cSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
