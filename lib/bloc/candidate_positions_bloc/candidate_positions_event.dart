part of 'candidate_positions_bloc.dart';

@immutable
sealed class CandidatePositionsEvent {}

final class GetCandidatePositions extends CandidatePositionsEvent {
  final String electionId;

  GetCandidatePositions({required this.electionId});
}