# jolly_podcast

## Getting Started

This is a mini jolly_podcase app built with Flutter

### Step(s) to run the project:

- Create environment variable file in the root folder
```
 create the env file in the root folder with the name ".env"

 Copy the API link to the env file:

 Something like this:

 - BASE_URL = "https://api.jollypodcast.net/api/"
```
- Run these commands to generate the URL_LINK
  ```
  dart run build_runner clean
  dart run build_runner build --delete-conflicting-outputs
  ```

- Update the package dependencies using `flutter pub get` command when you clone the repo. (Optional)

- Use `flutter run --debug` to run the application in debug mode.
 
  OR

- Use `flutter run --release` to build and run the application in release mode.

> [!NOTE]
> The debug mode is the default mode when `flutter run` command is used

### Chosen state management approach
- **_Bloc state management_** was used with clean architecture design pattern. This is related to MVVM architecture at the presentation layer
- Bloc State management implicitly function as viewModel because it serves as the medium of  interacton between the data layer and the Presentation Layer.
- Clean architectures implementation naturally enforces separation of concerns. This makes the distinct layers and loosely coupled components.
- The loose coupling was achieved in this project with the use of `get_it package` for dependency injection. This enhances scalability and maintainability in the long run.
- Another way to look at loose coupling of this design pattern is the contract implementation in the domain layer, this reduces or avoid depending on platform-specific code.
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
- To persist and track each podcast last position when the user leaves the audio player screen or the application; such that the user can continue listening from where it was stopped.