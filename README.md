# clean_architecture

A new Flutter application with clean architecture

## Getting Started

- Flutter version using : 2.8.1 (stable at 4/1/2022)
- Dart version using : 2.15.1
- Platform android : 30, Build-tools : 30.0.2
- Java version OpenJDK 11.0.10

### Configuration Environment Running

- ANDROID STUDIO Step 1 : Open " Run => Edit Configuration in Android Studio"

Step 2 : Create new Configuration with build flavor value is :

+ Develop Environment : development
+ Staging Environment : staging
+ Production Environment : production

### Build APK

- flutter build apk --flavor {flavorOnStep2}

### Build IPA without archive on Xcode

- flutter build ipa --flavor {flavorOnStep2} --export-options-plist=ios/Runner/ExportOptions.plist

### These step need to run before can run app in code

Step 1 : run terminal "flutter clean"

Step 2 : run terminal "flutter pub get"

- Assets,Json , multi-languages generate

  Step 3 : run terminal "dart pub global activate flutter_gen"

Step 4 : run terminal "flutter packages pub run build_runner build"
or run terminal "flutter packages pub run build_runner build --delete-conflicting-outputs" if error

### Project architecture (Clean Architecture Approach)

1. Why:
    * We want to separate what type of database that we use for storage (might want to change it
      later on)
    * To adhere SOLID principles since we are using OOP for this project.
    * Ensuring UI layers don't know what is going on at data layer at all.
    * Might want to separate each layers into different packages.
2. Presentation - Domain - Data.
3. Presentation layer consist of
    * Widgets
    * BLoC
        * Bloc only manages UI state based on business logic
4. Domain layer (Business logic layer)
    * Repositories (interfaces aka idea how the logic would behave)
    * Entities (or models which what UI needs)
    * Usecases (user stories)
        * Typically one function, but can be more if they are functionality related.
        * Remember, one class for one responsibility.
5. Data layer
    * Data Sources
        * remotes (API)
        * locals (Database)
    * Models
        * request
        * response
    * Repositories (Implementation from Domain layer)
6. More insight of layers
   ![image](https://miro.medium.com/max/772/0*sfCDEb571WD-7EfP.jpg)
7. The inner layer should **NOT** know what the outer layer has / do.
8. Reference:
    1. https://github.com/ResoCoder/flutter-tdd-clean-architecture-course
    2. https://github.com/ShadyBoukhary/flutter_clean_architecture (We don't use this plugin)
    3. https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html

## Injections

1. We are using `GetIt` for injections. It is fun because we can start the service locator and use
   it everywhere when needed because they are injected at top-level in main.dart.
2. Only use it upon initialization

```
getIt.registerSingleton<LoginBloc>(LoginBloc(
    loginUseCase: LoginUseCase(getIt<LoginRepositoryImpl>()),
  ));
```

and use it on `route`

```
BlocProvider<LoginBloc>(
    create: (_) => getIt.get<LoginBloc>(),
),
```

for reusing the `BLoC`,

```
BlocProvider.value(
    value: getIt.get<PumpsBloc>(),
)
```

for usage (in Widgets), **always** use

`context.boc<PumpsBloc>().add(AddPumps());`

instead of

`getIt.get<PumpsBloc>().add(AppPumps());`

For non widget usage, manually inject the object on initialization.

### Localization

We are using Easy Localization to handle multi-languages. Using google sheet file on cloud will take
less effort for change and update key and value. Only need update in google sheet file.

Google sheet sample on this project :
"https://docs.google.com/spreadsheets/d/1SpiJWFRfJaIRnzpEc0mJ2WaaI9JYlz8jKBPduAPzdXE/edit#gid=1013756643"

Step to set-up google sheet :

- 1 : Create a CSV Google Sheet with form like that form
  "https://docs.google.com/spreadsheets/d/1SpiJWFRfJaIRnzpEc0mJ2WaaI9JYlz8jKBPduAPzdXE/edit#gid=1013756643"
- 2 : Enable share for anyone have this link
- 3 : on file locale_keys.dart in lib/utils/multi-languages/locale_keys.dart change docId annotation
  with your google sheet docid Example of DocID is :
  "https://docs.google.com/spreadsheets/d/1SpiJWFRfJaIRnzpEc0mJ2WaaI9JYlz8jKBPduAPzdXE (it's docId)
  /edit#gid=1013756643"
- 4 : run terminal : "flutter pub run build_runner build" to generate .g.dart localization file
- 5 : When update new value on google sheet should update plus one version on SheetLocalization at
  locale_keys.dart and run "flutter packages pub run build_runner build" again to get new file csv

Step to use multi-languages import in code:

- Remember import file "multi_languages_utils.dart" instead of "locale_keys.dart" because first file
  already import library easy_localization extension,you no need to use 2 import

- Using : LocaleKeys.keyDefine.tr()  (tr() is using to change languages with current languages
  setup, remember have it)

Link library : https://pub.dev/packages/easy_localization
Link plugin generate csv from google
sheet : https://github.com/Hoang-Nguyenn/easy_localization_generator

### Json parsing / serialization

This project is implementing [json_serializable](https://pub.dev/packages/json_serializable). It use
build_runner to generate files. If you make a change to these files, you need to re-run the
generator using build_runner:

```
flutter pub run build_runner build
```

generator using build_runner and remove conflict file :

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

# Assets

- Image is handled by [flutter_gen](https://pub.dev/packages/flutter_gen) for auto-complete and not
  have to deal with typing mistakes.
- To setup flutter_gen, run `dart pub global activate flutter_gen`

## Adding new Assets

- Add asset(s) into `assets/<asset types>`
- Run `flutter pub run build_runner build` in console
- New image(s) will appear in `lib/gen/assets`

## Remove Asset(s)

- Delete assets from `assets/<asset types>`
- Run `flutter pub run build_runner build` in console
- `lib/gen/assets` will be updated with currently available assets.

## Note when build apk release

- Refer to this issue that if using new gradle.properties will be error while build release app. So
  that need to use older version

+ build.gradle "build:gradle:3.5.0" on android/build.gradle
+ "gradle-5.6.2" on gradle-wrapper.properties

## How to change version number and version code :

- Go to pubspec.yaml => line version to change :
- Example : 1.0.10+3 => Version name : 1.0.10, Version code : 3

## Set-up Gitlab CI

- Follow this link to create runner and register Runner : https://docs.gitlab.com/runner/install/
- If runner got warning : Run this terminal to verify runner again : gitlab-runner verify
- Remember using image : cirrusci/flutter:stable on gitlab.ci config

## Step to change package name

- We using library change_app_package_name for easy and fast to change all package name on android
  and IOS
- Using terminal : flutter pub run change_app_package_name:main "newPackageName"
- Example : flutter pub run change_app_package_name:main com.vmo.newApp

## Using fastlane

- Require JAVAHOME
- Install Ruby (https://docs.fastlane.tools/)
- gem install bundler (First time run)
- bundle install (First time run)
- bundle exec fastlane android buildAndroidLocal --env development (Development environment)
- bundle exec fastlane android buildAndroidLocal --env staging (Staging environment)
- bundle exec fastlane android buildAndroidLocal (Production environment)
