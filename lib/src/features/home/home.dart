import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_valorant/src/features/home/detail_page.dart';
import 'package:flutter_valorant/src/utils/cached_network_image/network_image_helper.dart';
import 'package:flutter_valorant/src/utils/clipper/bg_clipper.dart';
import 'package:flutter_valorant/src/utils/navigate_transition/navigation_transition.dart';

import '../../bloc/common_bloc.dart';
import '../../bloc/common_state.dart';
import '../../style/text_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  PageController? _pageController;
  late AnimationController _animationController;

  final _bloc = CommonBloc();
  double offsetval = 0;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    _bloc.getAgents();
    _pageController = PageController()
      ..addListener(() {
        setState(() {
          offsetval = _pageController?.page ?? 0;
        });
      });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder<CommonBloc, CommonState>(
          builder: (context, state) {
            return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return PageView.builder(
                      controller: _pageController,
                      itemCount: state.valorantCharacterData.length,
                      itemBuilder: (context, index) {
                        var valorantData = state.valorantCharacterData[index];
                        double angleVal = (offsetval - index).abs();
                        if (angleVal > 0.5) {
                          angleVal = 1 - angleVal;
                        }
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.008)
                            ..rotateY(angleVal),
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                NavigationTransitionRoute(
                                  builder: (context) => DetailPage(
                                    audioUri: valorantData
                                        .voiceLine.mediaList[0].wave,
                                    imageUri: valorantData.fullPortraitV2,
                                    characterName: valorantData.displayName,
                                    description: valorantData.description,
                                    displayIcon: valorantData.displayIcon,
                                    bgImage: valorantData.background,
                                    backgroundGradientColors:
                                        valorantData.backgroundGradientColors,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: NetworkImageHelper(
                                    color: Colors.grey.withOpacity(0.8),
                                    imageUrl: valorantData.background,
                                  ),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 20,
                                  right: 20,
                                  child: SizedBox(
                                    width: size.width,
                                    child: AnimatedTextKit(
                                      totalRepeatCount: 100,
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                          valorantData.description,
                                          textStyle: TextThemeValorant
                                              .valorantStyle
                                              .copyWith(
                                            color: const Color.fromARGB(
                                                    255, 132, 15, 6)
                                                .withOpacity(0.8),
                                          ),
                                          speed:
                                              const Duration(milliseconds: 50),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ClipPath(
                                    clipper: BackgroundClipper(),
                                    child: Hero(
                                      tag: 'background',
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.8 *
                                                1.33,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ...List.generate(
                                                valorantData
                                                    .backgroundGradientColors
                                                    .length,
                                                (cIndex) => Color(
                                                  int.parse(
                                                    valorantData
                                                            .backgroundGradientColors[
                                                        cIndex],
                                                    radix: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        8.0 * _animationController.value),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8 *
                                              0.5),
                                      child: Hero(
                                        tag: valorantData.displayName,
                                        child: NetworkImageHelper(
                                          imageUrl: valorantData.fullPortraitV2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 60,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        valorantData.displayName,
                                        style: TextThemeValorant.valorantStyle
                                            .copyWith(
                                                fontSize: 32,
                                                letterSpacing: 1.5),
                                      ),
                                      Text(
                                        'Click for more details',
                                        style: TextThemeValorant.valorantStyle
                                            .copyWith(
                                                letterSpacing: 2.5,
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                });
          },
        ),
      ),
    );
  }
}
