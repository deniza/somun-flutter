import 'package:somun_flutter/somun_interface.dart';

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

}