import UIKit
import SceneKit
import SnapKit

class ThirdViewController: UIViewController {
    
    lazy var sceneView: SCNView = {
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.backgroundColor = .white
        sceneView.allowsCameraControl = true // 카메라 제어 활성화
        return sceneView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("뒤로가기", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0)
        
        setupLayout()
        loadAndDisplayOBJFile()
    }
    
    private func setupLayout() {
        view.addSubview(sceneView)
        view.addSubview(backButton)
        
        sceneView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(sceneView.snp.width).multipliedBy(3.0 / 4.0)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(sceneView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadAndDisplayOBJFile() {
        guard let url = Bundle.main.url(forResource: "output2", withExtension: "obj") else {
            showAlert("OBJ 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            let objNode = try SCNScene(url: url, options: nil).rootNode
            
            // Scene 생성 및 조명 추가
            let scene = SCNScene()
            scene.rootNode.addChildNode(objNode)
            
            // Ambient Light 추가
            let ambientLight = SCNLight()
            ambientLight.type = .ambient
            ambientLight.color = UIColor(white: 0.5, alpha: 1.0)
            let ambientLightNode = SCNNode()
            ambientLightNode.light = ambientLight
            scene.rootNode.addChildNode(ambientLightNode)
            
            // Directional Light 추가
            let directionalLight = SCNLight()
            directionalLight.type = .directional
            directionalLight.color = UIColor(white: 1.0, alpha: 1.0)
            let directionalLightNode = SCNNode()
            directionalLightNode.light = directionalLight
            directionalLightNode.eulerAngles = SCNVector3(-Float.pi / 3, -Float.pi / 4, 0)
            scene.rootNode.addChildNode(directionalLightNode)

            sceneView.scene = scene
        } catch {
            showAlert("3D 모델을 불러올 수 없습니다. 오류: \(error)")
            print("OBJ 파일 로드 실패:", error.localizedDescription)
        }
    }
    
    private func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
}
