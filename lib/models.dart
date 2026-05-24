import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final Color color;
  final Color bgColor;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.color,
    required this.bgColor,
    required this.skills,
  });
}

class Project {
  final String number;
  final String title;
  final String description;
  final List<String> tags;
  final String stat;
  final Color color;
  final String link;

  const Project({
    required this.number,
    required this.title,
    required this.description,
    required this.tags,
    required this.stat,
    required this.color,
    required this.link,
  });
}

class SocialLink {
  final String label;
  final IconData icon;
  final String url;

  const SocialLink({
    required this.label,
    required this.icon,
    required this.url,
  });
}

class NavItem {
  final String label;
  final IconData icon;

  const NavItem({required this.label, required this.icon});
}