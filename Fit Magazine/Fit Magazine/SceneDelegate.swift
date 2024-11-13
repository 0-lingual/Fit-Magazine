import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        // window에 새로운 UIWindow 인스턴스를 직접 할당하고 설정합니다.
        let window = UIWindow(windowScene: windowScene)
        
        // 첫 화면으로 사용할 ViewController를 UINavigationController에 포함
        let firstViewController = FirstViewController()
        let navigationController = UINavigationController(rootViewController: firstViewController)
        
        // 네비게이션 컨트롤러를 루트 뷰로 설정
        window.rootViewController = navigationController
        
        // 윈도우를 self.window에 할당하여 유지시키고 화면에 표시합니다.
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

