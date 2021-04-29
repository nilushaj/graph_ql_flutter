import 'package:graph_ql_flutter/helper/graphql_client/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:gql/language.dart';

import '../queries/profile_query.dart' as query;


class GithubRepository {
  final GraphQLClient client;

  GithubRepository({@required this.client}) : assert(client != null);

  final grapqlClient=GraphQLClientService.shared;

  ///get github user detail using graphql client
  Future<QueryResult> getUser() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: parseString(query.fetchUser),
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  ///get github top repositories using graphql client
  Future<QueryResult> getTopRepositories(int numOfRepositories) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: parseString(query.fetchTopRepositories),
      variables: <String, dynamic>{
        'count': numOfRepositories,
      },
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }


  ///get github starred repositories using graphql client
  Future<QueryResult> getStarredRepositories(int numOfRepositories) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: parseString(query.fetchStarredRepositories),
      variables: <String, dynamic>{
        'count': numOfRepositories,
      },
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  ///get github pinned repositories using graphql client
  Future<QueryResult> getPinnedRepositories(int numOfRepositories) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: parseString(query.fetchPinnedRepositories),
      variables: <String, dynamic>{
        'count': numOfRepositories,
      },
    );
    print('await client.query(_options) ${await grapqlClient.getGraphQlClient().query(_options)}');
    return await grapqlClient.getGraphQlClient().query(_options);
  }

}
