import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:umakvotingapp/backend/supabase/database/database.dart';

part 'election_candidates_event.dart';
part 'election_candidates_state.dart';

class ElectionCandidatesBloc
    extends Bloc<ElectionCandidatesEvent, ElectionCandidatesState> {
  ElectionCandidatesBloc() : super(ElectionCandidatesInitial()) {
    on<ElectionCandidatesEvent>((event, emit) async {
      if (event is GetElectionCandidates) {
        emit(ElectionCandidatesLoading(event.electionId));
        try {
          final electionCandidates =
              await CandidatesTable().queryRows(queryFn: (query) {
            return query
                .eq("id", event.electionId)
                .eq("position", event.position);
          });

          emit(
              ElectionCandidatesLoaded(electionCandidates: electionCandidates));
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
