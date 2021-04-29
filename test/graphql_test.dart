import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graph_ql_flutter/blocs/profile_bloc.dart';
import 'package:graph_ql_flutter/models/profile_data.dart';
import 'package:graph_ql_flutter/repositories/github_repository.dart';
import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';

class MockGithubRepository extends Mock implements GithubRepository {}

const userData = """
{
  "data": {
    "viewer": {
      "login": "nilushaj",
      "avatarUrl": "https://avatars.githubusercontent.com/u/42198021?u=ef33ee02e577bf283ec1d8e67e84b7f737923847&v=4",
      "name": "Nilusha De Silva",
      "followers": {
        "totalCount": 1
      },
      "following": {
        "totalCount": 0
      },
      "email": "nilusha.7desilva@gmail.com"
    }
  }
}
""";

Map<String, dynamic> decodeGithubResponse = jsonDecode(userData);
final Map<dynamic, dynamic> mockedGithubRepos =
    decodeGithubResponse['data']['viewer'] as Map<dynamic, dynamic>;

ProfileData mockedProfileData = ProfileData(
    email: mockedGithubRepos['email'],
    fullName: mockedGithubRepos['name'],
    imageURL: mockedGithubRepos['avatarUrl'],
    userName: mockedGithubRepos['login'],
    noOfFollowers: mockedGithubRepos['followers']['totalCount'],
    noOfFollowing: mockedGithubRepos['following']['totalCount']);

void main() {
  group('ProfileBloc Test', () {
    ProfileBloc repoBloc;
    MockGithubRepository githubRepository;

    setUp(() {
      githubRepository = MockGithubRepository();
      repoBloc = ProfileBloc(
        githubRepository: githubRepository,
      );
    });

    tearDown(() {
      repoBloc.dispose();
    });

    test('check git hub user profile data', () async {
      final results = QueryResult(
        data: decodeGithubResponse['data'],
        exception: null,
        source: QueryResultSource.network,
      );

      when(
        githubRepository.getUser(),
      ).thenAnswer(
        (_) => Future.value(results),
      );

      repoBloc.getProfileData.listen(
        expectAsync1(
          (event) {
            expect(event.email, mockedProfileData.email);
          },
        ),
      );

      await repoBloc.retrieveDataFromGitHub();
    });
  });
}
