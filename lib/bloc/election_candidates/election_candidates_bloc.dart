import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:umakvotingapp/backend/supabase/database/database.dart';
import 'package:umakvotingapp/supabase/database/database.dart';

part 'election_candidates_event.dart';
part 'election_candidates_state.dart';

class ElectionCandidatesBloc
    extends Bloc<ElectionCandidatesEvent, ElectionCandidatesState> {
  ElectionCandidatesBloc() : super(ElectionCandidatesInitial()) {
    on<ElectionCandidatesEvent>((event, emit) async {
      if (event is GetElectionCandidates) {
        emit(ElectionCandidatesLoading(event.electionId));
        try {
          final response = await SupaFlow.client
              .from("candidates")
              .select(
                  '*, partylists:partylists (id, name, abbreviation), college:colleges!college_id (id, full_name, acronym, logo_url)')
              .eq("election_id", event.electionId)
              .eq("position_id", event.candidatePositionId);

          final electionCandidates = response;

          print(electionCandidates);

          emit(ElectionCandidatesLoaded(
              electionCandidates: electionCandidates,
             ));
        } catch (e) {
          emit(ElectionCandidatesError(e.toString()));
        }
      }
    });

    on<GetElectionCandidateDetails>((event, emit) async {
      emit(ElectionCandidatesDetailsLoading(event.candidateId));
      try {
        final candidateDetails =
            await CandidatesTable().querySingleRow(queryFn: (query) {
          return query.eq("id", event.candidateId).limit(1);
        });

        emit(ElectionCandidatesDetailsLoaded(candidateDetails[0]));
      } catch (e) {
        emit(ElectionCandidatesError(e.toString()));
      }
    });
  }
}
