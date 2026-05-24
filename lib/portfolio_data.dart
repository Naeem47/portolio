import 'package:flutter/material.dart';
import 'package:portfolio/models.dart';

import 'theme.dart';

class PortfolioData {
  static const String name        = "Naeem Iqbal";
  static const String initials    = "NI";
  static const String role        = "Flutter Engineer";
  static const String linkedIn    = "https://linkedin.com/in/naeem-iqbal-965886221";
  static const String github      = "https://github.com/Naeem47";
  static const String email       = "mailto:tfanaeem@gmail.com";

  static const String bio =
      "Full-Stack Product Engineer with 2.5+ years shipping mobile ecosystems. "
      "Flutter on the front, Node.js & NestJS on the back — products with 500K+ downloads.";

  static const String aboutPara1 =
      "I approach frontend and backend as one system. My core strength is crafting "
      "pixel-perfect Flutter UIs with BLoC and Riverpod, while also owning the backend "
      "using Node.js, NestJS, PostgreSQL and TypeORM.";

  static const String aboutPara2 =
      "What sets me apart is hands-on experience with high-complexity mobile features: "
      "custom video processing with FFmpeg, live streaming and real-time communication "
      "with Agora, and AI integrations that improve UX and automate workflows.";

  static const List<String> aboutTags = [
    "Flutter", "FFmpeg", "Agora", "NestJS", "PostgreSQL", "AI Integration",
  ];

  static const List<String> animatedRoles = [
    "cross-platform experiences.",
    "scalable mobile architectures.",
    "real-time media systems.",
    "full-stack Flutter products.",
  ];

  static final List<SkillCategory> skills = [
    SkillCategory(
      title: "Mobile",
      color: AppColors.accent,
      bgColor: AppColors.accentBg,
      skills: ["Flutter", "Dart", "BLoC", "Riverpod", "Provider", "Animations", "CustomPaint", "Platform Channels"],
    ),
    SkillCategory(
      title: "Backend",
      color: AppColors.purple,
      bgColor: AppColors.purpleBg,
      skills: ["Node.js", "NestJS", "REST APIs", "PostgreSQL", "TypeORM", "JWT Auth", "WebSockets", "Redis"],
    ),
    SkillCategory(
      title: "Speciality",
      color: AppColors.orange,
      bgColor: AppColors.orangeBg,
      skills: ["FFmpeg", "Agora", "Video Processing", "Live Streaming", "AI Integration", "Real-time Apps"],
    ),
    SkillCategory(
      title: "Tools",
      color: AppColors.mutedLight,
      bgColor: AppColors.surface,
      skills: ["Git", "Postman", "Figma", "VS Code", "Firebase"],
    ),
  ];

  static final List<Project> projects = [
    Project(
      number: "01",
      title: "Video Editor App",
      description:
          "Full-featured mobile video editor with real-time FFmpeg processing, "
          "custom timeline UI, effects engine, and audio mixing.",
      tags: ["Flutter", "FFmpeg", "NestJS", "BLoC"],
      stat: "500K+ downloads",
      color: AppColors.accent,
      link: "https://github.com",
    ),
    Project(
      number: "02",
      title: "Live Streaming Platform",
      description:
          "Real-time broadcasting app using Agora for sub-100ms latency. "
          "Multi-host support, gift animations, live chat, and viewer analytics.",
      tags: ["Flutter", "Agora", "WebSockets", "Node.js"],
      stat: "Sub-100ms latency",
      color: AppColors.purple,
      link: "https://github.com",
    ),
    Project(
      number: "03",
      title: "AI-Powered Workflow App",
      description:
          "Productivity mobile app integrating multiple AI APIs to automate "
          "content generation and user workflows. Complete mobile + backend system.",
      tags: ["Flutter", "Riverpod", "NestJS", "PostgreSQL"],
      stat: "AI Integration",
      color: AppColors.orange,
      link: "https://github.com",
    ),
  ];

  static final List<SocialLink> socials = [
    SocialLink(label: "LinkedIn", icon: Icons.work_outline, url: linkedIn),
    SocialLink(label: "GitHub",   icon: Icons.code,         url: github),
    SocialLink(label: "Email",    icon: Icons.email_outlined, url: email),
  ];

  static final List<NavItem> navItems = [
    NavItem(label: "Home",     icon: Icons.home_outlined),
    NavItem(label: "About",    icon: Icons.person_outline),
    NavItem(label: "Skills",   icon: Icons.code_outlined),
    NavItem(label: "Projects", icon: Icons.folder_outlined),
    NavItem(label: "Contact",  icon: Icons.mail_outline),
  ];
}