import UIKit
import SnapKit
import Photos

class ViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "3D 가상 의류 피팅 서비스, Fit Magazine"
        label.textColor = .orange
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = UIColor(red: 255/255, green: 186/255, blue: 135/255, alpha: 0.5)
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var userImageButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor(red: 255/255, green: 186/255, blue: 135/255, alpha: 0.5)
        btn.setTitle("전신 이미지 선택", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(userImageButton_touchUpInside), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        SetView()
        Constraint()
        
        // 디버깅을 위한 프린트 문 추가
        print("viewDidLoad 완료")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("userImageButton frame: \(userImageButton.frame)")
    }
    
    @objc func userImageButton_touchUpInside(sender: UIButton) {
        print("userImageButton_touchUpInside 호출됨")
        checkPhotoLibraryPermission()
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            presentImagePicker()
        case .denied, .restricted:
            showAlert("앨범 접근 권한이 필요합니다.")
        case .limited:
            presentImagePicker()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized, .limited:
                    DispatchQueue.main.async {
                        self.presentImagePicker()
                    }
                case .denied, .restricted, .notDetermined:
                    DispatchQueue.main.async {
                        self.showAlert("앨범 접근 권한이 필요합니다.")
                    }
                @unknown default:
                    fatalError("알 수 없는 상태")
                }
            }
        @unknown default:
            fatalError("알 수 없는 상태")
        }
    }
    
    func presentImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
    
    // UIImagePickerControllerDelegate 메서드 - 이미지 선택 후 호출됨
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
        } else if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true)
    }
    
    func SetView() {
        [scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [textLabel, imageView, userImageButton].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    func Constraint() {
        scrollview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollview)
            make.width.equalTo(scrollview)
            make.height.equalTo(800) // 스크롤 뷰 높이 설정
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(250)
        }
        
        userImageButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(50)
        }
    }
}

