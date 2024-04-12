import 'dart:math';

import 'package:crust_and_co/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:crust_and_co/components/widgets/search_input.dart';
import 'package:crust_and_co/components/widgets/text_input.dart';
import 'package:crust_and_co/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  double opacity = 0.1;
  late final TabController tabbarController;

  @override
  void initState() {
    super.initState();
    tabbarController = TabController(length: 3, vsync: this);
    tabbarController.animateTo(1);
    _scrollController.addListener(() {
      setState(() {
        opacity = min(1, _scrollController.offset / 200);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    tabbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.homeBgImage,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor:
                const Color(0xff15181D).withOpacity(max(opacity, 0.3)),
            body: SafeArea(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      surfaceTintColor: Colors.transparent,
                      // pinned: true,
                      title: const Row(
                        children: [Expanded(child: SearchInput())],
                      ),
                      expandedHeight: 350.0, // Adjust as needed
                      backgroundColor: Colors.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Opacity(
                            opacity: 1 - opacity,
                            child:
                                const YourHeaderWidget()), // Replace with your header widget
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(CustomTabBar(
                        tabController: tabbarController,
                        tabs: const [
                          Tab(text: 'Drinks'),
                          Tab(text: 'Pizzas'),
                          Tab(text: 'Extras'),
                        ],
                      )),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  controller: tabbarController,
                  children: const [
                    // Your tab views go here
                    Tab1Content(),
                    Tab2Content(),
                    Tab3Content(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent, // Adjust as needed
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// Define your tab contents as separate widgets
class Tab1Content extends StatelessWidget {
  const Tab1Content({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          title: Text(
        'Item $index',
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}

class Tab2Content extends StatelessWidget {
  const Tab2Content({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    );
  }
}

class Tab3Content extends StatelessWidget {
  const Tab3Content({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    );
  }
}

// Your header widget above the tabs
class YourHeaderWidget extends StatelessWidget {
  const YourHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MyUser user =
        BlocProvider.of<AuthenticationBloc>(context).userRepository.currentUser;
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Hi ${user.fullName}!',
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w200)),
                        Text('What do you wanna eat today...',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTabBar extends TabBar {
  @override
  final List<Tab> tabs;
  final TabController tabController;

  const CustomTabBar(
      {super.key, required this.tabs, required this.tabController})
      : super(tabs: tabs);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();

  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      splashFactory: NoSplash.splashFactory,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      dividerColor: Colors.transparent,
      // indicatorWeight: 1.0,
      tabs: widget.tabs
          .asMap()
          .map(
            (index, tab) => MapEntry(
              index,
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  if (index == widget.tabController.index) {
                    return const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.orange
                      ], // Change colors as needed
                    ).createShader(bounds);
                  } else {
                    return const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white
                      ], // Empty LinearGradient for unselected tabs
                    ).createShader(bounds);
                  }
                },
                child: tab,
              ),
            ),
          )
          .values
          .toList(),
      controller: widget.tabController,
    );
  }
}
