import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:umakvotingapp/backend/supabase/database/database.dart';

part 'candidate_experience_event.dart';
part 'candidate_experience_state.dart';

class CandidateExperienceBloc extends Bloc<CandidateExperienceEvent, CandidateExperienceState> {
  CandidateExperienceBloc() : super(CandidateExperienceInitial()) {
    on<CandidateExperienceEvent>((event, emit) async {
      if (event is GetCandidateExperience) {
        emit(CandidateExperienceLoading());
        try {
          final response = await CandidateExperienceTable().queryRows(queryFn: (query) {
            return query.eq("candidate_id", event.candidateId);
          });

          

          emit(CandidateExperienceLoaded(candidateExperience: response));
        } catch (e) {
          emit(CandidateExperienceError(e.toString()));
        }
      }
    });
  }
}
