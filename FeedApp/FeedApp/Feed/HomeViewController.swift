//
//  HomeViewController.swift
//  FeedApp
//
//  Created by Renato F. dos Santos Jr on 20/06/25.
//

import UIKit
import SwiftUI

// MARK: - HomeViewController
// This view controller manages the main book collection display.
class HomeViewController: UIViewController {

    // MARK: - UI Elements
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView! // Changed from UITableView to UICollectionView

    // MARK: - Data Properties
    private var allBooks: [Book] = Book.sampleBooks // All available books
    private var filteredBooks: [Book] = [] // Books currently displayed after filtering/searching
    private var currentSearchText: String = ""
    private var appliedGenreFilter: String? // Example: keep track of one genre filter

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView() // Call the new setup method for collection view
        filterBooks() // Initial filtering/display
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground // Set background color for the view
        navigationController?.navigationBar.prefersLargeTitles = true // Set title for large
        title = "Library" // Set the title for the navigation bar
    }

    private func setupNavigationBar() {
        // Embed the search bar directly in the navigation item
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search books..."
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .label // Ensures the cursor and cancel button are visible in both light/dark mode
        searchBar.showsCancelButton = true // Enable the cancel button for search bar

        // Add a filter button to the right of the navigation bar
        let filterButton = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3.decrease.circle"), // SF Symbol for filter
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped)
        )
        navigationItem.rightBarButtonItem = filterButton
    }

    private func setupSearchBar() {
        // Constraints are handled when it's set as titleView, no need for explicit here unless adding custom behavior.
    }

    private func setupCollectionView() {
        // Create a flow layout for the collection view
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical // Vertically scrolling grid
        layout.minimumInteritemSpacing = 8 // Horizontal spacing between items
        layout.minimumLineSpacing = 16 // Vertical spacing between lines

        // Initialize the collection view with the layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear // Make collection view background transparent
        collectionView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout

        // Register the custom cell
        collectionView.register(BookCollectionViewCell.self,
                                forCellWithReuseIdentifier: BookCollectionViewCell.reuseIdentifier)

        view.addSubview(collectionView) // Add the collection view to the main view

        // Setup constraints for the collection view to fill the safe area
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Filtering and Searching Logic
    private func filterBooks() {
        filteredBooks = allBooks.filter { book in
            // Apply search text filter (case-insensitive)
            let matchesSearch = currentSearchText.isEmpty ||
            book.title.localizedCaseInsensitiveContains(currentSearchText) ||
            book.author.localizedCaseInsensitiveContains(currentSearchText) ||
            book.genre.localizedCaseInsensitiveContains(currentSearchText)

            // Apply genre filter if set
            let matchesGenre = appliedGenreFilter == nil || book.genre == appliedGenreFilter

            return matchesSearch && matchesGenre
        }
        collectionView.reloadData() // Refresh the collection view to show filtered results
    }

    // MARK: - Actions
    @objc private func filterButtonTapped() {
        let alertController = UIAlertController(
            title: "Filter Books",
            message: "Select a genre to filter by:",
            preferredStyle: .actionSheet
        )

        let uniqueGenres = Set(allBooks.map { $0.genre }).sorted()

        for genre in uniqueGenres {
            alertController.addAction(UIAlertAction(title: genre, style: .default, handler: { _ in
                self.appliedGenreFilter = genre
                self.filterBooks()
            }))
        }

        alertController.addAction(UIAlertAction(title: "Clear Filter", style: .destructive, handler: { _ in
            self.appliedGenreFilter = nil
            self.filterBooks()
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentSearchText = searchText
        filterBooks()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        currentSearchText = ""
        searchBar.resignFirstResponder()
        filterBooks()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? BookCollectionViewCell else {
            fatalError("Unable to dequeue BookCollectionViewCell")
        }

        let book = filteredBooks[indexPath.item]
        cell.configure(with: book) // Configure the custom cell with book data
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = filteredBooks[indexPath.item]
        print("Selected book: \(selectedBook.title)")

        // Example: Show a simple alert with book details
        let alert = UIAlertController(
            title: selectedBook.title,
            message: "Author: \(selectedBook.author)\nGenre: \(selectedBook.genre)\nRating: \(selectedBook.rating)/5",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
// This extension defines the size and spacing of items in the collection view.
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 24 // Total padding for both sides (16 leading + 8 item spacing + 16 trailing = 40)
        let minimumItemSpacing: CGFloat = 16 // Spacing between items horizontally
        let numberOfColumns: CGFloat = 2 // We want 2 columns

        // Calculate the available width for items
        let availableWidth = collectionView.bounds.width - padding - (minimumItemSpacing * (numberOfColumns - 1))
        let itemWidth = availableWidth / numberOfColumns
        let itemHeight = itemWidth * 1.8 // Adjust multiplier based on desired aspect ratio (e.g., 1.5 for 3:2, 1.8 for slightly taller)

        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Insets for the section (top, left, bottom, right)
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

// MARK: - SwiftUI Preview
// Used to provide a live preview of the HomeViewController in Xcode Canvas.
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        // Embeding HomeViewController in a UINavigationController to correctly display
        // it's navigation bar elements (search bar, filter button).
        ViewControllerPreview {
            UINavigationController(rootViewController: HomeViewController())
        }
        .previewDisplayName("Home Screen")
    }
}

// MARK: - bridging UIKit ViewControllers to SwiftUI Previews.
struct ViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> ViewController

    init(_ builder: @escaping () -> ViewController) {
        self.viewControllerBuilder = builder
    }

    func makeUIViewController(context: Context) -> ViewController {
        viewControllerBuilder()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) { }
}
