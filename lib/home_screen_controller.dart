import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'core/feature_discovery_key.dart';

class EmailItem {
  String senderName;
  String subject;
  String title;
  String message;
  bool isUnRead;

  EmailItem({
    this.senderName = "initial sender name",
    this.subject = "initial subject",
    this.title = "initial title",
    this.message = "initial message",
    this.isUnRead = true,
  });
}

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<EmailItem> emailsList = <EmailItem>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading.value = true;

    Future.delayed(Duration(seconds: 4), () {
      _addTextEmail();
      isLoading.value = false;
    });
  }


  void showcaseFeatureDiscovery(BuildContext context){
    FeatureDiscovery.discoverFeatures(
      context,
      const <String>{
        FeatureDiscoveryKey.featureIdMenu,
        FeatureDiscoveryKey.featureIdSearch,
        FeatureDiscoveryKey.featureIdProfile,
        FeatureDiscoveryKey.featureIdCompose,
      },
    );
  }

  void _addTextEmail() {
    emailsList.addAll([
      EmailItem(
        senderName: "Alice",
        subject: "Welcome to Flutter",
        title: "Getting Started",
        message: "Learn how to build apps with Flutter and GetX.",
        isUnRead: true,
      ),
      EmailItem(
        senderName: "Bob",
        subject: "Weekly Update",
        title: "Team Progress",
        message: "Here’s the weekly update on our project status.",
        isUnRead: true,
      ),
      EmailItem(
        senderName: "Charlie",
        subject: "Invitation",
        title: "Join Our Event",
        message: "You are invited to attend our upcoming tech meetup.",
        isUnRead: false,
      ),
      EmailItem(
        senderName: "Diana",
        subject: "Special Offer",
        title: "Discount for You",
        message: "Get 30% off on your next Flutter course subscription.",
        isUnRead: false,
      ),
      EmailItem(
        senderName: "Ethan",
        subject: "Reminder",
        title: "Meeting Tomorrow",
        message: "Don’t forget we have a team sync tomorrow at 10 AM.",
        isUnRead: true,
      ),
      EmailItem(
        senderName: "Fiona",
        subject: "Release Notes",
        title: "Version 2.0 Launched",
        message: "Check out the new features in our latest update.",
        isUnRead: true,
      ),
      EmailItem(
        senderName: "George",
        subject: "Feedback Request",
        title: "Share Your Thoughts",
        message: "We’d love to hear your feedback on our new app design.",
        isUnRead: false,
      ),
      EmailItem(
        senderName: "Hannah",
        subject: "Happy Birthday!",
        title: "Best Wishes",
        message: "Wishing you a wonderful day filled with happiness.",
        isUnRead: false,
      ),
      EmailItem(
        senderName: "Ivy",
        subject: "Survey",
        title: "Quick Questions",
        message: "Please take a minute to complete this short survey.",
        isUnRead: false,
      ),
      EmailItem(
        senderName: "Jack",
        subject: "Security Alert",
        title: "Unusual Activity",
        message: "We detected a login attempt from a new device.",
        isUnRead: false,
      ),
    ]);
  }




}
