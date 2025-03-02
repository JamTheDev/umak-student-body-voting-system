part of 'election_candidates_bloc.dart';

@immutable
sealed class ElectionCandidatesEvent {}

final class GetElectionCandidates extends ElectionCandidatesEvent {
  final String electionId;
  final String candidatePositionId;

  GetElectionCandidates(this.electionId, this.candidatePositionId);
}

final class GetElectionCandidateDetails extends ElectionCandidatesEvent {
  final String candidateId;

  GetElectionCandidateDetails(this.candidateId);
}