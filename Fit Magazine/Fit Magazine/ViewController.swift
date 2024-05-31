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
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 186/255, blue: 135/255, alpha: 0.5)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Fit Magazine"
        label.textColor = .orange
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 30)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "3D 가상 의류 실착 서비스"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 선택"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var firstInputView: UIImageView = {
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
    
    lazy var secondInputView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var clothImageButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor(red: 255/255, green: 186/255, blue: 135/255, alpha: 0.5)
        btn.setTitle("의류 이미지 선택", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(userImageButton_touchUpInside), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var outfitCheckButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("실착 모습 확인", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = .systemGray2
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var outputView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: "miinji.jpg") {
            view.image = image
        } else {
            print("이미지를 로드할 수 없습니다.")
        }
        
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 244/255, blue: 246/255, alpha: 1.0)
        
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
        checkPhotoLibraryPermission(sender: sender)
    }
    
    func checkPhotoLibraryPermission(sender: UIButton) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            presentImagePicker(sender: sender)
        case .denied, .restricted:
            showAlert("앨범 접근 권한이 필요합니다.")
        case .limited:
            presentImagePicker(sender: sender)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized, .limited:
                    DispatchQueue.main.async {
                        self.presentImagePicker(sender: sender)
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
    
    func presentImagePicker(sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.view.tag = sender == userImageButton ? 1 : 2
        present(imagePickerController, animated: true)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
    
    // UIImagePickerControllerDelegate 메서드 - 이미지 선택 후 호출됨
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            if picker.view.tag == 1 {
                firstInputView.image = image
            } else if picker.view.tag == 2 {
                secondInputView.image = image
            }
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
        
        [headerView, firstInputView, userImageButton, secondInputView, clothImageButton, outputView, inputLabel, outfitCheckButton].forEach { view in
            contentView.addSubview(view)
        }
        
        [topLabel, bottomLabel].forEach { view in
            headerView.addSubview(view)
        }
    }
    
    func Constraint() {
        scrollview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollview)
            make.width.equalTo(scrollview)
            make.height.equalTo(1300)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(80)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(headerView.snp.height).multipliedBy(0.5)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(headerView.snp.height).multipliedBy(0.5)
        }
        
        inputLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        firstInputView.snp.makeConstraints { make in
            make.top.equalTo(inputLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
        
        userImageButton.snp.makeConstraints { make in
            make.top.equalTo(firstInputView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(35)
        }
        
        secondInputView.snp.makeConstraints { make in
            make.top.equalTo(userImageButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
        
        clothImageButton.snp.makeConstraints { make in
            make.top.equalTo(secondInputView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(35)
        }
        
        outfitCheckButton.snp.makeConstraints { make in
            make.top.equalTo(clothImageButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        outputView.snp.makeConstraints { make in
            make.top.equalTo(outfitCheckButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
    }
}

