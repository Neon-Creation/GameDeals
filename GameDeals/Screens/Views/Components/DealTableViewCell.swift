import UIKit

final class DealTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DealTableViewCell"

    private var imageTask: Task<Void, Never>?
    private var dealView: GameBoxContainer?

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        dealView?.setGameImage(UIImage(systemName: "gamecontroller"))
    }

    func configure(with deal: SteamDeal) {
        imageTask?.cancel()
        dealView?.removeFromSuperview()

        let gameView = GameBoxContainer(
            gameImage: UIImage(systemName: "gamecontroller") ?? UIImage(),
            gameName: deal.name,
            offPercentage: deal.discountPercent,
            shopName: "Steam",
            currentGamePrice: deal.formattedPrice
        )
        dealView = gameView
        contentView.addSubview(gameView)
        gameView.translatesAutoresizingMaskIntoConstraints = false
        gameView.fillSuperView()

        guard let imageURL = deal.headerImage else {
            return
        }

        imageTask = Task { [weak gameView] in
            do {
                let (data, response) = try await URLSession.shared.data(from: imageURL)
                guard
                    let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode),
                    let image = UIImage(data: data)
                else {
                    gameView?.setGameImage(UIImage(systemName: "photo"))
                    return
                }

                guard !Task.isCancelled else { return }
                gameView?.setGameImage(image)
            } catch is CancellationError {
                return
            } catch {
                guard !Task.isCancelled else { return }
                gameView?.setGameImage(UIImage(systemName: "photo"))
            }
        }
    }
}
