import UIKit

final class ViewController: UIViewController {
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension ViewController {
    private enum Constants {
        static let imageSize: CGSize = .init(width: 36, height: 36)
        static let imageBottomOffset: CGFloat = 8
        static let imageTrailingOffset: CGFloat = 16

        static let scrollContentHeight: CGFloat = 1500
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        setupNavBar()
        setupScrollView()
        setupImage()
    }

    private func setupNavBar() {
        title = "Avatar"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupScrollView() {
        scrollView.frame = view.frame
        scrollView.contentSize = .init(
            width: view.frame.width,
            height: Constants.scrollContentHeight
        )
        
        view.addSubview(scrollView)
    }

    private func setupImage() {
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .lightGray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false

        guard let largeTitleClass = NSClassFromString("_UINavigationBarLargeTitleView") else {
            return
        }
        
        DispatchQueue.main.async { [self] in
            self.navigationController?.navigationBar.subviews.forEach { subview in
                guard subview.isKind(of: largeTitleClass.self) else {
                    return
                }
                
                subview.addSubview(self.imageView)
                
                NSLayoutConstraint.activate([
                    self.imageView.heightAnchor.constraint(
                        equalToConstant: Constants.imageSize.height
                    ),
                    self.imageView.widthAnchor.constraint(
                        equalToConstant: Constants.imageSize.width
                    ),
                    self.imageView.bottomAnchor.constraint(
                        equalTo: subview.bottomAnchor,
                        constant: -Constants.imageBottomOffset
                    ),
                    self.imageView.trailingAnchor.constraint(
                        equalTo: subview.trailingAnchor,
                        constant: -Constants.imageTrailingOffset
                    )
                ])
            }
        }
    }
}
