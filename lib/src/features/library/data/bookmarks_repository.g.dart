// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookmarksRepository)
const bookmarksRepositoryProvider = BookmarksRepositoryProvider._();

final class BookmarksRepositoryProvider
    extends
        $FunctionalProvider<
          BookmarksRepository,
          BookmarksRepository,
          BookmarksRepository
        >
    with $Provider<BookmarksRepository> {
  const BookmarksRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarksRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarksRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookmarksRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookmarksRepository create(Ref ref) {
    return bookmarksRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookmarksRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookmarksRepository>(value),
    );
  }
}

String _$bookmarksRepositoryHash() =>
    r'088fff6d2172b37a83ddbc83e49abc72c1dab766';

@ProviderFor(bookmarks)
const bookmarksProvider = BookmarksProvider._();

final class BookmarksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Bookmark>>,
          List<Bookmark>,
          FutureOr<List<Bookmark>>
        >
    with $FutureModifier<List<Bookmark>>, $FutureProvider<List<Bookmark>> {
  const BookmarksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarksHash();

  @$internal
  @override
  $FutureProviderElement<List<Bookmark>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Bookmark>> create(Ref ref) {
    return bookmarks(ref);
  }
}

String _$bookmarksHash() => r'5f89e6a72e223d5adc62dd19eec8d875f9d56149';

@ProviderFor(BookmarkState)
const bookmarkStateProvider = BookmarkStateProvider._();

final class BookmarkStateProvider
    extends $AsyncNotifierProvider<BookmarkState, Set<String>> {
  const BookmarkStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkStateHash();

  @$internal
  @override
  BookmarkState create() => BookmarkState();
}

String _$bookmarkStateHash() => r'80a19ecf4fc6a89ca2eba660cf24ca7489cfa0bd';

abstract class _$BookmarkState extends $AsyncNotifier<Set<String>> {
  FutureOr<Set<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Set<String>>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Set<String>>, Set<String>>,
              AsyncValue<Set<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
