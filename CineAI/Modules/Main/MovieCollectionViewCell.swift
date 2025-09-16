//
//  MovieCollectionViewCell.swift
//  CineAI
//
//  Created by MB-BTMC001 on 28.08.2025.
//

import Foundation
import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Modern görünüm için shadow
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOpacity = 0.3
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white // Burada beyaz yaptık!
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        // Text shadow ekleme (gradient arka planda daha iyi görünmesi için)
        label.shadowColor = UIColor.black.withAlphaComponent(0.6)
        label.shadowOffset = CGSize(width: 0, height: 1)
        
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0) // Altın rengi
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        
        // Rating için de shadow
        label.shadowColor = UIColor.black.withAlphaComponent(0.4)
        label.shadowOffset = CGSize(width: 0, height: 1)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Modern cell styling
        backgroundColor = UIColor(white: 1.0, alpha: 0.05)
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        
        // Glassmorphism shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.2
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Image view - üst kısımda
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            // Title label - image'ın altında
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            // Rating label - en altta
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with movie: Movie) {
        // Film başlığını ayarla
        titleLabel.text = movie.title ?? movie.name
        
        // Rating bilgisini ayarla (eğer var ise)
        if let voteAverage = movie.voteAverage, voteAverage > 0 {
            ratingLabel.text = "⭐ \(String(format: "%.1f", voteAverage))"
        } else {
            ratingLabel.text = ""
        }
        
        // Poster resmi yükle
        if let posterPath = movie.posterPath {
            let posterUrlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            
            if let url = URL(string: posterUrlString) {
                // Placeholder image ile loading
                imageView.kf.setImage(with: url,placeholder: createPlaceholderImage(),options: [.transition (.fade(0.3)),.cacheOriginalImage])
            } else {
                imageView.image = createPlaceholderImage()
            }
        } else {
            imageView.image = createPlaceholderImage()
        }
        // Configure sonrası renkleri zorla ayarla (garantiye almak için)
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.textColor = .white
            self?.ratingLabel.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        }
    }
    private func createPlaceholderImage() -> UIImage? {
        // Gradient placeholder oluştur
        let size = CGSize(width: 200, height: 300)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colors = [
            UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 1.0).cgColor,
            UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0).cgColor
        ]
        
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: nil)
        context?.drawLinearGradient(gradient!, start: CGPoint.zero, end: CGPoint(x: size.width, y: size.height), options: [])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
        
        // Renkleri tekrar ayarla
        titleLabel.textColor = .white
        ratingLabel.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
    }
}
