import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umakvotingapp/backend/supabase/database/database.dart';
import 'package:umakvotingapp/bloc/candidate_experience_bloc/candidate_experience_bloc.dart';
import 'package:umakvotingapp/bloc/candidate_positions_bloc/candidate_positions_bloc.dart';
import 'package:umakvotingapp/bloc/election_candidates/election_candidates_bloc.dart';
import 'package:umakvotingapp/bloc/elections_bloc/elections_bloc.dart';
import 'package:umakvotingapp/components/candidate_information.dart';
import 'package:umakvotingapp/components/voting_reminder_dialog.dart';
import 'package:umakvotingapp/constants/shared_pref_keys.dart';
import 'package:umakvotingapp/models/votation.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  ScrollController scr = ScrollController();
  String currentPosition = "POSITION_NAME";
  String electionId = "";

  double bottomSheetOffset = 8;
  int currentPriorityPosition = 0;

  List<Votation>? _currentVotation;
  PositionsRow? _currentCandidatePosition;

  bool _hasVotedCandidate(String positionId, String candidateId) {
    if (_currentVotation != null) {
      return _currentVotation!.any(
          (v) => v.positionId == positionId && v.candidateId == candidateId);
    }
    return false;
  }

  bool _hasVotedPosition(String positionId) {
    if (_currentVotation != null) {
      return _currentVotation!.any((v) => v.positionId == positionId);
    }
    return false;
  }

  void _loadVotationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonDecoder decoder = const JsonDecoder();
    String? votationData = prefs.getString(studentVotationData);
    if (votationData != null) {
      List<dynamic> decodedList = decoder.convert(votationData);
      _currentVotation =
          decodedList.map((item) => Votation.fromMap(item)).toList();
    } else {
      print("The user has not voted yet.");
    }

    setState(() {});
  }

  void advanceVotation(BuildContext context) {
    setState(() {
      CandidatePositionsState state =
          BlocProvider.of<CandidatePositionsBloc>(context).state;
      if (state is CandidatePositionsLoaded) {
        int nextPriorityPosition = currentPriorityPosition + 1;
        if (state.candidatePositions
            .any((position) => position.prio == nextPriorityPosition)) {
          currentPriorityPosition = nextPriorityPosition;

          _currentCandidatePosition = state.candidatePositions
              .firstWhere((element) => element.prio == currentPriorityPosition);
          currentPosition = _currentCandidatePosition!.name;

          BlocProvider.of<ElectionCandidatesBloc>(context).add(
              GetElectionCandidates(state.candidatePositions[0].electionId!,
                  _currentCandidatePosition!.id));

          return;
        } else {
          print("End of voting");
        }
      }
    });
  }

  void voteCandidate(String positionId, String candidateId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonDecoder decoder = const JsonDecoder();
    JsonEncoder encoder = const JsonEncoder();
    String? votationData = prefs.getString(studentVotationData);
    _currentVotation = [];

    if (votationData != null) {
      List<dynamic> decodedList = decoder.convert(votationData);
      _currentVotation =
          decodedList.map((item) => Votation.fromMap(item)).toList();
    }

    if (_currentVotation!.any((v) => v.positionId == positionId)) {
      _currentVotation!.removeWhere((v) => v.positionId == positionId);
    }

    _currentVotation!.add(Votation(
      positionId: positionId,
      electionId: electionId,
      candidateId: candidateId,
      castedOn: DateTime.now().toIso8601String(),
    ));

    String newVotationData =
        encoder.convert(_currentVotation!.map((v) => v.toMap()).toList());
    prefs.setString(studentVotationData, newVotationData);

    print("Voted for candidate $candidateId for position $positionId");
    print(newVotationData);

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ElectionsBloc>(context).add(GetActiveElection());
    _loadVotationData();
  }

  void showVotingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => VotingReminderDialog(),
    );
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      body: BlocConsumer<ElectionsBloc, ElectionsState>(
        listener: (context, state) {
          if (state is ActiveElectionLoaded) {
            BlocProvider.of<CandidatePositionsBloc>(context).add(
                GetCandidatePositions(electionId: state.activeElection.id));

            setState(() {
              electionId = state.activeElection.id;
            });
          }
        },
        builder: (context, state) {
          if (state is ElectionsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ElectionsError) {
            return Container(
              child: Text("Error: ${state.message}"),
            );
          }

          return state is ActiveElectionLoaded
              ? BlocConsumer<CandidatePositionsBloc, CandidatePositionsState>(
                  listener: (context, state) {
                    if (state is CandidatePositionsLoaded) {
                      // get the first priority position

                      setState(() {
                        _currentCandidatePosition = state.candidatePositions
                            .firstWhere((element) =>
                                element.prio == currentPriorityPosition);
                        currentPosition = _currentCandidatePosition!.name;
                      });

                      BlocProvider.of<ElectionCandidatesBloc>(context).add(
                          GetElectionCandidates(
                              state.candidatePositions[0].electionId!,
                              _currentCandidatePosition!.id));
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 41, vertical: 25),
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF132255)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        BlocProvider.of<
                                                                    ElectionsBloc>(
                                                                context)
                                                            .state
                                                            .activeElection!
                                                            .name,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Metropolis',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        'For ${currentPosition}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                          fontFamily:
                                                              'Metropolis',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 50),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 17),
                                BlocConsumer<ElectionCandidatesBloc,
                                    ElectionCandidatesState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state is ElectionCandidatesLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (state is ElectionCandidatesLoaded) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        width: double.infinity,
                                        child: ListBody(
                                          children: state.electionCandidates!
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            int index = entry.key;
                                            var candidate = entry.value;
                                            return CandidateListItem(
                                              candidate: candidate,
                                              isSelected: _hasVotedCandidate(
                                                  candidate["position_id"],
                                                  candidate["id"]),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            CandidateExperienceBloc>(
                                                        context)
                                                    .add(GetCandidateExperience(
                                                        candidate["id"]));
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return buildBottomSheet(
                                                        context,
                                                        scr,
                                                        bottomSheetOffset,
                                                        candidate,
                                                        voteCandidate);
                                                  },
                                                );
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }

                                    return Container();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 114),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 38, vertical: 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 145),
                                TextButton.icon(
                                  onPressed:
                                      _currentCandidatePosition != null &&
                                              _hasVotedPosition(
                                                  _currentCandidatePosition!.id)
                                          ? () => advanceVotation(context)
                                          : null,
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF132255),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                  icon: const Icon(Icons.chevron_right_sharp,
                                      color: Colors.white),
                                  iconAlignment: IconAlignment.end,
                                  label: const Text(
                                    'Next',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(
                  child: const Text("Loading..."),
                );
        },
      ),
    );
  }
}

class CandidateListItem extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isSelected;
  final Map<String, dynamic> candidate;

  const CandidateListItem({
    super.key,
    this.onPressed,
    this.isSelected = false,
    required this.candidate,
  });

  @override
  State<CandidateListItem> createState() => _CandidateListItemState();
}

class _CandidateListItemState extends State<CandidateListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: ShapeDecoration(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 223,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.candidate['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '${widget.candidate["partylists"]["abbreviation"]} Partylist',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Radio(
              value: true,
              groupValue: widget.isSelected,
              onChanged: (value) {
                widget.onPressed?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
