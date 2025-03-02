part of 'candidate_experience_bloc.dart';

@immutable
sealed class CandidateExperienceEvent {}

final class GetCandidateExperience extends CandidateExperienceEvent {
  final String candidateId;

  GetCandidateExperience(this.candidateId);
}