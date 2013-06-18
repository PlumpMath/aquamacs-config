;; #### Aquamacs Preferences file. ####
;; /Users/zand/Library/Preferences/Aquamacs Emacs/Preferences.el
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)
;;
;; Alt     : "A" in keybindings (e.g. (kbd "A-c") sends "Alt c" )
;; Control : "C" in keybindings (e.g. (kbd "C-c") sends "Control-c" aka "^")
;; Meta    : "M" in keybindings (e.g. (kbd "M-c") sends "Meta-c")
;; Super   : "s" in keybindings (e.g. (kbd "s-c") sends "Super-c")
;; Hyper   : "H" in keybindings (e.g. (kbd "H-c") sends "Hyper-c")
;;
;; In Aquamacs by default:
;;
;; Apple Command key is set to "Alt"
;; Alt / Option key is set to "Meta"
;; Control key is set to "Control"
;; Caps Lock key is set to "Caps Lock"
;; Function key is not set to anything (sends fn+fn-key as normal)
;; 
;; Example: to bind the expand-region commands to "Command-D" do:
;; (global-set-key (kbd "A-d") 'er/expand-region)

(require 'cl)
(require 'ido)
(require 'package)
;; Marmalade
;;(add-to-list 'package-archives
;;            '("marmalade" . "http://marmalade-repo.org/packages/") t)

(setq package-user-dir "~/Library/Application Support/Aquamacs Emacs/elpa/")
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; There is a small bug in Emacs24’s package.el such that the dependency
;; order comes out backwards. The problem is patched by some advice:
(defadvice package-compute-transaction
  (before package-compute-transaction-reverse (package-list requirements) activate compile)
    "reverse the requirements"
    (setq requirements (reverse requirements))
    (print requirements))

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(melpa
		      magit
                      clojure-mode
                      clojure-test-mode
                      js2-mode
                      markdown-mode
                      expand-region
                      smex
                      rainbow-delimiters
                      paredit
                      ac-nrepl
                      nrepl
                      auto-complete
                      ac-nrepl
                      nrepl-ritz)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Customize Mode-line to be more obvious which is the active buffer
;;(set-face-foreground 'mode-line "white")
(set-face-background 'mode-line "light blue")
;;(set-face-background 'mode-line-inactive "light blue")

;; ## Custom Functions

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
)
(global-set-key "\C-cn" 'show-file-name)

;; Automatically make isearch wrap
(defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))

;; ## Appearance

;; Default Font
;; To set the default font for all buffers, use emacs 
;; face customization menu: M-x customize-face and type
;; in default. Then place the cursor in the Font Family 
;; input area and type in a new font family name, e.g.
;; apple-bitstream vera sans mono. Click Save for Future
;; Sessions and Finish.

;; Minibuffer font
;; Strangely the developers choose a variable width font 
;; so the echo-area jumps around when typing.
;; Change it by doing Options-> Customize Emacs -> Specific Face ->
;; echo-area = Consolas
;; mode-line = aquamacs-fixed-width (etc.)

;; Theme
;; Supposed to make emacs look like Light Table but it doesn't work quite right
;; (add-to-list 'custom-theme-load-path "~/Library/Application Support/Aquamacs Emacs/Themes")
;; (load-theme 'bubbleberry t)

;; (global-linum-mode t)
(tool-bar-mode 0)
(setq suggest-key-bindings 5)        ; show suggested key binding for 5 seconds
(ido-mode t)
(global-rainbow-delimiters-mode)	
;;(desktop-save-mode 1)
;;(tabbar-mode -1)		     ; no tabbar

;; Save layout and revive desktop on start => Configure in customization group.

;; Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key "\C-x\ f" 'recentf-open-files)

;; ## Keyboard bindings
;; Aquamacs has the Mac Command key set to "Alt" 
;; Example: to bind the expand-region commands to "Command-D" do:
;; (global-set-key (kbd "A-d") 'er/expand-region)

;; Make caps-lock send control key (caps-lock is already set to Command in Mac preferences)
;; (setq mac-command-modifier 'ctrl)

;; Sets the mac function key to "control" in emacs
;; it's easier to hit the fn key than the control key on the mac keyboard
;; Example : (global-set-key (kbd "H-b") 'backward-word) ; H is for hyper
(setq ns-function-modifier 'control)

(unless window-system   ;; in TTY (terminal) mode
   (normal-erase-is-backspace-mode nil)
   (set-face-inverse-video-p 'mode-line-inactive t)
   (define-key osx-key-mode-map "\C-z" 'suspend-emacs))

;; You can change an existing key map using define-key. By passing nil as the function to
;; call the key will become unbound. I guess that you should be able to do something like:
;; Example: (define-key reftex-mode-map "\C-c/" nil)

;; Unset keys that mess things up
(define-key osx-key-mode-map (kbd "C-;") nil)
(define-key osx-key-mode-map (kbd "C-x f") nil)
(define-key osx-key-mode-map (kbd "C-;") nil)   ; originally bound to toggle-mac-option-modifier 

;; Steve Yegge says "it's better to kill the whole word and retype
;; than to painstakingly backspace to your error.
;;(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; Comment Region
(global-set-key (kbd "C-/") 'comment-dwim)

;; Window Movement Commands
(global-set-key (kbd "<S-down>") 'windmove-down)
(global-set-key (kbd "<S-up>") 'windmove-up)
(global-set-key (kbd "<S-left>") 'windmove-left)
(global-set-key (kbd "<S-right>") 'windmove-right)

;; Smex:  M-x interface with Ido-style fuzzy matching.
(smex-initialize)
;; Make it easier to to M-x which is difficult on any keyboard.
(global-set-key (kbd "C-x RET") 'smex)
(global-set-key "\C-x\C-m" 'smex)
(global-set-key (kbd "C-c RET")  'smex)
;;(global-set-key "\C-x\C-m" 'execute-extended-command)
;;(global-set-key "\C-c\C-m" 'execute-extended-command)

;; Ace-Jump Mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-word-mode)
(define-key global-map (kbd "C-c C-u SPC") 'ace-jump-char-mode)
(define-key global-map (kbd "C-c C-u C-u SPC") 'ace-jump-line-mode) 

;; ;; Helm 
;; (global-set-key (kbd "C-c h") 'helm-mini)

;; Hippie Expand
(global-set-key (kbd "A-/") 'hippie-expand)
;;(global-set-key (kbd "C-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill
                           try-complete-file-name-partially try-complete-file-name
                           try-expand-all-abbrevs try-expand-list try-expand-line
                           try-complete-lisp-symbol-partially try-complete-lisp-symbol))

;; ;; Clojure Mode stuff
(require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode 1)

;; clojure-mode doesn't indent by default out of the box. 
(add-hook 'clojure-mode-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))

;; Paredit adds a space after the # char which breaks anon funs
;; Tells paredit not to put a space after a #
;; http://stackoverflow.com/questions/11135315/prevent-paredit-from-inserting-a-space-when-inserting-parentheses-and-other-is
(defun paredit-space-for-delimiter-predicates-clojure (endp delimiter)
  "Do not automatically insert a space when a '#' precedes parentheses."
  (or endp
      (cond ((eq (char-syntax delimiter) ?\()
             (not (looking-back "#\\|#hash")))
            (else t))))

(defun clojure-mode-paredit-hook ()
  (enable-paredit-mode)
  (add-to-list (make-local-variable 'paredit-space-for-delimiter-predicates)
               'paredit-space-for-delimiter-predicates-clojure))

(add-hook 'clojure-mode-hook 'clojure-mode-paredit-hook)

;; (add-hook 'clojure-mode-hook '(lambda ()
;;       (local-set-key (kbd "RET") 'paredit-newline)))

;; Paredit-mode
(add-hook 'clojure-mode-hook 'paredit-mode)
;;(add-hook 'nrepl-mode-hook 'paredit-mode)
(global-set-key [f7] 'paredit-mode)
;;(require 'paredit-menu)
;; (eval-after-load "paredit.el"
;;     '(require 'paredit-menu))

;; nrepl
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces nil)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")

(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
;; Opens nrepl in the same window :
;;(add-to-list 'same-window-buffer-names "*nrepl*")
;;(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'clojure-mode-paredit-hook)
;;(add-hook 'nrepl-mode-hook 'subword-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
(global-set-key [f9] 'nrepl-jack-in)

;; Auto complete
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop) ; use M-/ to stop completion

;; ac-nrepl : Auto-complete for nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))

;; nrepl inspect
;;(load-file "/Users/zand/Library/nrepl-inspect.el")
(load-file "/Users/zand/Library/Application Support/Aquamacs Emacs/nrepl-inspect.el")
(require 'nrepl-inspect)
(define-key nrepl-mode-map (kbd "C-c C-i") 'nrepl-inspect)

;; Note: nRepl inspect also requires the following config in ~/.lein/profiles.clj
;;{:user {:dependencies [[nrepl-inspect "0.3.0-SNAPSHOT"]]
;;        :repl-options {:nrepl-middleware
;;                      [inspector.middleware/wrap-inspect]}}}

;; nrepl-ritz (debugging)
(require 'nrepl-ritz) ;; after (require 'nrepl)
 
;; Ritz middleware
(define-key nrepl-interaction-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-interaction-mode-map (kbd "C-c C-a") 'nrepl-apropos)
(define-key nrepl-mode-map (kbd "C-c C-a") 'nrepl-apropos)

;; ## Other, non-Clojure stuff

;; Expand Region
(require 'expand-region)
(global-set-key (kbd "A-d") 'er/expand-region)

;; Multiple Cursors
;;(require 'multiple-cursors)
;;(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;(global-set-key (kbd "C->") 'mc/mark-next-like-this)
;;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Js2-mode for javascript editing 
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; Markdown Mode
(autoload 'markdown-mode "markdown-mode"
       "Major mode for editing Markdown files" t)
    (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

