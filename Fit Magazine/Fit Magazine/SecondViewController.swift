import UIKit
import SnapKit
import Photos

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        let button = UIButton(type: .system)
        button.setTitle("전신 이미지 선택", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(selectUserImage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        let button = UIButton(type: .system)
        button.setTitle("의류 이미지 선택", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(selectClothImage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkFittingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("실착 모습 확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 0/255, green: 74/255, blue: 173/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showFitting), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 240/255, green: 86/255, blue: 80/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetImages), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0)
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [firstInputView, userImageButton, secondInputView, clothImageButton, checkFittingButton, resetButton].forEach { contentView.addSubview($0) }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        firstInputView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(firstInputView.snp.width).multipliedBy(2.0 / 3.0)
        }
        
        userImageButton.snp.makeConstraints { make in
            make.top.equalTo(firstInputView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        secondInputView.snp.makeConstraints { make in
            make.top.equalTo(userImageButton.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(secondInputView.snp.width).multipliedBy(2.0 / 3.0)
        }
        
        clothImageButton.snp.makeConstraints { make in
            make.top.equalTo(secondInputView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        checkFittingButton.snp.makeConstraints { make in
            make.top.equalTo(clothImageButton.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(checkFittingButton.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView).offset(-15)
        }
    }
    
    @objc private func selectUserImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.view.tag = 1
        present(imagePickerController, animated: true)
    }
    
    @objc private func selectClothImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.view.tag = 2
        present(imagePickerController, animated: true)
    }
    
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
    
    @objc private func resetImages() {
        firstInputView.image = nil
        secondInputView.image = nil
    }

    private func cropImage(_ image: UIImage, toRect rect: CGRect) -> UIImage? {
        let scale = image.scale
        let scaledRect = CGRect(
            x: rect.origin.x * scale,
            y: rect.origin.y * scale,
            width: rect.width * scale,
            height: rect.height * scale
        )
        
        guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: image.imageOrientation)
    }

    @objc private func showFitting() {
        guard let userImage = firstInputView.image, let clothImage = secondInputView.image else {
            showAlert("전신 이미지와 의류 이미지를 모두 선택해주세요.")
            return
        }
        
        let croppedUserImage = cropImage(userImage, toRect: CGRect(x: 0, y: 0, width: 200, height: 200))
        let croppedClothImage = cropImage(clothImage, toRect: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        // 3D 변환 메시지 창 표시
        let alert = UIAlertController(title: nil, message: "3D로 변환 중입니다...", preferredStyle: .alert)
        present(alert, animated: true)
        
        Task {
            try? await Task.sleep(nanoseconds: 15 * 1_000_000_000)  // 15초 딜레이
            
            uploadImages(userImage: croppedUserImage ?? userImage, clothImage: croppedClothImage ?? clothImage) { success in
                DispatchQueue.main.async {
                    alert.dismiss(animated: true)  // 메시지 창 닫기
                    if success {
                        let thirdVC = ThirdViewController()
                        self.navigationController?.pushViewController(thirdVC, animated: true)
                    } else {
                        self.showAlert("이미지 전송에 실패했습니다.")
                    }
                }
            }
        }
    }
    
    private func uploadImages(userImage: UIImage, clothImage: UIImage, completion: @escaping (Bool) -> Void) {
        // 여기에 백엔드 endpoint 적기
        guard let 
                = URL(string: "https://your-backend-url.com/api/upload") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let imageData = createImageData(userImage: userImage, clothImage: clothImage, boundary: boundary)
        request.httpBody = imageData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during upload: \(error.localizedDescription)")
                completion(false)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
    
    private func createImageData(userImage: UIImage, clothImage: UIImage, boundary: String) -> Data {
        var data = Data()
        
        if let userImageData = userImage.jpegData(compressionQuality: 0.8) {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"userImage\"; filename=\"userImage.jpg\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(userImageData)
            data.append("\r\n".data(using: .utf8)!)
        }

        if let clothImageData = clothImage.jpegData(compressionQuality: 0.8) {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"clothImage\"; filename=\"clothImage.jpg\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(clothImageData)
            data.append("\r\n".data(using: .utf8)!)
        }

        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return data
    }
    
    private func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
}
