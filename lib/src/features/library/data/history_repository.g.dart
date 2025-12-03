// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(historyRepository)
const historyRepositoryProvider = HistoryRepositoryProvider._();

final class HistoryRepositoryProvider
    extends
        $FunctionalProvider<
          HistoryRepository,
          HistoryRepository,
          HistoryRepository
        >
    with $Provider<HistoryRepository> {
  const HistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyRepositoryHash();

  @$internal
  @override
  $ProviderElement<HistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HistoryRepository create(Ref ref) {
    return historyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryRepository>(value),
    );
  }
}

String _$historyRepositoryHash() => r'2e7d3a268dbc2d83a06f391b9cf5b22fd7f60e88';

@ProviderFor(readingHistory)
const readingHistoryProvider = ReadingHistoryProvider._();

final class ReadingHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReadingHistory>>,
          List<ReadingHistory>,
          FutureOr<List<ReadingHistory>>
        >
    with
        $FutureModifier<List<ReadingHistory>>,
        $FutureProvider<List<ReadingHistory>> {
  const ReadingHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<ReadingHistory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReadingHistory>> create(Ref ref) {
    return readingHistory(ref);
  }
}

String _$readingHistoryHash() => r'94feaa01be916d6956b9885d9d4e49097f47e304';
