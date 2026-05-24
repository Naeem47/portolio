import 'package:portfolio/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart';

class PortfolioData {
  static const String name = "Naeem Iqbal";
  static const String initials = "NI";
  static const String role = "Flutter Engineer";
  static const String linkedIn =
      "https://linkedin.com/in/naeem-iqbal-965886221";
  static const String github = "https://github.com/Naeem47";
  static const String email = "mailto:tfanaeem@gmail.com";

  static const String bio =
      "Mid-level Flutter Engineer with 3.5+ years building cross-platform products. "
      "From social platforms to AI-powered apps to desktop POS — full-stack, "
      "pixel-perfect, and production-ready.";

  static const String aboutPara1 =
      "I treat mobile and backend as one system. My core strength is crafting "
      "pixel-perfect Flutter UIs with BLoC and Riverpod, backed by Node.js, "
      "NestJS, and PostgreSQL — owning the whole stack from DB schema to "
      "widget tree.";

  static const String aboutPara2 =
      "I've shipped apps with real-time social feeds, AI-powered camera features, "
      "desktop POS systems, and custom video/story editors. If it lives on a screen "
      "and talks to a server, I've probably built it.";

  static const List<String> aboutTags = [
    "Flutter",
    "Dart",
    "Firebase",
    "Supabase",
    "REST APIs",
    "Socket.IO",
    "NestJS",
    "Node.js",
    "PostgreSQL",
    "MongoDB",
    "AI Integration",
    "Gemini AI",
    "OpenAI",
    "FFmpeg",
    "Agora SDK",
    "Stripe",
    "Real-time Apps",
    "Clean Architecture",
    "Responsive UI",
    "Desktop Apps",
    "POS Systems",
    "BLoC", // you list it in skills but not tags — recruiters search this
    "Riverpod", // same
    "WebSockets", // more searchable than "Socket.IO" alone
    "GetX", // if you've used it
  ];

  static const List<String> animatedRoles = [
    "beautiful cross-platform apps.",
    "production-ready Flutter solutions.",
    "desktop & POS management systems.",
    "real-time social platforms.",
    "scalable full-stack products.",
    "AI-integrated mobile experiences.",
    "pixel-perfect, clean-code architectures.",
  ];
  static final List<SkillCategory> skills = [
    SkillCategory(
      title: "Mobile Development",
      iconData: FontAwesomeIcons.mobile,
      color: AppColors.accent,
      bgColor: AppColors.accentBg,
      skills: [
        "Flutter",
        "Dart",
        "Responsive UI",
        "Cross-Platform Apps",
        "State Management",
        "BLoC",
        "Riverpod",
        "Provider",
        "Animations",
        "CustomPaint",
        "Platform Channels",
        "Clean Architecture",
        "Performance Optimization",
        "REST API Integration",
        "Socket.IO",
        "Real-time Features",
        "Push Notifications",
        "Stripe Integration",
        "In-App Purchases",
      ],
    ),

    SkillCategory(
      title: "Backend & APIs",
      iconData: FontAwesomeIcons.code,

      color: AppColors.purple,
      bgColor: AppColors.purpleBg,
      skills: [
        "Node.js",
        "NestJS",
        "Express.js",
        "REST APIs",
        "WebSockets",
        "JWT Authentication",
        "Role-Based Access",
        "Microservices",
        "PostgreSQL",
        "MongoDB",
        "Redis",
        "TypeORM",
        "Firebase",
        "Supabase",
        "Cloud Functions",
      ],
    ),

    SkillCategory(
      iconData: FontAwesomeIcons.database,

      title: "Databases & Storage",
      color: AppColors.orange,
      bgColor: AppColors.orangeBg,
      skills: [
        "PostgreSQL",
        "MongoDB",
        "Firebase Firestore",
        "Supabase",
        "SQLite",
        "Hive",
        "Offline-First Apps",
        "Local Storage",
        "Caching",
        "Secure Storage",
      ],
    ),

    SkillCategory(
      iconData: FontAwesomeIcons.connectdevelop,

      title: "Real-Time & Media",
      color: AppColors.green,
      bgColor: AppColors.greenBg,
      skills: [
        "Socket.IO",
        "Real-time Chat",
        "Live Updates",
        "Agora SDK",
        "Video Calling",
        "Media Streaming",
        "FFmpeg",
        "Video Processing",
        "Audio Processing",
        "Push Notifications",
      ],
    ),

    SkillCategory(
      iconData: FontAwesomeIcons.microchip,

      title: "AI & Integrations",
      color: AppColors.yellow,
      bgColor: AppColors.yellowBg,
      skills: [
        "Gemini AI",
        "OpenAI APIs",
        "AI Integration",
        "Payment Gateways",
        "Stripe",
        "Firebase Services",
        "Google APIs",
        "Third-Party SDKs",
      ],
    ),

    SkillCategory(
      iconData: FontAwesomeIcons.tools,

      title: "Tools & Workflow",
      color: AppColors.mutedLight,
      bgColor: AppColors.surface,
      skills: [
        "Git",
        "GitHub",
        "Postman",
        "Figma",
        "VS Code",
        "Android Studio",
        "CI/CD",
        "Debugging",
        "Agile Workflow",
      ],
    ),
    SkillCategory(
      title: "Desktop & Specialized",
      skills: [
        "Flutter Desktop",
        "Windows Apps",
        "POS Systems",
        "Offline-First",
        "Hardware Integration",
        "Barcode/QR Scanning",
        "Receipt Printing",
      ],
      color: AppColors.blue,
      bgColor: AppColors.blueBg,
      iconData: FontAwesomeIcons.desktop,
    ),
  ];

  static final List<Project> projects = [
    // ── Real projects ──────────────────────────────────────────────────────
    Project(
      number: "01",
      title: "Social Media App",
      description:
          "Instagram-style social platform with real-time chat via Socket.IO, "
          "FFmpeg-powered Reels playback, and a fully custom story editor — "
          "stickers, text overlays, drawing tools, and custom widgets. "
          "State managed with Provider.",
      tags: ["Flutter", "Provider", "Socket.IO", "FFmpeg"],
      stat: "Full social stack",
      color: AppColors.accent,
      link: "https://github.com/Naeem47",
    ),

    Project(
      number: "02",
      title: "AI Hair Stylist App",
      description:
          "AI-powered beauty app using Gemini to generate hair colour ideas, "
          "apply them live on the user's camera feed, and recommend products "
          "personalised to their hair type. Built with Riverpod and Dio.",
      tags: ["Flutter", "Riverpod", "Gemini AI", "Dio"],
      stat: "AI-powered camera",
      color: AppColors.purple,
      link: "https://github.com/Naeem47",
    ),

    Project(
      number: "03",
      title: "Desktop POS — Soda Shop",
      description:
          "Lightweight desktop point-of-sale for a soda shop. Product CRUD "
          "with variant support, receipt printing, a clean sales dashboard, "
          "and full light/dark theming — all offline-first with SQFlite.",
      tags: ["Flutter Desktop", "Riverpod", "SQFlite", "Printing"],
      stat: "Offline-first POS",
      color: AppColors.orange,
      link: "https://github.com/Naeem47",
    ),

    // ── Filler mid-level projects ──────────────────────────────────────────
    Project(
      number: "04",
      title: "Task & Team Manager",
      description:
          "Collaborative project-management app with real-time board updates, "
          "push notifications, role-based access, and a clean Kanban UI. "
          "Backend on NestJS + PostgreSQL with WebSocket sync.",
      tags: ["Flutter", "BLoC", "NestJS", "WebSockets"],
      stat: "Real-time sync",
      color: AppColors.accent,
      link: "https://github.com/Naeem47",
    ),

    Project(
      number: "05",
      title: "E-Commerce Mobile App",
      description:
          "Full e-commerce experience with product catalogue, cart, Stripe "
          "checkout, order tracking, and an admin dashboard. Riverpod for "
          "state, REST APIs for the catalogue, Firebase for notifications.",
      tags: ["Flutter", "Riverpod", "Stripe", "Firebase"],
      stat: "End-to-end checkout",
      color: AppColors.purple,
      link: "https://github.com/Naeem47",
    ),

    Project(
      number: "06",
      title: "Fitness Tracker App",
      description:
          "Workout logging app with custom animated progress rings, "
          "exercise library with video demos, streak tracking, "
          "and health stats charts. CustomPaint-heavy UI with BLoC.",
      tags: ["Flutter", "BLoC", "CustomPaint", "SQLite"],
      stat: "Custom animations",
      color: AppColors.orange,
      link: "https://github.com/Naeem47",
    ),
  ];

  static final List<SocialLink> socials = [
    SocialLink(
      label: "LinkedIn",
      icon: FontAwesomeIcons.linkedinIn,
      url: linkedIn,
    ),
    SocialLink(label: "GitHub", icon: FontAwesomeIcons.github, url: github),
    SocialLink(label: "Email", icon: FontAwesomeIcons.envelope, url: email),
  ];

  static final List<NavItem> navItems = [
    NavItem(label: "Home", icon: FontAwesomeIcons.house),
    NavItem(label: "About", icon: FontAwesomeIcons.user),
    NavItem(label: "Skills", icon: FontAwesomeIcons.code),
    NavItem(label: "Projects", icon: FontAwesomeIcons.diagramProject),
    NavItem(label: "Contact", icon: FontAwesomeIcons.envelope),
  ];
}
