// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(socialRepository)
const socialRepositoryProvider = SocialRepositoryProvider._();

final class SocialRepositoryProvider
    extends
        $FunctionalProvider<
          SocialRepository,
          SocialRepository,
          SocialRepository
        >
    with $Provider<SocialRepository> {
  const SocialRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socialRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socialRepositoryHash();

  @$internal
  @override
  $ProviderElement<SocialRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SocialRepository create(Ref ref) {
    return socialRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SocialRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SocialRepository>(value),
    );
  }
}

String _$socialRepositoryHash() => r'14defe825f7fb641356df41707474f47fc242098';

@ProviderFor(LikeState)
const likeStateProvider = LikeStateProvider._();

final class LikeStateProvider
    extends $NotifierProvider<LikeState, Set<String>> {
  const LikeStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeStateHash();

  @$internal
  @override
  LikeState create() => LikeState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$likeStateHash() => r'7b0e06907f8c8774854cf8f02ce6eb7943b57511';

abstract class _$LikeState extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FollowState)
const followStateProvider = FollowStateProvider._();

final class FollowStateProvider
    extends $NotifierProvider<FollowState, Set<String>> {
  const FollowStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'followStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$followStateHash();

  @$internal
  @override
  FollowState create() => FollowState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$followStateHash() => r'0ebe2f5afd47a3a07a99f83fce611480e25d0982';

abstract class _$FollowState extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(bookComments)
const bookCommentsProvider = BookCommentsFamily._();

final class BookCommentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Comment>>,
          List<Comment>,
          FutureOr<List<Comment>>
        >
    with $FutureModifier<List<Comment>>, $FutureProvider<List<Comment>> {
  const BookCommentsProvider._({
    required BookCommentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookCommentsHash();

  @override
  String toString() {
    return r'bookCommentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Comment>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Comment>> create(Ref ref) {
    final argument = this.argument as String;
    return bookComments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookCommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookCommentsHash() => r'ed422b7f837f60f9d00156e493f1904d2ecc27e9';

final class BookCommentsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Comment>>, String> {
  const BookCommentsFamily._()
    : super(
        retry: null,
        name: r'bookCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookCommentsProvider call(String bookId) =>
      BookCommentsProvider._(argument: bookId, from: this);

  @override
  String toString() => r'bookCommentsProvider';
}
