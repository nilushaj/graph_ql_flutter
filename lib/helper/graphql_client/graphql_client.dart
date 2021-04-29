import 'package:graph_ql_flutter/helper/graphql_client/qraph_ql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

///GraphQL client service class
class GraphQLClientService {
  //Singleton
  GraphQLClientService._privateConstructor();

  static final GraphQLClientService _instance = GraphQLClientService._privateConstructor();

  ///get GraphQL service client class singleton instance
  static GraphQLClientService get shared => _instance;

  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
      GraphQLConfigData.graphqlUrl,
    );

    final AuthLink _authLink = AuthLink(
      getToken: () => 'Bearer ${GraphQLConfigData.token}',
    );

    final Link _link = _authLink.concat(_httpLink);

    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: _link,
    );
  }

  getGraphQlClient() => _client();
}