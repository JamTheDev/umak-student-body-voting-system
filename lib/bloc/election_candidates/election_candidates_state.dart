part of 'election_candidates_bloc.dart';

@immutable
sealed class ElectionCandidatesState {
  final List<Map<String, dynamic>>? electionCandidates;
  final CandidatesRow? selectedCandidateDetails;

  const ElectionCandidatesState({
    this.electionCandidates,
    this.selectedCandidateDetails,
  });
}

final class ElectionCandidatesInitial extends ElectionCandidatesState {}

final class ElectionCandidatesDetailsLoading extends ElectionCandidatesState {
  final String candidateId;

  const ElectionCandidatesDetailsLoading(this.candidateId);
}

final class ElectionCandidatesDetailsLoaded extends ElectionCandidatesState {
  final CandidatesRow candidateDetails;

  const ElectionCandidatesDetailsLoaded(this.candidateDetails);
}

final class ElectionCandidatesLoading extends ElectionCandidatesState {
  final String electionId;

  const ElectionCandidatesLoading(this.electionId);
}

final class ElectionCandidatesLoaded extends ElectionCandidatesState {
  @override
  final List<Map<String, dynamic>>? electionCandidates;

  const ElectionCandidatesLoaded({required this.electionCandidates})
      : super(electionCandidates: electionCandidates);
}

final class ElectionCandidatesError extends ElectionCandidatesState {
  final String error;

  const ElectionCandidatesError(this.error);
}
