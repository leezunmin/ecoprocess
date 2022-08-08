import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

const double _fabDimension = 56.0;

const String _profile = '안녕하세요 이번에 에코앤리치에 지원하게 된 이준민입니다.'
    '\n'
    '2019년경 다소 늦은 나이로 직업을 한번 전환하여 개발자를 하게된 케이스이며, 그이전에는 중고관련된 제품을 매입 및 인터넷 스토어에 판매 등의'
    '일을 2~3년정도간 하였습니다(의류 및 pc등). '
    '\n'
    '하지만 저의 성향과 다소 맞지 않는다는 느낌을 받게되었고, '
    '때마침 개발자 친구에게 조언을 구하여 개발자로 전향하게되었습니다.'
    '\n'
    '그래미엄이라는 판교의 작은 스타트업에서 플러터 개발자로 근무한 경험이 있습니다. 당시 7년차 10년차 시니어 풀스택 개발자들과 원격으로 협업하였습니다.'
    '꽤 규모가 큰 커뮤니티성 앱이었으며, 여러가지 앱개발에 관해 배울수있는 좋은 경험이었습니다.'
    '하지만 수익악화로 인해 해당 사업은 더이상 진행되지 않게 되었으며, 그로인하여 실업급여를 수급하며 새로운 구직을 준비하고 있습니다.';

const String _project =
'\n'
'\n'
'\n'
'\n'
    '프로젝트에는 플러터상의 총 세가지 상태관리 기술을 사용하였습니다.'
    '\n'
    'rxDart와 getX, 그리고 flutter_bloc 이렇게 총 3가지 기술을 사용하였습니다. 다소 급하게 만든 과제이기 때문에 코드상 불필요한 부분이 많을 수 있지만, '
    '기술 활용도를 보기위한 과제에 맞게, 세가지 기술을 조금씩이나마 사용하여 구현하였습니다.'
    '\n'
    '\n'
    '플러터로된 웹을 유지보수한 적이 있지만, 호스팅부터 빌드까지는 처음해보았고, 아직 플러터 웹이 최적화가 안된 부분도 많아 작업상 이슈들이 있었습니다.'
    '\n'
    '먼저 디버깅 상의 어려움이 있었는데, 로컬에서 디버깅시 포트를 고정시켜서 빌드해야 구글로그인이 적용되었습니다. '
    '구글 개발자센터에서 할당한 포트번호로만 빌드해야 디버깅이 되었기 때문에 해당 이슈를 포트고정 명령어로 빌드하면서 해결하였고,'
  '추후 google people api 사용설정 관련 이슈도 있어서 해결하였습니다.'
  '이미지 관련 이슈도 있었는데 web renderer로 빌드하도록 따로 설정하여 이미지 안보임 현상을 해결하였습니다.'
  '\n'
    '\n'
  '웹페이지 구현 + 게시판 기능을 과제의 메인으로 구현하였으며, 웹페이지는 플러터로 작성하여 게시판과 같이 파이어베이스로 호스팅하였습니다. 데이터베이스는 파이어스토어를 사용하였고, '
'페이지는 애니메이션 템플릿을 사용하여 적용해보았습니다. 그외 특별한 기능을 추가하라는 과제명시가 있었는데, 상단에 설명한 바와 같이 상태관리 기술을 3가지 적용해보도록 하였습니다. 감사합니다';



/// The demo page for [OpenContainerTransform].
class OpenContainerTransformDemo extends StatefulWidget {
  /// Creates the demo page for [OpenContainerTransform].
  const OpenContainerTransformDemo({Key? key}) : super(key: key);

  @override
  _OpenContainerTransformDemoState createState() {
    return _OpenContainerTransformDemoState();
  }
}

class _OpenContainerTransformDemoState
    extends State<OpenContainerTransformDemo> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container transform'),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   onPressed: () {
          //     _showSettingsBottomModalSheet(context);
          //   },
          // ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          _OpenContainerWrapper(
            transitionType: _transitionType,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return _ExampleCard(openContainer: openContainer);
            },
            onClosed: _showMarkedAsDoneSnackbar,
            widgetContent: _profile,
          ),
          const SizedBox(height: 16.0),
          _OpenContainerWrapper(
            transitionType: _transitionType,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return _ExampleSingleTile(openContainer: openContainer);
            },
            onClosed: _showMarkedAsDoneSnackbar,
            widgetContent: _project,
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: _OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return _SmallerCard(
                      openContainer: openContainer,
                      title: "샘플페이지",
                      subtitle: 'Secondary text',
                      imgFile: 'assets/firebase.png',
                    );
                  },
                  onClosed: _showMarkedAsDoneSnackbar,
                  widgetContent: "빈페이지",
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return _SmallerCard(
                      openContainer: openContainer,
                      title: "판교의 스타트업 근무",
                      subtitle: 'Secondary text',
                      imgFile: 'assets/desk.jpg',
                    );
                  },
                  onClosed: _showMarkedAsDoneSnackbar,
                  widgetContent: "빈페이지",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: _OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return _SmallerCard(
                      openContainer: openContainer,
                      subtitle: '수료한 부트캠프 사진',
                      title: 'KH정보교육원',
                      imgFile: 'assets/academy.jpg',
                    );
                  },
                  onClosed: _showMarkedAsDoneSnackbar,
                  widgetContent: "KH정보교육원에서 JAVA 웹개발 과정을 수료했으며, 조장 역할을 맡아 프로젝트를 원활히 완수한 내역이 있습니다.",
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return _SmallerCard(
                      openContainer: openContainer,
                      title: '판교',
                      subtitle: 'Secondary',
                      imgFile: 'assets/office.jpg',
                    );
                  },
                  onClosed: _showMarkedAsDoneSnackbar,
                  widgetContent: "빈페이지",
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return _SmallerCard(
                      openContainer: openContainer,
                      subtitle: 'Secondary',
                      title: '산업용 pda 작업',
                      imgFile: 'assets/rfx_pda_3.jpg',
                    );
                  },
                  onClosed: _showMarkedAsDoneSnackbar,
                  widgetContent: "빈페이지",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.widgetContent,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;
  final String widgetContent;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return _DetailsPage(content: widgetContent);
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
      final widgetWidth = boxConstraints.maxWidth;
      final widgetHeight = boxConstraints.maxHeight;
      return _InkWellOverlay(
        openContainer: openContainer,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            // Expanded(
            //   child: Container(
            //     // width: widgetWidth,
            //     color: Colors.black12,
            //     child: Center(
            //       child: Image.asset(
            //         // 'assets/placeholder_image.png',
            //         'assets/dart_flutter.png',
            //         width: widgetWidth * 0.2,
            //         height: widgetHeight * 0.3,
            //       ),
            //     ),
            //   ),
            // ),

            Container(
                color: Colors.white30,
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80.0,
                        child: ClipRRect(
                          child: Image.asset('assets/dart_flutter.png',),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    )
                  ],
                )),



            const ListTile(
              title: Text('개발자 이준민을 소개합니다'),
              subtitle: Text('Secondary text'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Text(
                '2019년 국비 교육 java과정을 시작으로 개발자에 입문하게 된 저를 소개합니다.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black54),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SmallerCard extends StatelessWidget {
  const _SmallerCard({
    required this.openContainer,
    required this.subtitle,
    required this.title,
    required this.imgFile,
  });

  final VoidCallback openContainer;
  final String subtitle;
  final String title;
  final String imgFile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
      final widgetWidth = boxConstraints.maxWidth;
      final widgetHeight = boxConstraints.maxHeight;
      print("가로 " + widgetWidth.toString());
      print("세로 " + widgetHeight.toString());
      return _InkWellOverlay(
        openContainer: openContainer,
        height: 225,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                color: Colors.black12,
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80.0,
                        child: ClipRRect(
                          child: Image.asset(imgFile),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _ExampleSingleTile extends StatelessWidget {
  _ExampleSingleTile({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    const double height = 100.0;

    return _InkWellOverlay(
      openContainer: openContainer,
      height: height,
      child: Row(
        children: <Widget>[

          Container(
            color: Colors.black12,
            height: height,
            width: height,
            child: Center(
              child: Image.asset(
                'assets/placeholder_image.png',
                width: 60,
              ),
            ),
          ),

          // Container(
          //     color: Colors.black12,
          //     height: height,
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: CircleAvatar(
          //             backgroundColor: Colors.white,
          //             radius: 30.0,
          //             child: ClipRRect(
          //               child: Image.asset('placeholder_image.png'),
          //               borderRadius: BorderRadius.circular(30.0),
          //             ),
          //           ),
          //         )
          //       ],
          //     )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '과제 작업 이력',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Text('과제를 수행한 내역과 이슈 내역 등의 요약입니다',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.height,
    this.child,
  });

  final VoidCallback? openContainer;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: null,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage(
      {this.includeMarkAsDoneButton = true, required this.content});

  final bool includeMarkAsDoneButton;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details page'),
          actions: <Widget>[
            // if (includeMarkAsDoneButton)
            //   IconButton(
            //     icon: const Icon(Icons.done),
            //     onPressed: () => Navigator.pop(context, true),
            //     tooltip: 'Mark as done',
            //   )
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          return ListView(
            children: <Widget>[
              Container(
                  color: Colors.black12,
                  // height: 250,
                  height: screenHeight * 0.5,
                  width: screenWidth,
                  child: Padding(
                      // padding: const EdgeInsets.all(70.0),
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.2,
                          right: screenWidth * 0.2,
                          top: 16,
                          bottom: 16),
                      child:

                      Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.4,
                        child: Image.asset(
                          // 'assets/placeholder_image.png',
                          // 'assets/Java_Logo.png',
                          'assets/desk2.jpg',
                          fit: BoxFit.fill,
                        ),
                      )
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'content',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.black54,
                            fontSize: 30.0,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      // _loremIpsumParagraph,
                      content,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black54,
                            height: 1.5,
                            fontSize: 16.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
