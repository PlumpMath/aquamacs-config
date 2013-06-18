(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-autoface-mode nil)
 '(aquamacs-customization-version-id 300 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(default-frame-alist
    (quote
     ((tool-bar-lines . 0)
      (menu-bar-lines . 1)
      (foreground-color . "Black")
      (background-color . "White")
      (cursor-type . box)
      (cursor-color . "Red")
      (vertical-scroll-bars . right)
      (internal-border-width . 0)
      (left-fringe . 1)
      (right-fringe)
      (fringe))))
 '(global-hl-line-mode t)
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(tabbar-mode nil nil (tabbar))
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "apple" :family "Consolas"))))
 '(echo-area ((t (:stipple nil :strike-through nil :underline nil :slant normal :weight normal :width normal :family "Consolas"))))
 '(mode-line ((t (:inherit aquamacs-fixed-width :background "light blue" :foreground "black" :box (:line-width -1 :style released-button) :strike-through nil :underline nil :slant normal :weight normal :width normal))))
 '(mode-line-flags ((t (:family "Consolas"))))
 '(mode-line-inactive ((t (:inherit aquamacs-fixed-width :background "grey90" :foreground "grey20" :box (:line-width -1 :color "grey75") :strike-through nil :underline nil :slant normal :weight normal :width normal)))))
