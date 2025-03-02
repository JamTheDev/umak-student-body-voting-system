import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:umakvotingapp/backend/supabase/database/database.dart';

part 'candidate_positions_event.dart';
part 'candidate_positions_state.dart';

class CandidatePositionsBloc
    extends Bloc<CandidatePositionsEvent, CandidatePositionsState> {
  CandidatePositionsBloc() : super(CandidatePositionsInitial()) {
    on<GetCandidatePositions>((event, emit) async {
      emit(CandidatePositionsLoading());

      try {
        final candidatePositions =
            await PositionsTable().queryRows(queryFn: (query) {
          return query.order("prio", ascending: true);
        });

        emit(CandidatePositionsLoaded(candidatePositions: candidatePositions));
      } on Exception catch (e) {
        emit(CandidatePositionsError(message: e.toString()));
      }
    });
  }
}
