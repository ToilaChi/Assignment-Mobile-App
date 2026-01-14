import 'package:flutter/material.dart';

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

final List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    title: 'Easy Time Management',
    description:
        'With management based on priority and daily tasks, it will give you convenience in managing tasks.',
    icon: Icons.schedule,
  ),
  OnboardingItem(
    title: 'Increase Work Effectiveness',
    description:
        'Time management and determination of important tasks will improve your work statistics.',
    icon: Icons.trending_up,
  ),
  OnboardingItem(
    title: 'Reminder Notification',
    description:
        'This application provides reminders so you do not forget your assignments.',
    icon: Icons.notifications,
  ),
];
