import 'package:somun_flutter/interface/somun_interface.dart';

class SomunFriends extends SomunInterface {

  SomunFriends() : super("Friends");

  void requestFriends({Function? responseHandler}) {
    
    setResponseHandler("friendList", responseHandler);

    call("requestFriends", []);

  }

  void requestAddFrend(int playerId) {

    call("requestAddFrend", [playerId]);

  }

  void requestAcceptFriend(int playerId) {

    call("requestAcceptFriend", [playerId]);

  }

  void requestRejectFriend(int playerId) {

    call("requestRejectFriend", [playerId]);

  }

  void requestRemoveFriend(int playerId) {

    call("requestRemoveFriend", [playerId]);

  }

  void requestPrivateMessagesList({Function? responseHandler}) {

    setResponseHandler("messageList", responseHandler);

    call("requestPrivateMessagesList", []);

  }

  void requestSendPrivateMessage(int receiverId, String message) {

    call("requestSendPrivateMessage", [receiverId, message]);

  }

  void requestReadPrivateMessage(int messageId, {Function? responseHandler}) {

    setResponseHandler("privateMessageContent", responseHandler);

    call("requestReadPrivateMessage", [messageId]);

  }

  void requestDeletePrivateMessage(int messageId) {

    call("requestDeletePrivateMessage", [messageId]);

  }


}