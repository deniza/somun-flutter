import 'package:somun_flutter/interface/somun_interface.dart';

class SomunPlay extends SomunInterface {

  SomunPlay() : super("Play");

  void enterGame(int gameId, {Function? responseHandler}) {
    
    setResponseHandler("enterGameResponse", responseHandler);

    call("enterGame", [gameId]);

  }

  void exitGame(int gameId, {Function? responseHandler}) {

    setResponseHandler("exitGameResponse", responseHandler);

    call("exitGame", [gameId]);

  }

  void resignGame(int gameId, {Function? responseHandler}) {

    setResponseHandler("resignGameResponse", responseHandler);

    call("resignGame", [gameId]);

  }

  void listGames({Function? responseHandler}) {

    setResponseHandler("listGamesResponse", responseHandler);

    call("listGames", []);

  }

  void makeMove(int gameId, String jsonData, {Function? responseHandler}) {

    setResponseHandler("makeMoveResponse", responseHandler);

    call("makeMove", [gameId, jsonData]);

  }

  void createRandomGame(int gameType, {Function? responseHandler}) {

    setResponseHandler("createRandomGameResponse", responseHandler);

    call("createRandomGame", [gameType]);

  }

  void createInvitation(int invitee, int gameType, bool shouldStartOnline) {

    call("createInvitation", [invitee, gameType, shouldStartOnline]);

  }

  void listInvitations({Function? responseHandler}) {

    setResponseHandler("invitationsList", responseHandler);

    call("listInvitations", []);

  }

  void acceptInvitation(int invitationId) {

    call("acceptInvitation", [invitationId]);

  }

  void rejectInvitation(int invitationId) {

    call("rejectInvitation", [invitationId]);

  }

}