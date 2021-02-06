
import UIKit

/// Predefined Layouts for an embedded controller
public enum EmbedLayoutOptions {
    /// Hidden. View of embedded controller is invisible. It can propagate
    /// other view into the parent controller.
    case zero
    /// Fill size of the parent controller.
    case fill
    /// Custom callback. Custom layout and custom setup.
    public typealias Callback = (_ childView: UIView) -> Void
    case custom(Callback)
}

///
/// UIViewController helpers to add and remove child view controllers.
///
public extension UIViewController {
    
    /// Add child view controller with specified layout presets.
    /// - Parameters:
    ///   - viewController: controller to be added as a child controller
    ///   - layout: predefined layout
    func embedController(_ viewController: UIViewController, layout: EmbedLayoutOptions = .fill) {
        embedController(viewController, parentView: self.view, layout: layout)
    }
    
    /// Add child view controller with specified layout presets.
    /// - Parameters:
    ///   - viewController: controller to be added as a child controller
    ///   - parentView: the parent view the viewController's view will be attached to
    ///   - layout: predefined layout
    func embedController(_ viewController: UIViewController, parentView: UIView, layout: EmbedLayoutOptions = .fill) {
        addChild(viewController)
        viewController.willMove(toParent: self)
        setupView(childView: viewController.view, parentView: parentView, layout: layout)
        viewController.didMove(toParent: self)
    }

    /// Remove child view controller from the parent controller.
    /// - Parameters:
    ///   - viewController: child controller to be removed
    func removeEmbeddedController(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func setupView(childView: UIView, parentView: UIView, layout: EmbedLayoutOptions) {
        parentView.addSubview(childView)
        
        switch layout {
        case .zero:
            childView.frame = CGRect.zero
        case .fill:
            childView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        case .custom(let callback):
            callback(childView)
        }
    }
}
