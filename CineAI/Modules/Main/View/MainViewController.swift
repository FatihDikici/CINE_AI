import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    let backgroundView = UIView()
    let headerContainerView = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let searchContainerView = UIView()
    let searchTextField = UITextField()
    let searchIconImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        // Custom CollectionViewCell'i kaydetme
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimations()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntrance()
        
        // Gradient'i doğru boyutta ayarlama
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateGradientFrame()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1.0)
        
        // Modern gradient background (RegisterViewController ile aynı)
        setupGradientBackground()
        
        // Navigation bar styling
        setupNavigationBar()
        
        // Header container
        setupHeaderContainer()
        
        // Search container
        setupSearchContainer()
        
        // Activity indicator
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        // Add subviews
        view.addSubview(headerContainerView)
        view.addSubview(searchContainerView)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        // Constraints
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            headerContainerView.heightAnchor.constraint(equalToConstant: 80),
            
            searchContainerView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 25),
            searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 25),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Search text field actions
        searchTextField.addTarget(self, action: #selector(searchTextFieldEditingBegan), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(searchTextFieldEditingEnded), for: .editingDidEnd)
        
        
        let settingsButton = UIBarButtonItem(title: "Ayarlar", style: .plain, target: self, action: #selector(settingsButtonTapped))
               navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func settingsButtonTapped() {
           // Butona tıklandığında ne olacağını burada belirleyeceğiz.
           // SettingsRouter'ı kullanarak modülü oluşturup geçiş yapacağız.
        let settingsViewController = SettingsRouter.CreateModule()
           navigationController?.pushViewController(settingsViewController, animated: true)
       }
    
    func setupGradientBackground() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 0.80, green: 0.12, blue: 0.25, alpha: 1.0).cgColor,
            UIColor(red: 0.15, green: 0.08, blue: 0.20, alpha: 1.0).cgColor,
            UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        // Navigation bar'ı şeffaf yap
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
    }
    
    func setupHeaderContainer() {
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title styling (RegisterViewController ile uyumlu)
        titleLabel.text = "CineAI"
        titleLabel.font = .systemFont(ofSize: 32, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Subtitle
        subtitleLabel.text = "Popüler Filmler"
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .light)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor(white: 0.8, alpha: 1.0)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerContainerView.addSubview(titleLabel)
        headerContainerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
    }
    
    func setupSearchContainer() {
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
        searchContainerView.layer.cornerRadius = 25
        searchContainerView.layer.borderWidth = 1
        searchContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        
        // Glassmorphism effect
        searchContainerView.layer.shadowColor = UIColor.black.cgColor
        searchContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchContainerView.layer.shadowRadius = 8
        searchContainerView.layer.shadowOpacity = 0.1
        
        // Search icon
        searchIconImageView.image = UIImage(systemName: "magnifyingglass")
        searchIconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8)
        searchIconImageView.contentMode = .scaleAspectFit
        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Search text field
        searchTextField.borderStyle = .none
        searchTextField.textColor = .white
        searchTextField.font = .systemFont(ofSize: 16, weight: .medium)
        searchTextField.backgroundColor = .clear
        searchTextField.autocapitalizationType = .none
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Film ara...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0.7, alpha: 0.6)]
        )
        
        searchContainerView.addSubview(searchIconImageView)
        searchContainerView.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchIconImageView.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 15),
            searchIconImageView.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 20),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchIconImageView.trailingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -15),
            searchTextField.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupAnimations() {
        // Initial animation state
        headerContainerView.transform = CGAffineTransform(translationX: 0, y: -30)
        headerContainerView.alpha = 0
        
        searchContainerView.transform = CGAffineTransform(translationX: 0, y: 30)
        searchContainerView.alpha = 0
        
        collectionView.transform = CGAffineTransform(translationX: 0, y: 40)
        collectionView.alpha = 0
    }
    
    func animateEntrance() {
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.headerContainerView.alpha = 1
            self.headerContainerView.transform = .identity
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.3) {
            self.searchContainerView.alpha = 1
            self.searchContainerView.transform = .identity
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
            self.collectionView.alpha = 1
            self.collectionView.transform = .identity
        }
    }
    
    func updateGradientFrame() {
        if let gradientLayer = backgroundView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = view.bounds
        }
    }
    
    
    @objc func searchTextFieldEditingBegan() {
        animateFocus(containerView: searchContainerView, iconImageView: searchIconImageView)
    }
    
    @objc func searchTextFieldEditingEnded() {
        animateUnfocus(containerView: searchContainerView, iconImageView: searchIconImageView)
    }
    
    func animateFocus(containerView: UIView, iconImageView: UIImageView) {
        UIView.animate(withDuration: 0.2) {
            containerView.layer.borderColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8).cgColor
            containerView.layer.borderWidth = 2
            iconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
            containerView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        }
    }
    
    func animateUnfocus(containerView: UIView, iconImageView: UIImageView) {
        UIView.animate(withDuration: 0.2) {
            containerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
            containerView.layer.borderWidth = 1
            iconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8)
            containerView.transform = .identity
        }
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func showLoading() {
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.startAnimating()
            self.collectionView.alpha = 0.3
        }
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.stopAnimating()
            self.collectionView.alpha = 1.0
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            UIView.transition(with: self.collectionView, duration: 0.3, options: .transitionCrossDissolve) {
                self.collectionView.reloadData()
            }
        }
    }
    
    func displayMovies(movies: [Movie]) {}
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "⚠️ Hata", message: message, preferredStyle: .alert)
        
        // Alert'e modern styling (RegisterViewController ile aynı)
        alert.view.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        
        let action = UIAlertAction(title: "Tamam", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getMoviesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell,
              let movie = presenter?.getMovie(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: movie)
        
        // Cell'e glassmorphism efekti ekle
        cell.backgroundColor = UIColor(white: 1.0, alpha: 0.05)
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        
        // Modern shadow
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 4)
        cell.layer.shadowRadius = 12
        cell.layer.shadowOpacity = 0.2
        
       
        if let titleLabel = cell.subviews.first(where: { $0 is UILabel }) as? UILabel {
            titleLabel.textColor = .white
            titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
            titleLabel.shadowColor = UIColor.black.withAlphaComponent(0.3)
            titleLabel.shadowOffset = CGSize(width: 0, height: 1)
        }
        
        // Eğer cell içinde rating label varsa onu da düzelt
        for subview in cell.subviews {
            if let label = subview as? UILabel, label != cell.subviews.first(where: { $0 is UILabel }) {
                label.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0) // Altın rengi rating için
                label.font = .systemFont(ofSize: 12, weight: .medium)
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Selection animation
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    cell.transform = .identity
                }
            }
        }
        
        presenter?.didSelectMovie(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Cell görünüm animasyonu
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.item % 4), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Ekran genişliğine göre hücre boyutunu hesapla
        let padding: CGFloat = 40 // Sol ve sağ kenar boşluğu (20+20)
        let itemSpacing: CGFloat = 10 // İki hücre arası boşluk
        let width = (view.bounds.width - padding - itemSpacing) / 2
        let height = width * 1.6 // Afişin en-boy oranına göre yükseklik (biraz daha uzun)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Kenar boşluklarını belirleme
        return UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
    }
}
