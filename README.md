# jolly_podcast

## Getting Started

This is a mini jolly_podcase app built with Flutter

### Step(s) to run the project:

- Firstly, update the package dependencies using `flutter pub get` command when you clone the repo.

- Use `flutter run --debug` to run the application in debug mode.
 
  OR

- Use `flutter run --release` to build and run the application in release mode.

> [!NOTE]
> The default mode when `flutter run` command is used is debug mode

### Chosen state management approach
- **_Bloc state management_** was used with clean architecture design pattern. This is obviously close to MVVM architecture.
- Most importantly, Bloc State management implicitly function within that phase of acting as viewModel while interacting with the data layer and the Presentation Layer.
- Where clean architectures comes in handing is the fact that the design has a way of naturally forcing separation of concerns. Whereby making the layers to be distinct and loosely coupled.
- The loose coupling functionality comes to play with the use of `get_it package` for dependency injection. Hence, this enhances scalability in the long run.
- Another way one can take a look at loose coupling is the contract implementation in the domain layer, this reduces or avoid depending on platform-specific code.
- The basic folder structure for this architecture is very clear
```
Data
    dataSources
    repositories (This folder contains the implementation of the interface)
    model
Domain
    entity
    repositories (This folder contains the interface which is called contract)
    usecase
presentation
    state management(bloc state management in this case)
    views
```

### Assumption made

### Improvement with more time
- The loading states of the images and preferrably implement a shimmer loading effect.
- Feedbacks from the button interactions on the audio player screen. Probably, put some animation.