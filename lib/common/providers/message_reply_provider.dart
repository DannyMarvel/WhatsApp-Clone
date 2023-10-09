import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/message_enum.dart';


//This helps us to reply to any message we want
class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(this.message, this.isMe, this.messageEnum);
}

//StateProvider changes the state of the Provider and update the state
final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);