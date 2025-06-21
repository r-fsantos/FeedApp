//
//  BookCollectionViewCell.swift
//  FeedApp
//
//  Created by Renato F. dos Santos Jr on 21/06/25.
//

import UIKit

// MARK: - BookCollectionViewCell
// Custom UICollectionViewCell to display a book cover and title.
final class BookCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "BookCollectionViewCell" // Unique identifier for cell reuse

    // MARK: - UI Elements
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit // Scale the image to fit without stretching
        iv.clipsToBounds = true // Clip content to the bounds of the image view
        iv.layer.cornerRadius = 8 // Rounded corners for book covers
        iv.layer.masksToBounds = true // Apply corner radius to the image content
        iv.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold) // Bold title
        label.textAlignment = .center // Center align the title
        label.numberOfLines = 2 // Allow title to wrap to two lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular) // Smaller font for author
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .secondaryLabel // Less prominent color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout() // Set up constraints for the cell's subviews
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Setup
    private func setupCellLayout() {
        contentView.addSubview(imageView)
        //        contentView.addSubview(titleLabel)
        //        contentView.addSubview(authorLabel)

        // Constraints for the image view
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5) // Approximate book aspect ratio (3:2)
        ])

        // Constraints for the title label
        //        NSLayoutConstraint.activate([
        //            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
        //            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
        //            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        //        ])
        //
        //        // Constraints for the author label
        //        NSLayoutConstraint.activate([
        //            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
        //            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
        //            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        //            authorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8) // Ensure some padding at the bottom
        //        ])
    }

    // MARK: - Configure Cell
    func configure(with book: Book) {
        imageView.image = UIImage(named: book.imageName) // Load image from asset catalog
        titleLabel.text = book.title
        authorLabel.text = book.author
    }

    // MARK: - Reuse Preparation
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil // Clear image to prevent display of old content
        titleLabel.text = nil
        authorLabel.text = nil
    }
}
