part of 'candidate_positions_bloc.dart';

@immutable
sealed class CandidatePositionsState {}

final class CandidatePositionsInitial extends CandidatePositionsState {}

final class CandidatePositionsLoading extends CandidatePositionsState {}

final class CandidatePositionsLoaded extends CandidatePositionsState {
  final List<PositionsRow> candidatePositions;

  CandidatePositionsLoaded({required this.candidatePositions});
}

final class CandidatePositionsError extends CandidatePositionsState {
  final String message;

  CandidatePositionsError({required this.message});
}
