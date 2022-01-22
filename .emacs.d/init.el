;; Clean-up the user interface
;; No start-up screen with Emacs logo
(setq inhibit-startup-screen t)

;; Disable the visible scrollbar
(scroll-bar-mode -1) 

;; Disable the toolbar
(tool-bar-mode -1)

;; Disable tool tips
(tooltip-mode -1)

;; Disable menu-bar-mode
(menu-bar-mode -1)

;; Set visual bell (like when you reach the end of the buffer)
(setq visible-bell t) ; not sure if the sound is not better

;; Set the windon fringe size
(set-fringe-mode 10)

;; Use spaces, not tabs, for indentation.
(setq-default indent-tabs-mode nil)

;; Fontsize
;;(set-face-attribute 'default nil :font "Fira Code Retina" :height 200)

;; Default theme initially used by System Crafters
;; (load-theme 'wombat)

;; This brings to the environment all the package manager functions
(require 'package)

;; Package-archives is a variable holding an alist with sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initializes the package system and prepares it to be used
(package-initialize)

;; Unless the package archive exists, update the package list
;; This is useful on the very first load
(unless package-archive-contents
  (package-refresh-contents))

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

;; Try to install use-package, in case it is not already install
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; At this point, use-package must be available, and it will be used
;; use-package is a command to install packages
(require 'use-package)

;; Guarantees the download of packages before they are run
;; Useful when running config file from the very first time
(setq use-package-always-ensure t)

;; Package to show keybindings being used
(use-package command-log-mode)

;; Using Ivy from System Crafters
(use-package ivy
  :diminish ;keeps ivy out of the mode line
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ;("TAB" . ivy-alt-done)    
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  '((ivy-mode 1)
    (ivy--regex-fuzzy 1x)))

;; Change mode-line to be more modern, like SpaceMacs
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Use the same theme as System Crafters
;; This brings themes available in Doom Emacs
(use-package doom-themes
   :init (load-theme 'doom-palenight t))

;; There will be no question about confirming load theme
;; (setq sml/no-confirm-load-theme t)

;; Requisite to have cool icons on the doom-mode line
(use-package all-the-icons
  :if (display-graphic-p))

;; Display column numbers
(column-number-mode)

;; Display line numbers
;; This is better than old linum-mode
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Highlights parens, brackets, and braces according to their depth
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Configure Rainbow Delimiters
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
(add-hook 'slime-repl-mode-hook 'rainbow-delimiters-mode)

;; A package that displays available keybindings in popup 
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; Showing me the details of all the commands
;; M=x is way more powerful now
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Make the last used command be the first-one
(use-package ivy-prescient
  :init
  (ivy-prescient-mode 1))

;; Counsel is already installed
;; But, I can use use-package to customize it
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Augmentation of Emacs help system
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;;  More convenient key definitions in emacs 
(use-package general)

(general-define-key
  "C-x C-b" 'counsel-switch-buffer)

;; Magit configuration
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Helm for the win
;;(global-set-key (kbd "M-x") 'helm-M-x)
;; (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x


;; Inserting wakatime in emacs
(global-wakatime-mode)
(setq wakatime-api-key "37bc2977-bd5e-4794-983d-c88624ec6b32")

;; Snippet of text before starting Nyxt
(defun nyxt-quickload-gi-gtk ()
  "Insert snippet to load Nyxt."
  (interactive)
  (insert "(ql:quickload :nyxt/gi-gtk)")
  (backward-word 2))
(global-set-key (kbd "C-x C-M-n") 'nyxt-quickload-gi-gtk)

;; Another snippet of text before starting Nyxt
(defun nyxt-start-package ()
  "Insert snippet to load Nyxt."
  (interactive)
  (insert "(nyxt:start)")
  (backward-word 2))
(global-set-key (kbd "C-x C-M-s") 'nyxt-start-package)

;; Paredit Hooks 
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode) ;isso é para CL
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode) ;ativado via M-x
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode) ;ativar o paredit no slime    

;; Paredit Keybinding configuration
(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C->") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "C-<") 'paredit-forward-barf-sexp)
     (define-key paredit-mode-map (kbd "C-M-<") 'paredit-backward-slurp-sexp)
     (define-key paredit-mode-map (kbd "C-M->") 'paredit-backward-barf-sexp)
     (define-key paredit-mode-map (kbd "<C-right>") nil)
     (define-key paredit-mode-map (kbd "<C-left>") nil)))

;; Keybindings
;;;; Jump to bookmarks
(global-set-key (kbd "C-x C-M-b") 'bookmark-jump)
;;;; Refresh the current buffer
(global-set-key (kbd "C-x C-M-r") 'revert-buffer)
;;;; Keybinding change Dabrev Expansion
(global-set-key (kbd "M-]") 'dabbrev-expand)

;; Make paste-and-replace work
(delete-selection-mode 1)

;; Show parens  
(show-paren-mode t)

;; Show parens immediatly
(setq show-paren-delay 0)

;; Show whole parens expression as highlighted
(setq show-paren-style 'expression) ;; highlight whole expression

;; Launch emacs as full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Emacs minor mode to wrap region with tag or punctuations 
(wrap-region-mode t)
(wrap-region-add-wrapper "*" "*")
(wrap-region-add-wrapper "/" "/")

;; Increase the font size
(set-face-attribute 'default nil :height 130)

;; Enabling IDO
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

;; Flyspell
(add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell)

;; Mouse hacking -> enforce a keyboard driven experience
;; (require 'disable-mouse)
;; (global-disable-mouse-mode)
(mouse-wheel-mode 0)

(slime-setup '(slime-fancy slime-asdf slime-indentation slime-sbcl-exts slime-scratch))

(setq slime-lisp-implementations
      '((sbcl ("/home/pedro/projects/nyxt.sh" ""))))

;; System Crafters does not use =custom-set-variables= or =custom-set-faces=
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(column-number-mode t)
;;  '(custom-safe-themes
;;    '("7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" default))
;;  '(global-command-log-mode t)
;;  '(package-selected-packages
;;    '(helpful counsel all-the-icons-ivy-rich ivy-rich dracula-theme which-key rainbow-delimiters doom-modeline command-log-mode slime use-package))
;;  '(tooltip-mode nil))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("47db50ff66e35d3a440485357fb6acb767c100e135ccdf459060407f8baea7b2" default))
 '(package-selected-packages
   '(keycast wakatime-mode ivy-prescient prescient wrap-region transpose-frame magit paredit general which-key use-package slime rainbow-delimiters popup helpful helm-core dracula-theme doom-themes doom-modeline counsel command-log-mode all-the-icons-ivy-rich))
 '(safe-local-variable-values
   '((eval cl-flet
           ((enhance-imenu-lisp
             (&rest keywords)
             (dolist
                 (keyword keywords)
               (add-to-list 'lisp-imenu-generic-expression
                            (list
                             (purecopy
                              (concat
                               (capitalize keyword)
                               (if
                                   (string=
                                    (substring-no-properties keyword -1)
                                    "s")
                                   "es" "s")))
                             (purecopy
                              (concat "^\\s-*("
                                      (regexp-opt
                                       (list
                                        (concat "define-" keyword))
                                       t)
                                      "\\s-+\\(" lisp-mode-symbol-regexp "\\)"))
                             2)))))
           (enhance-imenu-lisp "bookmarklet-command" "class" "command" "ffi-method" "function" "mode" "parenscript" "user-class")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
