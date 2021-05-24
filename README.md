# clean_architechture

A new Flutter application with clean architechture

## Getting Started

###Configuration Environment Running
- ANDROID STUDIO
Step 1 : Open "Edit Configuration in Android Studio"

Step 2 : Create new Configuration with build flavor value is :
    + Develop Environment : development
    + Staging Environment : staging
    + Production Environment : production
- VS CODE

###One terminal to build both IPA and APK
- .build.sh {enviroment} : .build.sh development
- enviroment can be : development, staging, production
- Note after build IPA : After build IOS finish. Go to Xcode => Archive IPA file


###These step need to run before can run app in code

- Multi-languages
Step 1 : run terminal "flutter clean"

Step 2 : run terminal "flutter pub get"

Step 3 : run terminal "flutter pub global run intl_utils:generate"

- Assets,Json generate
Step 4 : run terminal "dart pub global activate flutter_gen"

Step 5 : run terminal "flutter packages pub run build_runner build"

### Project architecture (Clean Architecture Approach)

1. Why:
    * We want to separate what type of database that we use for storage (might want to change it later on)
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

1. We are using `GetIt` for injections. It is fun because we can start the service locator and use it everywhere when
   needed because they are injected at top-level in main.dart.
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

Using this library to handle multi-languages. Follow this guide to understand and config languages files

* VSC, AS, IJ users need to install the plugins from the market Plugin : flutter-intl

* others/CLI:

```
flutter pub global activate intl_utils

flutter pub global run intl_utils:generate
```

### Initialize plugins (IntelliJ reference)

1. Open Flutter intl in `Action`
2. Click on `Initialize for project`

3. To add / remove Locale, choose `Add Locale` / `Remove Locale`
4. Then it will promp which locale

**Current available locale is en, ms_MY**

Link library : https://pub.dev/packages/intl_utils
Link plugin : https://plugins.jetbrains.com/plugin/13666-flutter-intl
//TODO : Generate with CSV file


### Json parsing / serialization

This project is implementing [json_serializable](https://pub.dev/packages/json_serializable). It use build_runner to
generate files. If you make a change to these files, you need to re-run the generator using build_runner:

```
flutter pub run build_runner build
```

generator using build_runner and remove conflict file :

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

# Assets

- Image is handled by [flutter_gen](https://pub.dev/packages/flutter_gen) for auto-complete and not have to deal with
  typing mistakes.
- To setup flutter_gen, run `dart pub global activate flutter_gen`

## Adding new Assets

- Add asset(s) into `assets/<asset types>`
- Run `flutter pub run build_runner build` in console
- New image(s) will appear in `lib/gen/assets`

## Remove Asset(s)

- Delete assets from `assets/<asset types>`
- Run `flutter pub run build_runner build` in console
- `lib/gen/assets` will be updated with currently available assets.


##Note when build apk release
- Refer to this issue that if using new gradle.properties will be error while build release app.
So that need to use older version
 + build.gradle "build:gradle:3.5.0" on android/build.gradle 
 + "gradle-5.6.2" on gradle-wrapper.properties 

## Terminal build APK or IPA
- run terminal build apk "flutter build apk --flavor development"
- run terminal build ios "flutter build ios --flavor development"
- "flutter build apk --flavor {flavorName}"

## How to change version number and version code :
- Go to pubspec.yaml => line version to change : 
- Example : 1.0.10+3 => Version name : 1.0.10, Version code : 3

## Set-up Gitlab CI
- Follow this link to create runner and register Runner : https://docs.gitlab.com/runner/install/
- If runner got warning : Run this terminal to verify runner again : gitlab-runner verify
- Remember using image : cirrusci/flutter:stable on gitlab.ci config