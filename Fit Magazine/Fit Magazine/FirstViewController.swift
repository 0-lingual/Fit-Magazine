import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    // 상단 라벨 (로고처럼 사용)
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "🅕 Fit Magazine"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0) // 주황색 배경
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 이모지 라벨
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🧥🪞" // 새로운 이모지 텍스트
        label.font = .systemFont(ofSize: 100)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 메인 텍스트 라벨
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "3D 피팅 서비스, Fit Magazine" // 새로운 텍스트
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 서브 텍스트 라벨
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "입고 싶었던 옷을 마음껏 피팅해보세요!" // 새로운 텍스트
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 시작하기 버튼
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.darkGray // UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0) // 배경색을 주황색으로 설정
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 가운데 흰색 배경 뷰 (컨텐츠 래퍼)
    lazy var contentWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 하단 라벨 (크레딧 정보 및 연락처 추가)
    lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left // 왼쪽 정렬
        label.numberOfLines = 3 // 3줄로 설정
        label.backgroundColor = .white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true // cornerRadius 적용
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // 줄 간격 조정을 위해 NSAttributedString 사용
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 // 두 줄 사이 간격을 5로 설정
        paragraphStyle.headIndent = 20 // 왼쪽 여백 추가
        paragraphStyle.firstLineHeadIndent = 20
        
        let attributedText = NSMutableAttributedString(
            string: "© 현종혁 (iOS), 김현우, 이다인 (Back-end)\n☏ 010-4006-8352\n✉︎ jhh980622@naver.com",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.black
            ]
        )
        label.attributedText = attributedText
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0) // 배경색을 주황색으로 설정
        setupLayout()
    }
    
    private func setupLayout() {
        // 뷰에 요소 추가
        view.addSubview(logoLabel)
        view.addSubview(contentWrapperView)
        contentWrapperView.addSubview(emojiLabel)
        contentWrapperView.addSubview(mainLabel)
        contentWrapperView.addSubview(subLabel)
        contentWrapperView.addSubview(startButton)
        view.addSubview(footerLabel)
        
        // 로고 라벨 위치 설정 (상단, 가려지지 않도록 높이 조정)
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10) // 약간의 여백 추가
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50) // 높이를 줄여서 가리지 않도록 설정
        }
        
        // 가운데 흰색 배경 설정 (컨텐츠 래퍼)
        contentWrapperView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(450) // 높이를 450으로 설정
        }
        
        // 이모지 위치 설정 (중앙)
        emojiLabel.snp.makeConstraints { make in
            make.top.equalTo(contentWrapperView).offset(60)
            make.centerX.equalToSuperview()
        }
        
        // 메인 텍스트 위치 설정
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 서브 텍스트 위치 설정 (메인 텍스트 밑 15px)
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 시작하기 버튼 위치 설정 (서브 텍스트 밑 60px)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300) // 버튼 길이를 300으로 설정
            make.height.equalTo(50)
        }
        
        // 하단 크레딧 및 연락처 라벨 위치 설정
        footerLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalToSuperview().offset(20) // 왼쪽 여백 추가
            make.trailing.equalToSuperview().inset(20) // 오른쪽 여백
            make.height.equalTo(90) // 두 줄 텍스트가 적절히 보이도록 높이 설정
        }
    }
    
    @objc private func startButtonTapped() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

