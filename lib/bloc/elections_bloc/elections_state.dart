part of 'elections_bloc.dart';

@immutable
sealed class ElectionsState {
  final List<ElectionsRow>? elections;
  final ElectionsRow? activeElection;

  const ElectionsState({this.elections, this.activeElection});
}

final class ElectionsInitial extends ElectionsState {}

final class ElectionsLoading extends ElectionsState {}

final class ElectionsLoaded extends ElectionsState {
  @override
  final List<ElectionsRow>? elections;

  const ElectionsLoaded({required this.elections})
      : super(elections: elections);
}

final class ActiveElectionLoading extends ElectionsState {}

final class ActiveElectionLoaded extends ElectionsState {
  final ElectionsRow activeElection;

  const ActiveElectionLoaded(this.activeElection)
      : super(activeElection: activeElection);
}

class ElectionsError extends ElectionsState {
  final String? message;

  const ElectionsError({this.message});
}
