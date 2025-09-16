//
//  DetailViewController.swift
//  CineAI
//
//  Created by MB-BTMC001 on 29.08.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    
    // Modern tasarım elemanları
    let backgroundView = UIView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let overView = UILabel()
    
    private let recommendationButton = UIButton(type: .system)
    private let recommendationLabel = UILabel()
    private let activity = UIActivityIndicatorView(style: .large)
    
    // Modern container views
    private let posterContainerView = UIView()
    private let contentContainerView = UIView()
    private let recommendationContainerView = UIView()
    
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
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1.0)
        
        // Modern gradient background (MainViewController ile aynı)
        setupGradientBackground()
        
        // Navigation bar styling
        setupNavigationBar()
        
        // Container setup
        setupContainers()
        
        // Activity indicator
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        let contentStackView = UIStackView(arrangedSubviews: [
            posterContainerView,
            contentContainerView,
            recommendationContainerView
        ])
        contentStackView.axis = .vertical
        contentStackView.spacing = 25
        contentStackView.alignment = .fill
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        view.addSubview(activity)
        
        // Constraints
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content Stack
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40),
            
            // Activity indicator
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Container heights
            posterContainerView.heightAnchor.constraint(equalToConstant: 400),
            contentContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            recommendationContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
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
        
        // Back button'ı özelleştir
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        // Çıkış animasyonu ile geri dön
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0.8
            self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupContainers() {
        // Poster Container
        setupPosterContainer()
        
        // Content Container
        setupContentContainer()
        
        // Recommendation Container
        setupRecommendationContainer()
    }
    
    func setupPosterContainer() {
        posterContainerView.translatesAutoresizingMaskIntoConstraints = false
        posterContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.05)
        posterContainerView.layer.cornerRadius = 20
        posterContainerView.layer.borderWidth = 1
        posterContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        
        // Glassmorphism effect
        posterContainerView.layer.shadowColor = UIColor.black.cgColor
        posterContainerView.layer.shadowOffset = CGSize(width: 0, height: 8)
        posterContainerView.layer.shadowRadius = 20
        posterContainerView.layer.shadowOpacity = 0.3
        
        // Poster image setup
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 15
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        posterContainerView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: posterContainerView.topAnchor, constant: 15),
            posterImageView.leadingAnchor.constraint(equalTo: posterContainerView.leadingAnchor, constant: 15),
            posterImageView.trailingAnchor.constraint(equalTo: posterContainerView.trailingAnchor, constant: -15),
            posterImageView.bottomAnchor.constraint(equalTo: posterContainerView.bottomAnchor, constant: -15)
        ])
    }
    
    func setupContentContainer() {
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
        contentContainerView.layer.cornerRadius = 20
        contentContainerView.layer.borderWidth = 1
        contentContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.15).cgColor
        
        // Glassmorphism effect
        contentContainerView.layer.shadowColor = UIColor.black.cgColor
        contentContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentContainerView.layer.shadowRadius = 15
        contentContainerView.layer.shadowOpacity = 0.2
        
        // Title styling
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Overview styling
        overView.font = .systemFont(ofSize: 16, weight: .regular)
        overView.numberOfLines = 0
        overView.textColor = UIColor(white: 0.9, alpha: 1.0)
        overView.translatesAutoresizingMaskIntoConstraints = false
        overView.lineBreakMode = .byWordWrapping
        
        let contentStack = UIStackView(arrangedSubviews: [titleLabel, overView])
        contentStack.axis = .vertical
        contentStack.spacing = 15
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentContainerView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupRecommendationContainer() {
        recommendationContainerView.translatesAutoresizingMaskIntoConstraints = false
        recommendationContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.06)
        recommendationContainerView.layer.cornerRadius = 20
        recommendationContainerView.layer.borderWidth = 1
        recommendationContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.12).cgColor
        
        // Glassmorphism effect
        recommendationContainerView.layer.shadowColor = UIColor.black.cgColor
        recommendationContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        recommendationContainerView.layer.shadowRadius = 12
        recommendationContainerView.layer.shadowOpacity = 0.15
        
        // Button styling
        recommendationButton.setTitle("🎬 Benzer Film Önerileri Al", for: .normal)
        recommendationButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        recommendationButton.setTitleColor(.white, for: .normal)
        recommendationButton.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.9)
        recommendationButton.layer.cornerRadius = 15
        recommendationButton.layer.shadowColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8).cgColor
        recommendationButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        recommendationButton.layer.shadowRadius = 8
        recommendationButton.layer.shadowOpacity = 0.3
        recommendationButton.translatesAutoresizingMaskIntoConstraints = false
        recommendationButton.addTarget(self, action: #selector(recommendationButtonTapped), for: .touchUpInside)
        
        // Button hover effect
        recommendationButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        recommendationButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        // Recommendation label styling
        recommendationLabel.numberOfLines = 0
        recommendationLabel.font = .systemFont(ofSize: 15, weight: .regular)
        recommendationLabel.textColor = UIColor(white: 0.85, alpha: 1.0)
        recommendationLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendationLabel.lineBreakMode = .byWordWrapping
        
        let recommendationStack = UIStackView(arrangedSubviews: [recommendationButton, recommendationLabel])
        recommendationStack.axis = .vertical
        recommendationStack.spacing = 15
        recommendationStack.alignment = .fill
        recommendationStack.translatesAutoresizingMaskIntoConstraints = false
        
        recommendationContainerView.addSubview(recommendationStack)
        
        NSLayoutConstraint.activate([
            recommendationButton.heightAnchor.constraint(equalToConstant: 50),
            
            recommendationStack.topAnchor.constraint(equalTo: recommendationContainerView.topAnchor, constant: 20),
            recommendationStack.leadingAnchor.constraint(equalTo: recommendationContainerView.leadingAnchor, constant: 20),
            recommendationStack.trailingAnchor.constraint(equalTo: recommendationContainerView.trailingAnchor, constant: -20),
            recommendationStack.bottomAnchor.constraint(equalTo: recommendationContainerView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupAnimations() {
        // Initial animation state
        posterContainerView.transform = CGAffineTransform(translationX: 0, y: -40)
        posterContainerView.alpha = 0
        
        contentContainerView.transform = CGAffineTransform(translationX: -30, y: 0)
        contentContainerView.alpha = 0
        
        recommendationContainerView.transform = CGAffineTransform(translationX: 30, y: 0)
        recommendationContainerView.alpha = 0
    }
    
    func animateEntrance() {
        // Poster animation
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.posterContainerView.alpha = 1
            self.posterContainerView.transform = .identity
        }
        
        // Content animation
        UIView.animate(withDuration: 0.6, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
            self.contentContainerView.alpha = 1
            self.contentContainerView.transform = .identity
        }
        
        // Recommendation animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
            self.recommendationContainerView.alpha = 1
            self.recommendationContainerView.transform = .identity
        }
    }
    
    func updateGradientFrame() {
        if let gradientLayer = backgroundView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = view.bounds
        }
    }
    
    // Button animations
    @objc func buttonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.recommendationButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.recommendationButton.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.7)
        }
    }
    
    @objc func buttonTouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.recommendationButton.transform = .identity
            self.recommendationButton.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.9)
        }
    }
    
    @objc private func recommendationButtonTapped() {
        // Button'a tıklama animasyonu
        UIView.animate(withDuration: 0.2, animations: {
            self.recommendationButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.recommendationButton.transform = .identity
            }
        }
        
        presenter?.getMovieRecommendations()
    }
}

extension DetailViewController: DetailViewProtocol {
    
    func showloading() {
        UIView.animate(withDuration: 0.3) {
            self.activity.startAnimating()
            self.recommendationContainerView.alpha = 0.5
        }
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.3) {
            self.activity.stopAnimating()
            self.recommendationContainerView.alpha = 1.0
        }
    }
    
    func showMovieDetail(movie: Movie) {
        titleLabel.text = movie.title ?? movie.name
        overView.text = movie.overview
        
        if let posterPath = movie.posterPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        
        // Content animation when data loads
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2) {
            self.contentContainerView.transform = .identity
        }
    }
    
    func displayRecommendation(text: String) {
        recommendationLabel.text = text
        
        // Recommendation animation
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3) {
            self.recommendationLabel.alpha = 1
            self.recommendationLabel.transform = .identity
        }
    }
}
