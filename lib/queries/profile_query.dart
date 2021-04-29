
///query for retrieve github user data
const String fetchUser = r'''
  query FindUserQuery {
  viewer {
    login
    avatarUrl
    name
    followers{
      totalCount
    }
    following{
      totalCount
    }
    email
  }  
}

''';

///query for retrieve github top repositories
const String fetchTopRepositories = r'''
  query FindTopRepositories($count: Int!) {
  viewer {
    
    topRepositories(first: $count,orderBy: {field: CREATED_AT, direction: ASC}){
      nodes {
          __typename
          id
          name
        	primaryLanguage{
            name
          }
          openGraphImageUrl
        	description
          forkCount
        }
    }       
  }  
}
''';

///query for retrieve github starred repositories
const String fetchStarredRepositories = r'''
  query FindStarredRepositories($count: Int!) {
  viewer {
      starredRepositories(first: $count,){
      nodes {
          __typename
          id
          name
        	description	
          openGraphImageUrl
          primaryLanguage{
            name
          }
          forkCount
        }
    }   
  }  
}
''';

///query for retrieve github pinned repositories
const String fetchPinnedRepositories = r'''
  query FindPinnedRepositories {
   viewer {
     pinnedItems(first: 3, types: REPOSITORY) {
      nodes {
        ... on Repository {
          name
          description
          primaryLanguage{
            name
            color
          }
          forkCount
          openGraphImageUrl
        }
      }
    }
 }
}
''';
