import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get title;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @currentlyDeveloping.
  ///
  /// In en, this message translates to:
  /// **'Currently developing an AI application with Flutter'**
  String get currentlyDeveloping;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, I\'m Can 👋'**
  String get hello;

  /// No description provided for @problemSolver.
  ///
  /// In en, this message translates to:
  /// **'Problem Solver'**
  String get problemSolver;

  /// No description provided for @techEnthusiast.
  ///
  /// In en, this message translates to:
  /// **'Tech Enthusiast'**
  String get techEnthusiast;

  /// No description provided for @flutterDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get flutterDeveloper;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'I\'m passionate about creating clean and user-focused applications using \nFlutter, Kotlin, and Firebase.'**
  String get aboutMe;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name Surname'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Your Message'**
  String get message;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @messageSent.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully ✅'**
  String get messageSent;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred ❌'**
  String get errorOccurred;

  /// No description provided for @getInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get getInTouch;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If you have a question, just want to say hi, or want to talk about a project, don\'t hesitate to reach out. I\'d love to hear from you!'**
  String get contactSubtitle;

  /// No description provided for @sendMeMessage.
  ///
  /// In en, this message translates to:
  /// **'Send me a message'**
  String get sendMeMessage;

  /// No description provided for @responseTime.
  ///
  /// In en, this message translates to:
  /// **'I usually respond within 24-48 hours.'**
  String get responseTime;

  /// No description provided for @technologies.
  ///
  /// In en, this message translates to:
  /// **'Technologies I Use'**
  String get technologies;

  /// No description provided for @technologiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Technologies, tools, and frameworks I use to develop mobile applications.'**
  String get technologiesSubtitle;

  /// No description provided for @allSkills.
  ///
  /// In en, this message translates to:
  /// **'All Skills'**
  String get allSkills;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get expert;

  /// No description provided for @featuredSkills.
  ///
  /// In en, this message translates to:
  /// **'Featured Skills'**
  String get featuredSkills;

  /// No description provided for @frameworksAndLibraries.
  ///
  /// In en, this message translates to:
  /// **'Frameworks & Libraries'**
  String get frameworksAndLibraries;

  /// No description provided for @toolsAndPlatforms.
  ///
  /// In en, this message translates to:
  /// **'Tools & Platforms'**
  String get toolsAndPlatforms;

  /// No description provided for @currentlyLearning.
  ///
  /// In en, this message translates to:
  /// **'Currently Learning'**
  String get currentlyLearning;

  /// No description provided for @journey.
  ///
  /// In en, this message translates to:
  /// **'My Journey'**
  String get journey;

  /// No description provided for @journeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Where I\'ve worked and what I\'ve learned along the way'**
  String get journeySubtitle;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @projectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Some of my recent projects developed with Flutter, Firebase, and advanced mobile technologies.'**
  String get projectsSubtitle;

  /// No description provided for @allProjects.
  ///
  /// In en, this message translates to:
  /// **'All Projects'**
  String get allProjects;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon...'**
  String get comingSoon;

  /// No description provided for @viewAllProjects.
  ///
  /// In en, this message translates to:
  /// **'View All Projects'**
  String get viewAllProjects;

  /// No description provided for @downloadCV.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadCV;

  /// No description provided for @codingPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Coding Playlist'**
  String get codingPlaylist;

  /// No description provided for @yearsExperience.
  ///
  /// In en, this message translates to:
  /// **'Years Experience'**
  String get yearsExperience;

  /// No description provided for @developedProjects.
  ///
  /// In en, this message translates to:
  /// **'Developed Projects'**
  String get developedProjects;

  /// No description provided for @commits.
  ///
  /// In en, this message translates to:
  /// **'Commits'**
  String get commits;

  /// No description provided for @skillLevelIntermediatePlus.
  ///
  /// In en, this message translates to:
  /// **'Intermediate+'**
  String get skillLevelIntermediatePlus;

  /// No description provided for @skillLevelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get skillLevelIntermediate;

  /// No description provided for @skillLevelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get skillLevelBeginner;

  /// No description provided for @expertSkillsNotAdded.
  ///
  /// In en, this message translates to:
  /// **'Expert level skills not added yet'**
  String get expertSkillsNotAdded;

  /// No description provided for @flutter.
  ///
  /// In en, this message translates to:
  /// **'Flutter'**
  String get flutter;

  /// No description provided for @dart.
  ///
  /// In en, this message translates to:
  /// **'Dart'**
  String get dart;

  /// No description provided for @firebase.
  ///
  /// In en, this message translates to:
  /// **'Firebase'**
  String get firebase;

  /// No description provided for @kotlin.
  ///
  /// In en, this message translates to:
  /// **'Kotlin'**
  String get kotlin;

  /// No description provided for @coreTechnology.
  ///
  /// In en, this message translates to:
  /// **'Core Technology'**
  String get coreTechnology;

  /// No description provided for @intermediateLevel.
  ///
  /// In en, this message translates to:
  /// **'Intermediate Level'**
  String get intermediateLevel;

  /// No description provided for @reactNative.
  ///
  /// In en, this message translates to:
  /// **'React Native'**
  String get reactNative;

  /// No description provided for @riverpod.
  ///
  /// In en, this message translates to:
  /// **'Riverpod'**
  String get riverpod;

  /// No description provided for @git.
  ///
  /// In en, this message translates to:
  /// **'Git'**
  String get git;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @figma.
  ///
  /// In en, this message translates to:
  /// **'Figma'**
  String get figma;

  /// No description provided for @vsCode.
  ///
  /// In en, this message translates to:
  /// **'VS Code'**
  String get vsCode;

  /// No description provided for @androidStudio.
  ///
  /// In en, this message translates to:
  /// **'Android Studio'**
  String get androidStudio;

  /// No description provided for @aboutMeText.
  ///
  /// In en, this message translates to:
  /// **'I\'m Can, a mobile app developer based in Ankara, Turkey. I specialize in developing high-quality mobile applications using Flutter, Kotlin, and Firebase. I love turning ideas into working products and enjoy every part of the software development process, from design to coding and problem-solving.\n\nOutside of coding, I enjoy playing guitar, writing, and spending time with my cat Misha. I believe in continuous learning and collaborative work.'**
  String get aboutMeText;

  /// No description provided for @technologiesIUse.
  ///
  /// In en, this message translates to:
  /// **'Technologies I Use'**
  String get technologiesIUse;

  /// No description provided for @myJourney.
  ///
  /// In en, this message translates to:
  /// **'My Journey So Far'**
  String get myJourney;

  /// No description provided for @certificatesAndAchievements.
  ///
  /// In en, this message translates to:
  /// **'Certificates & Achievements'**
  String get certificatesAndAchievements;

  /// No description provided for @mobileDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Mobile Developer'**
  String get mobileDeveloper;

  /// No description provided for @hive.
  ///
  /// In en, this message translates to:
  /// **'Hive'**
  String get hive;

  /// No description provided for @ideathon.
  ///
  /// In en, this message translates to:
  /// **'Ideathon'**
  String get ideathon;

  /// No description provided for @googleGameAndAppAcademy.
  ///
  /// In en, this message translates to:
  /// **'Google Game and App Academy'**
  String get googleGameAndAppAcademy;

  /// No description provided for @ideathonDescription.
  ///
  /// In en, this message translates to:
  /// **'Participated in an intensive ideation marathon focusing on idea generation, teamwork, and presentation techniques.'**
  String get ideathonDescription;

  /// No description provided for @appJam.
  ///
  /// In en, this message translates to:
  /// **'App-Jam'**
  String get appJam;

  /// No description provided for @appJamDescription.
  ///
  /// In en, this message translates to:
  /// **'A rapid development marathon where we developed and presented a prototype mobile app through teamwork in 3 days.'**
  String get appJamDescription;

  /// No description provided for @aiAppJam.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered App-Jam'**
  String get aiAppJam;

  /// No description provided for @aiAppJamDescription.
  ///
  /// In en, this message translates to:
  /// **'Created an innovative prototype as a team in a 4-day app development process integrating artificial intelligence.'**
  String get aiAppJamDescription;

  /// No description provided for @projectManager.
  ///
  /// In en, this message translates to:
  /// **'Project Manager'**
  String get projectManager;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @projectManagerDescription.
  ///
  /// In en, this message translates to:
  /// **'Gained comprehensive knowledge in planning, time management, team coordination, and Agile methodologies through Google Project Management training.'**
  String get projectManagerDescription;

  /// No description provided for @dartProgramming.
  ///
  /// In en, this message translates to:
  /// **'Dart Programming Language'**
  String get dartProgramming;

  /// No description provided for @btkAcademy.
  ///
  /// In en, this message translates to:
  /// **'BTK Academy'**
  String get btkAcademy;

  /// No description provided for @dartDescription.
  ///
  /// In en, this message translates to:
  /// **'Learned the fundamentals of the Dart programming language. Gained mastery of all essential topics needed in the Flutter development process.'**
  String get dartDescription;

  /// No description provided for @bootcamp.
  ///
  /// In en, this message translates to:
  /// **'Bootcamp'**
  String get bootcamp;

  /// No description provided for @bootcampDescription.
  ///
  /// In en, this message translates to:
  /// **'An intensive training program focused on practical project development, providing comprehensive education in Flutter, entrepreneurship, and project management.'**
  String get bootcampDescription;

  /// No description provided for @codeQuote.
  ///
  /// In en, this message translates to:
  /// **'Code is like poetry - when written with care, it flows beautifully.'**
  String get codeQuote;

  /// No description provided for @inDevelopment.
  ///
  /// In en, this message translates to:
  /// **'In Development'**
  String get inDevelopment;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @visit.
  ///
  /// In en, this message translates to:
  /// **'Visit'**
  String get visit;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @ternai.
  ///
  /// In en, this message translates to:
  /// **'Ternai'**
  String get ternai;

  /// No description provided for @ternaiProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'Ternai is a mobile application developed for users planning international travel, helping them create a vacation budget by comparing costs.'**
  String get ternaiProjectDescription;

  /// No description provided for @wedly.
  ///
  /// In en, this message translates to:
  /// **'Wedly'**
  String get wedly;

  /// No description provided for @wedlyProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'A room-based item planning and listing application for couples preparing to get married. Supports offline usage.'**
  String get wedlyProjectDescription;

  /// No description provided for @bootcampFinalist.
  ///
  /// In en, this message translates to:
  /// **'Bootcamp Finalist'**
  String get bootcampFinalist;

  /// No description provided for @empowerMeFinalist.
  ///
  /// In en, this message translates to:
  /// **'EmpowerMe Finalist'**
  String get empowerMeFinalist;

  /// No description provided for @mvvm.
  ///
  /// In en, this message translates to:
  /// **'MVVM'**
  String get mvvm;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @one.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get one;

  /// No description provided for @scrollDown.
  ///
  /// In en, this message translates to:
  /// **'Scroll Down'**
  String get scrollDown;

  /// No description provided for @wedlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Wedly (Published)'**
  String get wedlyTitle;

  /// No description provided for @wedlyJourneyDescription.
  ///
  /// In en, this message translates to:
  /// **'My wedding planner mobile app developed with Flutter was published on Google Play.'**
  String get wedlyJourneyDescription;

  /// No description provided for @ternaiTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Bootcamp (Ternai)'**
  String get ternaiTitle;

  /// No description provided for @ternaiJourneyDescription.
  ///
  /// In en, this message translates to:
  /// **'We developed the Ternai travel budgeting app with a team of 5 people and ranked in the top 7 among 100 teams. We worked with structures like MVVM, Riverpod, and AutoRoute.'**
  String get ternaiJourneyDescription;

  /// No description provided for @googleAcademyTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Game and App Academy'**
  String get googleAcademyTitle;

  /// No description provided for @googleAcademyDescription.
  ///
  /// In en, this message translates to:
  /// **'A program focused on practical project development where I received training in Flutter, entrepreneurship, and project management.'**
  String get googleAcademyDescription;

  /// No description provided for @school42Title.
  ///
  /// In en, this message translates to:
  /// **'School 42'**
  String get school42Title;

  /// No description provided for @school42Description.
  ///
  /// In en, this message translates to:
  /// **'A unique experience where I gained software development skills through 100% practice, without exams or teachers.'**
  String get school42Description;

  /// No description provided for @mathDegreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Mathematics Bachelor\'s Degree (30% English)'**
  String get mathDegreeTitle;

  /// No description provided for @mathDegreeDescription.
  ///
  /// In en, this message translates to:
  /// **'A four-year educational process where I developed my analytical thinking, problem-solving, and abstraction abilities.'**
  String get mathDegreeDescription;

  /// No description provided for @ternaiLeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Leader - Flutter Developer'**
  String get ternaiLeaderTitle;

  /// No description provided for @ternaiLeaderDate.
  ///
  /// In en, this message translates to:
  /// **'July 2024 – Present'**
  String get ternaiLeaderDate;

  /// No description provided for @ankaraTurkeyLocation.
  ///
  /// In en, this message translates to:
  /// **'Ankara, Turkey'**
  String get ankaraTurkeyLocation;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeStatus;

  /// No description provided for @ternaiPoint1.
  ///
  /// In en, this message translates to:
  /// **'Led a team of 5 to develop an AI-powered travel budgeting application.'**
  String get ternaiPoint1;

  /// No description provided for @ternaiPoint2.
  ///
  /// In en, this message translates to:
  /// **'Built an advanced mobile structure using Flutter with MVVM architecture, AutoRoute, Firebase, Hive, and Provider.'**
  String get ternaiPoint2;

  /// No description provided for @ternaiPoint3.
  ///
  /// In en, this message translates to:
  /// **'Developed modules such as API consumption, offline support, favorite system, and multi-filtering mechanisms.'**
  String get ternaiPoint3;

  /// No description provided for @ternaiPoint4.
  ///
  /// In en, this message translates to:
  /// **'Selected as a finalist among 50+ teams at EmpowerMe Bootcamp and accepted into the acceleration program.'**
  String get ternaiPoint4;

  /// No description provided for @ternaiPoint5.
  ///
  /// In en, this message translates to:
  /// **'Contributed to investor meetings with user research, presentations, and demo videos.'**
  String get ternaiPoint5;

  /// No description provided for @teamLeadershipTag.
  ///
  /// In en, this message translates to:
  /// **'Team Leadership'**
  String get teamLeadershipTag;

  /// No description provided for @uxUiTag.
  ///
  /// In en, this message translates to:
  /// **'UX/UI'**
  String get uxUiTag;

  /// No description provided for @autoRouteTag.
  ///
  /// In en, this message translates to:
  /// **'AutoRoute'**
  String get autoRouteTag;

  /// No description provided for @moneypayTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get moneypayTitle;

  /// No description provided for @moneypayDate.
  ///
  /// In en, this message translates to:
  /// **'August 2024 – December 2024'**
  String get moneypayDate;

  /// No description provided for @remoteAnkaraLocation.
  ///
  /// In en, this message translates to:
  /// **'Remote / Ankara, Turkey'**
  String get remoteAnkaraLocation;

  /// No description provided for @remoteStatus.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get remoteStatus;

  /// No description provided for @moneypayPoint1.
  ///
  /// In en, this message translates to:
  /// **'Actively participated in developing sustainable and scalable mobile applications with Flutter.'**
  String get moneypayPoint1;

  /// No description provided for @moneypayPoint2.
  ///
  /// In en, this message translates to:
  /// **'Managed user management and data processing operations using technologies like Firebase Authentication, Firestore, Hive, and Provider.'**
  String get moneypayPoint2;

  /// No description provided for @moneypayPoint3.
  ///
  /// In en, this message translates to:
  /// **'Provided a professional application experience with MVVM architecture, AutoRoute, and Lottie animations.'**
  String get moneypayPoint3;

  /// No description provided for @moneypayPoint4.
  ///
  /// In en, this message translates to:
  /// **'Contributed to code review, testing, and debugging processes.'**
  String get moneypayPoint4;

  /// No description provided for @mvcTag.
  ///
  /// In en, this message translates to:
  /// **'MVC'**
  String get mvcTag;

  /// No description provided for @agileTag.
  ///
  /// In en, this message translates to:
  /// **'Agile'**
  String get agileTag;

  /// No description provided for @scrumTag.
  ///
  /// In en, this message translates to:
  /// **'Scrum'**
  String get scrumTag;

  /// No description provided for @teamworkTag.
  ///
  /// In en, this message translates to:
  /// **'Teamwork'**
  String get teamworkTag;

  /// No description provided for @vitraTitle.
  ///
  /// In en, this message translates to:
  /// **'IT Team Assistant'**
  String get vitraTitle;

  /// No description provided for @vitraDate.
  ///
  /// In en, this message translates to:
  /// **'February 2024 – May 2024'**
  String get vitraDate;

  /// No description provided for @vitraPoint1.
  ///
  /// In en, this message translates to:
  /// **'Gained knowledge about corporate technology infrastructure by observing IT processes.'**
  String get vitraPoint1;

  /// No description provided for @vitraPoint2.
  ///
  /// In en, this message translates to:
  /// **'Actively participated in meeting notes, task tracking, and internal communication processes.'**
  String get vitraPoint2;

  /// No description provided for @vitraPoint3.
  ///
  /// In en, this message translates to:
  /// **'Provided support on tools and systems used in project management processes.'**
  String get vitraPoint3;

  /// No description provided for @sapTag.
  ///
  /// In en, this message translates to:
  /// **'SAP'**
  String get sapTag;

  /// No description provided for @projectTrackingTag.
  ///
  /// In en, this message translates to:
  /// **'Project Tracking'**
  String get projectTrackingTag;

  /// No description provided for @corporateExperienceTag.
  ///
  /// In en, this message translates to:
  /// **'Corporate Experience'**
  String get corporateExperienceTag;

  /// No description provided for @teamCommunicationTag.
  ///
  /// In en, this message translates to:
  /// **'Team Communication'**
  String get teamCommunicationTag;

  /// No description provided for @akbankTitle.
  ///
  /// In en, this message translates to:
  /// **'IT Team Assistant'**
  String get akbankTitle;

  /// No description provided for @akbankDate.
  ///
  /// In en, this message translates to:
  /// **'November 2023 – February 2024'**
  String get akbankDate;

  /// No description provided for @akbankPoint1.
  ///
  /// In en, this message translates to:
  /// **'Observed software and project development processes carried out in the IT department.'**
  String get akbankPoint1;

  /// No description provided for @akbankPoint2.
  ///
  /// In en, this message translates to:
  /// **'Experienced corporate agile methodologies by participating in Scrum meetings.'**
  String get akbankPoint2;

  /// No description provided for @akbankPoint3.
  ///
  /// In en, this message translates to:
  /// **'Assumed responsibility in support processes such as in-team documentation, reporting, and task tracking.'**
  String get akbankPoint3;

  /// No description provided for @fazlaTitle.
  ///
  /// In en, this message translates to:
  /// **'React Native Intern'**
  String get fazlaTitle;

  /// No description provided for @fazlaDate.
  ///
  /// In en, this message translates to:
  /// **'August 2023 – November 2023'**
  String get fazlaDate;

  /// No description provided for @fazlaPoint1.
  ///
  /// In en, this message translates to:
  /// **'Developed stock tracking application and contributed to testing processes.'**
  String get fazlaPoint1;

  /// No description provided for @fazlaPoint2.
  ///
  /// In en, this message translates to:
  /// **'Designed mobile interfaces and managed data using React Native.'**
  String get fazlaPoint2;

  /// No description provided for @fazlaPoint3.
  ///
  /// In en, this message translates to:
  /// **'Learned software development processes by participating in in-team code reviews.'**
  String get fazlaPoint3;

  /// No description provided for @typeScriptTag.
  ///
  /// In en, this message translates to:
  /// **'TypeScript'**
  String get typeScriptTag;

  /// No description provided for @restApiTag.
  ///
  /// In en, this message translates to:
  /// **'REST API'**
  String get restApiTag;

  /// No description provided for @contactSocialCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Get in touch'**
  String get contactSocialCardTitle;

  /// No description provided for @directEmail.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get directEmail;

  /// No description provided for @linkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedin;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @scheduleCallTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule a Call'**
  String get scheduleCallTitle;

  /// No description provided for @scheduleCallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Prefer to talk instead of type? Let\'s schedule a quick 15-minute call to discuss your project.'**
  String get scheduleCallSubtitle;

  /// No description provided for @scheduleCallButton.
  ///
  /// In en, this message translates to:
  /// **'Schedule a Meeting'**
  String get scheduleCallButton;

  /// No description provided for @footerName.
  ///
  /// In en, this message translates to:
  /// **'Can Kırkgöz'**
  String get footerName;

  /// No description provided for @footerTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Developer · Flutter Developer · Problem Solver'**
  String get footerTitle;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Can Kırkgöz. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get footerHome;

  /// No description provided for @footerAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get footerAbout;

  /// No description provided for @footerProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get footerProjects;

  /// No description provided for @footerSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get footerSkills;

  /// No description provided for @footerExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get footerExperience;

  /// No description provided for @footerContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get footerContact;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
