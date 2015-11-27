import UIKit

class RootViewModel {
    
    static let loadingLabel = "Loading..."
    
    var model: RootModel? {
        didSet {
            loading = false
            
            guard model != oldValue else { return }
            
            title = model?.title ?? ""
            items = model?.items.flatMap{ RootViewModelItem.init(model: $0) } ?? []
            update?()
        }
    }
    var title = RootViewModel.loadingLabel
    var items = [RootViewModelItem]()
    var update: (() -> Void)?
    var loading = true
    
    init(title: String, items: [RootViewModelItem]) {
        self.items = items
    }
    
    init(items: [RootViewModelItem]) {
        self.items = items
    }
    
    func getDetail(id: Int) -> DetailViewModel? {
        return DetailViewModel.get(id)
    }
    
    static func get() -> RootViewModel {
        let viewModel = RootViewModel(title: "", items: [])
        RootModel.get() { model in
            viewModel.model = model
        }
        return viewModel
    }
}