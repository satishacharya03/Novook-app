class ApiConstants {
  static const String baseUrl = 'https://novook.vercel.app/api';
  
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  
  // Books
  static const String books = '/books';
  static const String categories = '/categories';
  static const String trending = '/books/trending';
  static const String recommended = '/recommendations';
  
  // Search
  static const String search = '/search';
  
  // Social
  static const String likes = '/social/likes';
  static const String follow = '/social/follow';
  static const String comments = '/social/comments';
  
  // User Data
  static const String bookmarks = '/bookmarks';
  static const String history = '/history';
  static const String playlists = '/playlists';
  
  // Users
  static const String users = '/users';
  static const String profile = '/users/profile';
}
