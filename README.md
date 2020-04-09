# Application Coordinator

## Basic Setup

Add the following code to your scene delegate file

```swift
var window: UIWindow?

lazy var homePage: HomePage = HomePage()
lazy var homeController = homePage.viewController(delegate: coordinatorDelegate, request: nil)
lazy var navigationController = Presentor.PresentorNavigationController(rootViewController: homeController)
lazy var coordinatorDelegate: CoordinatorDelegateProtocol = CoordinatorDelegate(page: homePage)
lazy var presentor: Presentor = Presentor(rootViewController: navigationController)
lazy var appDelegateCoordinator: AppDelegateCoordinator = AppDelegateCoordinator(rootViewController: navigationController)

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }

    coordinatorDelegate.setPresentor(presentor: presentor)
    window = appDelegateCoordinator.createWindow()
    window?.windowScene = windowScene

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
        (self?.homeController as? MockViewController)?.showBlue()
    }
}
```
