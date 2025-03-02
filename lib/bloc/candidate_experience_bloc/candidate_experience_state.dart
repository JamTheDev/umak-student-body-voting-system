part of 'candidate_experience_bloc.dart';

@immutable
sealed class CandidateExperienceState {}

final class CandidateExperienceInitial extends CandidateExperienceState {}

final class CandidateExperienceLoading extends CandidateExperienceState {}

final class CandidateExperienceLoaded extends CandidateExperienceState {
  final List<CandidateExperienceRow> candidateExperience;

  CandidateExperienceLoaded({required this.candidateExperience});
}

final class CandidateExperienceError extends CandidateExperienceState {
  final String error;

  CandidateExperienceError(this.error);
}
