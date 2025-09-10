import 'package:appfeaturediscovery/core/feature_discovery_key.dart';
import 'package:appfeaturediscovery/home_screen_controller.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FeatureDiscovery.discoverFeatures(context, const <String>{
        FeatureDiscoveryKey.featureIdMenu,
        FeatureDiscoveryKey.featureIdSearch,
        FeatureDiscoveryKey.featureIdProfile,
        FeatureDiscoveryKey.featureIdCompose,
      });
    });

    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: theme.colorScheme.tertiaryContainer,
        foregroundColor: theme.colorScheme.onTertiaryContainer,
        shadowColor: theme.colorScheme.primary,

        leading: DescribedFeatureOverlay(
          featureId: FeatureDiscoveryKey.featureIdMenu,
          tapTarget: Icon(Icons.menu),
          title: Text("Click here to open navigation drawer"),
          description: Text("description ..."),
          child: IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 32)),
        ),

        title: Text("Welcome"),

        actions: [
          DescribedFeatureOverlay(
            featureId: FeatureDiscoveryKey.featureIdSearch,
            tapTarget: Icon(Icons.search),
            title: Text("Search"),
            description: Text("Tap here to search emails"),
            backgroundColor: theme.colorScheme.secondary,
            targetColor: theme.colorScheme.onSecondary,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, size: 32),
            ),
          ),
          DescribedFeatureOverlay(
            featureId: FeatureDiscoveryKey.featureIdProfile,
            tapTarget: Icon(Icons.person),
            title: Text("Your Profile"),
            description: Text("Tap here to view your profile and settings"),
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.7),
              child: Text(
                "K",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: DescribedFeatureOverlay(
        featureId: FeatureDiscoveryKey.featureIdCompose,
        tapTarget: Icon(Icons.add),
        title: Text("Compose Email"),
        description: Text("Tap here to create and send a new email."),
        child: FloatingActionButton.extended(
          onPressed: () {
            controller.showcaseFeatureDiscovery(context);
          },
          label: Text("Compose"),
          icon: Icon(Icons.add),
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return loadingScreen(context);
          } else {
            return homeScreenUi(context);
          }
        }),
      ),
    );
  }

  Widget loadingScreen(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: CircularProgressIndicator(
        color: theme.colorScheme.primary.withValues(alpha: 0.5),
        constraints: BoxConstraints(
          minWidth: 100,
          minHeight: 100,
          maxHeight: 200,
          maxWidth: 200,
        ),

        strokeWidth: 4.0,
        strokeCap: StrokeCap.round,
      ),
    );
  }

  Widget homeScreenUi(BuildContext context) {
    final theme = context.theme;

    return ListView.builder(
      itemCount: controller.emailsList.length,
      itemBuilder: (context, index) {
        bool isLastIndex = controller.emailsList.length - 1 == index;
        return emailListItem(
          context,
          controller.emailsList[index],
          isLastIndex,
        );
      },
    );
  }

  Widget emailListItem(
    BuildContext context,
    EmailItem email,
    bool isLastIndex,
  ) {
    final theme = context.theme;
    final bottomMargin = isLastIndex ? 16.0 : 0.0;

    return Card(
      shadowColor: theme.colorScheme.secondary,
      elevation: 4,

      margin: EdgeInsets.only(
        top: 12.0,
        left: 8.0,
        right: 8.0,
        bottom: bottomMargin,
      ),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.onTertiaryContainer,
          width: 1.5,
          style: BorderStyle.solid,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.7),
            child: Text(
              email.senderName.isNotEmpty ? email.senderName[0] : "NA",
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
          ),

          title: Text(
            email.subject,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              email.message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: email.isUnRead ? FontWeight.bold : FontWeight.normal,
            color: theme.colorScheme.primary,
          ),

          subtitleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: email.isUnRead ? FontWeight.bold : FontWeight.normal,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
