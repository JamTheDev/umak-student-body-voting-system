part of 'election_candidates_bloc.dart';

@immutable
sealed class ElectionCandidatesEvent {}

final class GetElectionCandidates extends ElectionCandidatesEvent {
  final String electionId;
  final int prio;

  GetElectionCandidates(this.electionId, this.prio);
}

final class GetElectionCandidateDetails extends ElectionCandidatesEvent {
  final String candidateId;

  GetElectionCandidateDetails(this.candidateId);
}