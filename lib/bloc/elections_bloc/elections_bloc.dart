import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umakvotingapp/backend/supabase/database/tables/elections.dart';

part 'elections_event.dart';
part 'elections_state.dart';

class ElectionsBloc extends Bloc<ElectionsEvent, ElectionsState> {
  ElectionsBloc() : super(ElectionsInitial()) {
    on<GetElections>((event, emit) async {
      emit(ElectionsLoading());
      try {
        final elections = await ElectionsTable().queryRows(queryFn: (query) {
          return query.order("created_at", ascending: false);
        });

        emit(ElectionsLoaded(elections: elections));
      } on Exception catch (e) {
        emit(ElectionsError(message: e.toString()));
      }
    });

    on<GetActiveElection>((event, emit) async {
      emit(ElectionsLoading());
      try {
        emit(ActiveElectionLoading());
        final today = DateTime.now();

        print("hi 1");
        final activeElection =
            await ElectionsTable().querySingleRow(queryFn: (query) {
          return query
              .filter("start_time", "lte", today.toIso8601String())
              .filter("end_time", "gte", today.toIso8601String())
              .limit(1);
        });
        print(activeElection);

        emit(ActiveElectionLoaded(activeElection[0]));
      } catch (e) {
        print(e.toString());
        emit(ElectionsError(message: e.toString()));
      }
    });
  }
}
