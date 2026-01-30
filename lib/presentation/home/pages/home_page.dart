import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_empty_widget.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../data/models/post.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/pages/login_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeBloc()..add(const HomeLoadRequested()), child: const _HomeView());
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boilerplate Demo'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider(create: (_) => LoginBloc(), child: const LoginPage()),
              ),
            ),
            child: const Text('Login'),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const AppEmptyWidget(title: 'Tap refresh to load', subtitle: 'Posts will appear here'),
            HomeLoading() => const AppLoader(message: "Loading..."),
            HomeLoaded(:final posts) => _PostList(posts: posts),
            HomeError(:final failure) => AppErrorWidget(message: failure.message, onRetry: () => context.read<HomeBloc>().add(const HomeLoadRequested())),
          };
        },
      ),
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (_, __) => true,
        builder: (context, state) {
          return FloatingActionButton(onPressed: state is HomeLoading ? null : () => context.read<HomeBloc>().add(const HomeLoadRequested()), child: const Icon(Icons.refresh));
        },
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
        );
      },
    );
  }
}
