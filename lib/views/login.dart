import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_repository/bloc.dart';
import '../routes/routes.dart';
import '../routes/navi_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../style/colors.dart';



GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId: '29092948700-eoos5oldkh61np1607m4cg3rrmv3str2.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


class SignInDemo extends StatefulWidget {
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  final loadingSub = BehaviorSubject<bool>.seeded(false);

  late final NavigatorState _rootNavi;
  late final UserRepositoryBloc _getUserBloc;

  @override
  void initState() {
    super.initState();
    init();
    _rootNavi = context.read<NaviRepository>().mainKey.currentState!;
    _getUserBloc = BlocProvider.of<UserRepositoryBloc>(context);

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {

      // setState(() {
      //   _currentUser = account;
      // });

      if (mounted) {
        setState(() {
          _currentUser = account;
        });

        if (_currentUser != null) {
          _handleGetContact(_currentUser!);
        }

        _getUserBloc.blocLoginUser = _currentUser!.email;
        _getUserBloc.add(Login(currentUser: _currentUser, googleSignIn: _googleSignIn));
        _rootNavi.pushNamed(Routes.main, arguments: '메인뷰');
      };

      // if (_currentUser != null) {
      //   _handleGetContact(_currentUser!);
      // }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> init() async {
    final result = await _googleSignIn.isSignedIn();

    if (result == true) {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      // _currentUser = null;
    }
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      debugPrint('user가 null이 아닐때 출력(GoogleSignInAccount)');

      // 원본 라우팅
      // _rootNavi.pushNamed(Routes.main, arguments: '메인뷰');

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          // ElevatedButton(
          //   onPressed: _handleSignOut,
          //   child: const Text('SIGN OUT'),
          // ),
          // ElevatedButton(
          //   child: const Text('REFRESH'),
          //   onPressed: () => _handleGetContact(user),
          // ),
        ],
      );
    }  else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          // const Text(
          //     '로그인이 필요합니다.'
          // '\n'
          // '\n'
          //         '< Google에서 확인하지 않은 앱 > 메세지 시에 하단의 고급 글자를 클릭하여'
          //     'eco rich process google sign(으)로 이동(안전하지 않음) 을 클릭하여 계속하여 진행하시면 됩니다.',
          // ),


          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                const Text(
                  '로그인이 필요합니다.'
                      '\n'
                      '\n'
                      '< Google에서 확인하지 않은 앱 > 메세지 시에 구글로긴창 하단의 <고급> 글자를 클릭하여'
                      '\n'
                      '\n'
                      'eco rich process google sign(으)로 이동(안전하지 않음) 을 클릭하여 계속하여 진행하시면 됩니다.',
                  style: TextStyle(fontSize: 20, color: AppColors.dark_grey),
                ),

                const SizedBox(height: 10),

              ],
            ),
          ),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('에코앤리치 과제 첫페이지'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}