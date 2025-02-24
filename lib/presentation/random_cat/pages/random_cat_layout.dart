import 'package:catsapp/presentation/random_cat/pages/bloc/random_cat_bloc.dart';
import 'package:catsapp/presentation/random_cat/pages/bloc/random_cat_event.dart';
import 'package:catsapp/presentation/random_cat/pages/bloc/random_cat_state.dart';
import 'package:catsapp/presentation/random_cat/widgets/cat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatLayout extends StatelessWidget {
  const RandomCatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomCatBloc, RandomCatState>(
      builder: (context, state) {
        if (state is RandomCatStateError) {
          print('error: ----> ${state.message}');
          return Center(
            child: Text(state.message),
          );
        } else if (state is RandomCatState) {
          return Column(
            children: [
              CatCard(
                title: state.cat?.breeds.runtimeType == List
                    ? ''
                    : state.cat?.breeds!.first.name ?? '',
                origin: state.cat?.breeds?.first.origin ?? '',
                weight: state.cat?.breeds?.first.weight?.imperial ?? '',
                description: state.cat?.breeds?.first.description ?? '',
                catPhoto: state.cat?.url,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () async {
                      context.read<RandomCatBloc>().add(SearchRandomCat());
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
