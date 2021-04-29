import 'package:flutter/foundation.dart';
import 'package:graph_ql_flutter/blocs/base_bloc.dart';
import 'package:graph_ql_flutter/helper/constants/app_strings.dart';
import 'package:graph_ql_flutter/models/RepoData.dart';
import 'package:rxdart/rxdart.dart';

import '../models/profile_data.dart';
import '../repositories/github_repository.dart';


class ProfileBloc extends BaseBloc{
  final GithubRepository githubRepository;

  ProfileBloc({@required this.githubRepository});


  ///profile details subject to observe profile data
  final PublishSubject<ProfileData> _profileDataSubject = PublishSubject<ProfileData>();
  ///Stream profile data to Profile screen
  Stream<ProfileData> get getProfileData => _profileDataSubject.stream;

  ///Top Repo details subject to observe profile data
  final PublishSubject<List<RepoData>> _topRepoDataSubject = PublishSubject<List<RepoData>>();
  ///Stream top repo data to Profile screen
  Stream<List<RepoData>> get getTopRepoData => _topRepoDataSubject.stream;

  ///Starred repo details subject to observe profile data
  final PublishSubject<List<RepoData>> _starredRepoDataSubject = PublishSubject<List<RepoData>>();
  ///Stream starred repo data to Profile screen
  Stream<List<RepoData>> get getStarredRepoData => _starredRepoDataSubject.stream;

  ///Pinned repo details subject to observe profile data
  final PublishSubject<List<RepoData>> _pinnedRepoDataSubject = PublishSubject<List<RepoData>>();
  ///Stream pinned repo data to Profile screen
  Stream<List<RepoData>> get getPinnedRepoData => _pinnedRepoDataSubject.stream;

  Future<void> retrieveDataFromGitHub()async{
    await Future.wait<void>([
      _retrieveUserData(),
     _retrieveTopRepositories(),
      _retrieveStarredRepositories(),
      _retrievePinnedRepositories()
    ]);
  }


  ///retrieve profile data using repository class
  Future<void> _retrieveUserData()async{
    try{

      final _queryResults =
      await this.githubRepository.getUser();

      if (_queryResults.hasException) {
        _profileDataSubject.addError(_queryResults.exception.graphqlErrors.toString());
        return;
      }
      final Map<dynamic,dynamic> profile =
      _queryResults.data['viewer'] as Map<dynamic,dynamic>;

      _profileDataSubject.add(await setupUIProfileDataModel(profile));

    }
    catch(error){
      _profileDataSubject.addError(AppStrings.PROFILE_DATA_ERROR);
    }
  }

  ///retrieve top repositories using repository class
  Future<void> _retrieveTopRepositories()async{
    try{

      final _queryResults =
      await this.githubRepository.getTopRepositories(4);

      if (_queryResults.hasException) {
        _topRepoDataSubject.addError(_queryResults.exception.graphqlErrors.toString());
        return;
      }
      final List<dynamic> topRepo = _queryResults.data['viewer']['topRepositories']['nodes'] as  List<dynamic>;
      _topRepoDataSubject.add(await setupUIRepoDataModel(topRepo));
    }
    catch(error){
      _topRepoDataSubject.addError(AppStrings.TOP_REPO_ERROR);
    }
  }

  ///retrieve starred repositories using repository class
  Future<void> _retrieveStarredRepositories()async{
    try{

      final _queryResults =
      await this.githubRepository.getStarredRepositories(3);

      if (_queryResults.hasException) {
        _starredRepoDataSubject.addError(_queryResults.exception.graphqlErrors.toString());
        return;
      }
      final List<dynamic> starredRepo  =
      _queryResults.data['viewer']['starredRepositories']['nodes'] as List<dynamic>;
      _starredRepoDataSubject.add(await setupUIRepoDataModel(starredRepo));

    }
    catch(error){
      _starredRepoDataSubject.addError(AppStrings.STARRED_REPO_ERROR);
    }
  }

  ///retrieve pinned repositories using repository class
  Future<void> _retrievePinnedRepositories()async{
    try{

      final _queryResults =
      await this.githubRepository.getPinnedRepositories(3);

      if (_queryResults.hasException) {
        _pinnedRepoDataSubject.addError(_queryResults.exception.graphqlErrors.toString());
        return;
      }
      print(_queryResults.data.toString());
      final List<dynamic> pinnedRepo =
      _queryResults.data['viewer']['pinnedItems']['nodes'] as  List<dynamic>;
      _pinnedRepoDataSubject.add(await setupUIRepoDataModel(pinnedRepo));

    }
    catch(error){
      _pinnedRepoDataSubject.addError(AppStrings.PINNED_REPO_ERROR);
    }
  }

  ///set data for profile data model
  Future<ProfileData> setupUIProfileDataModel(Map<dynamic,dynamic> profileData) async{
    final ProfileData _profileData=ProfileData(
        email: profileData['email'],
        fullName: profileData['name'],
        imageURL: profileData['avatarUrl'],
        userName: profileData['login'],
        noOfFollowers: profileData['followers']['totalCount'],
        noOfFollowing: profileData['following']['totalCount']
    );

    return _profileData;

  }

  ///set data for repo data model
  Future<List<RepoData>> setupUIRepoDataModel(List<dynamic> repoData) async{

    final List<RepoData> _listOfRepos = repoData
        .map((dynamic e) {
    return RepoData(
      imageUrl: e['openGraphImageUrl']??'',
      name: e['name']??'',
      forkCount: e['forkCount']??'',
      language: e['primaryLanguage']!=null?e['primaryLanguage']['name']:'',
      repoDescription: e['description']??'',

    );}).toList();
    return _listOfRepos;

  }

  @override
  dispose() {
    _profileDataSubject.close();
    _topRepoDataSubject.close();
    _starredRepoDataSubject.close();
    _pinnedRepoDataSubject.close();
  }



}