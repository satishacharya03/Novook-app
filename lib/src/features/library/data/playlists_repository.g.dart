// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playlistsRepository)
const playlistsRepositoryProvider = PlaylistsRepositoryProvider._();

final class PlaylistsRepositoryProvider
    extends
        $FunctionalProvider<
          PlaylistsRepository,
          PlaylistsRepository,
          PlaylistsRepository
        >
    with $Provider<PlaylistsRepository> {
  const PlaylistsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playlistsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playlistsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlaylistsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlaylistsRepository create(Ref ref) {
    return playlistsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaylistsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaylistsRepository>(value),
    );
  }
}

String _$playlistsRepositoryHash() =>
    r'b91bce00db06dec72a001927dd18ffadd6b7fbd2';

@ProviderFor(playlists)
const playlistsProvider = PlaylistsProvider._();

final class PlaylistsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Playlist>>,
          List<Playlist>,
          FutureOr<List<Playlist>>
        >
    with $FutureModifier<List<Playlist>>, $FutureProvider<List<Playlist>> {
  const PlaylistsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playlistsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playlistsHash();

  @$internal
  @override
  $FutureProviderElement<List<Playlist>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Playlist>> create(Ref ref) {
    return playlists(ref);
  }
}

String _$playlistsHash() => r'30f2751365be5deb085ff84941c0ffc0552311ec';

@ProviderFor(playlistDetails)
const playlistDetailsProvider = PlaylistDetailsFamily._();

final class PlaylistDetailsProvider
    extends
        $FunctionalProvider<AsyncValue<Playlist>, Playlist, FutureOr<Playlist>>
    with $FutureModifier<Playlist>, $FutureProvider<Playlist> {
  const PlaylistDetailsProvider._({
    required PlaylistDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'playlistDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$playlistDetailsHash();

  @override
  String toString() {
    return r'playlistDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Playlist> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Playlist> create(Ref ref) {
    final argument = this.argument as String;
    return playlistDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaylistDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$playlistDetailsHash() => r'642b3e5e9b765eceeb0765a42f8a31edda7600d1';

final class PlaylistDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Playlist>, String> {
  const PlaylistDetailsFamily._()
    : super(
        retry: null,
        name: r'playlistDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaylistDetailsProvider call(String id) =>
      PlaylistDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'playlistDetailsProvider';
}
