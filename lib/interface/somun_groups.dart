import 'package:somun_flutter/interface/somun_interface.dart';

class SomunGroups extends SomunInterface {

  SomunGroups() : super("Groups");

  void createGroup(String groupName, {Function? responseHandler}) {
    
    setResponseHandler("createGroupResponse", responseHandler);

    call("createGroup", [groupName]);

  }

  void joinGroup(int groupId, {Function? responseHandler}) {

    setResponseHandler("joinGroupResponse", responseHandler);

    call("joinGroup", [groupId]);

  }

  void leaveGroup(int groupId, {Function? responseHandler}) {

    setResponseHandler("leaveGroupResponse", responseHandler);

    call("leaveGroup", [groupId]);

  }

  void processJoinRequest(int groupId, int playerId, int accepted, {Function? responseHandler}) {

    setResponseHandler("processJoinRequestResponse", responseHandler);

    call("processJoinRequest", [groupId, playerId, accepted]);

  }

  void inviteToJoinGroup(int groupId, int playerId, {Function? responseHandler}) {

    setResponseHandler("inviteToJoinGroupResponse", responseHandler);

    call("inviteToJoinGroup", [groupId, playerId]);

  }

  void processGroupInvitation(int groupId, int accepted, {Function? responseHandler}) {

    setResponseHandler("processGroupInvitationResponse", responseHandler);

    call("processGroupInvitation", [groupId, accepted]);

  }

  void kickFromGroup(int groupId, int playerId, {Function? responseHandler}) {

    setResponseHandler("kickFromGroup", responseHandler);

    call("kickFromGroup", [groupId, playerId]);

  }

  void setGroupType(int groupId, int groupType, {Function? responseHandler}) {

    setResponseHandler("setGroupType", responseHandler);

    call("setGroupType", [groupId, groupType]);

  }

  void requestGroupList(int startId, int count, {Function? responseHandler}) {

    setResponseHandler("groupList", responseHandler);

    call("requestGroupList", [startId, count]);

  }

  void requestGroupInfo(int groupId, {Function? responseHandler}) {

    setResponseHandler("groupInfo", responseHandler);

    call("requestGroupInfo", [groupId]);

  }

  void requestGroupMembers(int groupId, {Function? responseHandler}) {

    setResponseHandler("groupMembers", responseHandler);

    call("requestGroupMembers", [groupId]);

  }

  void requestGroupJoinRequests(int groupId, {Function? responseHandler}) {

    setResponseHandler("groupJoinRequests", responseHandler);

    call("requestGroupJoinRequests", [groupId]);

  }

  void changeGroupMemberRole(int groupId, int playerId, int role, {Function? responseHandler}) {

    setResponseHandler("changeGroupMemberRole", responseHandler);

    call("changeGroupMemberRole", [groupId, playerId, role]);

  }

  void changeGroupDescription(int groupId, String description, {Function? responseHandler}) {

    setResponseHandler("changeGroupDescription", responseHandler);

    call("changeGroupDescription", [groupId, description]);

  }

  void sendGroupMessage(int groupId, String message, {Function? responseHandler}) {

    setResponseHandler("sendGroupMessage", responseHandler);

    call("sendGroupMessage", [groupId, message]);

  }

  void requestGroupMessages(int groupId, int startId, int count, {Function? responseHandler}) {

    setResponseHandler("groupMessages", responseHandler);

    call("requestGroupMessages", [groupId, startId, count]);

  }

  void requestGroupMessagesPaginated(int groupId, int page, int pageSize, {Function? responseHandler}) {

    setResponseHandler("groupMessagesPaginated", responseHandler);

    call("requestGroupMessagesPaginated", [groupId, page, pageSize]);

  }

}