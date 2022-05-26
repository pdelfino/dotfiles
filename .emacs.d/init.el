;; Clean-up the user interface.
;; No start-up screen with Emacs logo.
(setq inhibit-startup-screen t)

;; Disable the visible scrollbar.
(scroll-bar-mode -1) 

;; Disable the toolbar.
(tool-bar-mode -1)

;; Disable tool tips.
(tooltip-mode -1)

;; Disable menu-bar-mode.
(menu-bar-mode -1)

;; Set visual bell (like when you reach the end of the buffer).
(setq visible-bell t) ; not sure if the sound would be actually better.

;; Set the windon fringe size.
(set-fringe-mode 10)

;; Use spaces, not tabs, for indentation.
(setq-default indent-tabs-mode nil)

;; Fontsize.
;;(set-face-attribute 'default nil :font "Fira Code Retina" :height 200)

;; Default theme initially used by System Crafters.
;; (load-theme 'wombat)

;; This brings to the environment all the package manager functions.
(require 'package)

;; Package-archives is a variable holding an alist with sources where
;; you can pull packages from!
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initializes the package system and prepares it to be used.
(package-initialize)

;; Unless the package archive exists, update the package list.
;; This is useful on the very first load.
(unless package-archive-contents
  (package-refresh-contents))

;; In case it is not already installed, install use-package.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; At this point, use-package must be available, and it will be used
;; use-package is a command to install packages just
;; do `(use-packge package-name)'.
(require 'use-package)

;; Guarantees the download of packages before they are run. Useful
;; when running config file from the very first time.
(setq use-package-always-ensure t)

;; Display column numbers.
(column-number-mode)

;; Display line numbers.
;; This is better than old `linum-mode'.
;;(global-display-line-numbers-mode t) ;;Mode line gives a lot of info, no need for this anymore.

;; Disable line numbers for some modes.
;; A hook is a variable that holds a list of functions. This
(dolist (mode '(org-mode-hook
                term-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Package to show keybindings being used.
(use-package command-log-mode)

;; Using Ivy from System Crafters.
(use-package ivy
  :diminish ;; keeps ivy out of the mode line.
  :bind (("C-s" . swiper) ;; this is a cool way to do key binding.
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

;; Requisite to have cool icons on the doom-mode line.  The first time
;; this configuration is loaded on a new machine, it is necessary to
;; run `M-x' `all-the-icons-install-font-sizes'.
(use-package all-the-icons
  :if (display-graphic-p))

;; Change `mode-line' to be more modern, like SpaceMacs Since System
;; Crafters thinks the height is too high, it is possible to customize
;; it tweaking the variable value using `:custom'.
(use-package doom-modeline
  :ensure t;; there is no need for `:ensure' due to use-package-always-ensure
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; There will be no question about confirming load theme
(setq sml/no-confirm-load-theme t)

;; Use the same theme as System Crafters. This package brings themes
;; available in Doom Emacs.
(use-package doom-themes
  :init (load-theme 'doom-palenight t))

;; Highlights parens, brackets, and braces according to their depth.
;; Hook keyword is being used with `:hook'.
(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)
         (emacs-lisp-mode . rainbow-delimiters-mode)
         (ielm-mode . rainbow-delimiters-mode)
         (lisp-mode . rainbow-delimiters-mode)
         (lisp-interaction-mode . rainbow-delimiters-mode)
         (slime-repl-mode . rainbow-delimiters-mode)
         (clojure-repl-mode . rainbow-delimiters-mode)))

;; A package that displays available keybindings in popup.  Read the
;; whole prompt buffer. In the bottom, there is relevant information
;; such as pressing `C-h' for moving around the pagination.
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 5))

;; An addition to the ivy interface showing me the details of all the
;; commands.  `M-x' is way more powerful now, showing the
;; documentation string and the keybinding.
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Counsel is already installed.  But, I can use use-package to
;; customize it. `counsel-load-theme' allows me to change the theme
;; with emacs runnig.
(use-package counsel
  :bind (("M-x" . counsel-M-x) ;; `M-o' in a list provides extra actions!
         ("C-x C-b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; An augmentation of Emacs help system. `:bind' does a remapping of a
;; key that is binding to function to trigger another function. This
;; is good if you already like a keybinding in Emacs.
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;;  More convenient key definitions in Emacs.
(use-package general)

(general-define-key
  "C-x b" 'counsel-switch-buffer)

;; Insert hydra, not sure if it is going to be helpful...  Seems to be
;; useful with commands that are executed multiple times in a row
(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "Scale text."
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(defhydra window-scale (:timeout 4)
  "Enlarge or shrink window size."
  ("j" enlarge-window "enlarge")
  ("k" shrink-window "out")
  ("f" nil "finished" :exit t))
(global-set-key (kbd "C-x C-M-w") 'window-scale/body)

;; Projectile helps to navigate on different projects, it is a project
;; interaction library.
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap ;; "C-c p" as prefix key for all projectile commands.
  ("C-c p" . projectile-command-map)
  :init
  ;; Some things on quicklisp/local-projects directory too...
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects")))
  (setq projectile-switch-project-action #'projectile-dired))

;; After doing `C-c p p' (projectile-switch-project), press `M-o', and
;; see the mutliple actions will be listed. This is coming from
;; counsel-projectile. The killer feature is:
;; counsel-projectile-ripgrep which is bounded to `C-c p s r'.
(use-package counsel-projectile
  :config (counsel-projectile-mode)) ;;

;; Magit configuration
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :hook ((git-commit-setup . git-commit-turn-on-flyspell)))

;; Forge makes it easy to pull down information form GitHub
;; repositories - for instance, Pull Requests. It is necessary to some
;; working on authentication.
;;(use-package forge)

;; Org-mode is built-in to Emacs. But, if you install it with
;; `use-package', then it is going to be the last version.  Use
;; `describe-variable'to check `org-version'.
(use-package org
  :config
  (setq org-ellipsis " ▾"));; instead of having `...' there is `▾'.

;; change the size of font size
;; Set faces for heading levels
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

;; customize *** in org-mode
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Auxiliary function to make visual-fill-column work
(defun pmd/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

;; Package to put text from org-files right in the middle of the
;; screen.
(use-package visual-fill-column
  :hook (org-mode . pmd/org-mode-visual-fill))

;; improving *terminal* buffer experience
(use-package term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

;; this seems to create a faster *terminal*
(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

;; trying to improve eshell with xterm-color
;; (use-package xterm-color)

;; (require 'eshell) ; or use with-eval-after-load

;; (add-hook 'eshell-before-prompt-hook
;;           (lambda ()
;;             (setq xterm-color-preserve-properties t)))

;; (add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
;; (setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))
;; (setenv "TERM" "xterm-256color")

(defun pmd/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt)

(use-package eshell
  :hook (eshell-first-time-mode . pmd/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

;; Create a keybinding using Super-e to invoke eshell
(global-set-key [(super return)] 'eshell)

;; Inserting wakatime in emacs
(global-wakatime-mode)
(setq wakatime-api-key "37bc2977-bd5e-4794-983d-c88624ec6b32")

;; Testing this to see if it helps with my problems when opening slime buffer
;; (use-package golden-ratio
;;   :init
;;   (golden-ratio-mode 1))

;; Make the last used command be the first-one.
;; Added by me. Not mentioned on System Crafters.
(use-package ivy-prescient
  :init
  (ivy-prescient-mode 1))

;; Function to create an org-clock command to sum an especific region
(defun pmd/org-clock-sum-current-region (beg end)
  "Sum the total amount of time in the marked region."
  (interactive "r")
  (let ((s (buffer-substring-no-properties beg end)))
    (with-temp-buffer
      (insert "* foo\n")
      (insert s)
      (org-clock-sum)
      (message (format "%d" org-clock-file-total-minutes)))))

;; Snippet of text before starting Nyxt
(defun pmd/nyxt-quickload-gi-gtk ()
  "Insert snippet to load Nyxt."
  (interactive)
  (insert "(ql:quickload :nyxt/gi-gtk)")
  (backward-word 2))
(global-set-key (kbd "C-x C-M-n") 'pmd/nyxt-quickload-gi-gtk)

;; Snippet of text before starting Nyxt
(defun pmd/hermes-quickload ()
  "Insert snippet to load Hermes."
  (interactive)
  (insert "(ql:quickload :hermes)")
  (backward-word 2))
(global-set-key (kbd "C-x C-M-q") 'pmd/hermes-quickload)

;; Another snippet of text before starting Nyxt
(defun pmd/nyxt-inside-package ()
  "Insert snippet to enter the nyxt package."
  (interactive)
  (insert "(in-package :nyxt)")
  (backward-word 2))
(global-set-key (kbd "C-x C-M-p") 'pmd/nyxt-inside-package)

;; Another snippet of text before starting Hermes
(defun pmd/hermes-inside-package ()
  "Insert snippet to enter the nyxt package."
  (interactive)
  (insert "(in-package :hermes)")
  (backward-word 2))
(global-set-key (kbd "C-x C-M-h") 'pmd/hermes-inside-package)

;; Another snippet of text before starting Nyxt
(defun pmd/nyxt-start-package ()
  "Insert snippet to start Nyxt."
  (interactive)
  (insert "(start)")
  (backward-word 2))
(global-set-key (kbd "C-x C-M-s") 'pmd/nyxt-start-package)

;; Another snippet of text before starting Nyxt
(defun pmd/slime-repl-back-CL-USER-package ()
  "Insert snippet to get back to the CL-USER package."
  (interactive)
  (insert "(cl:in-package :cl-user)")
  (backward-word 2))

;; Trying to install a rest-client
(use-package restclient
  :ensure t
  :mode (("\\.http\\'" . restclient-mode)))

;; Trying to install org-drill
(use-package org-drill
  :ensure t)

;; Trying to install clojure-mode
(use-package clojure-mode
  :ensure t)

;; Trying to install cider to start a REPL directly in Clojure
(use-package cider
  :ensure t)

;; Trying to properly export org-mode to markdown
(use-package ox-gfm
  :ensure t)

;; Trying to install browse-kill-ring
;; There is no need, =counsel-yank-pop= solves everything!
;; =counsel-yank-pop= enhances built-in =yank-pop=.
;; (use-package browse-kill-ring
;;   :ensure t)
(global-set-key (kbd "M-y") 'counsel-yank-pop)

;; Paredit Hooks 
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode) ;isso é para CL
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode) ;ativado via M-x
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode) ;ativar o paredit no slime
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'clojurescript-mode-hook #'enable-paredit)
(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)

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
;;(global-set-key (kbd "M-]") 'dabbrev-expand)

;; Kebinding to move org row up
(global-set-key (kbd "C-x M-p") 'org-table-move-row-up)

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
(wrap-region-add-wrapper "=" "=")


;; Increase the font size
(set-face-attribute 'default nil :height 130)

;; Enabling IDO
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

;; Mouse hacking -> enforce a keyboard driven experience Try to avoid
;; using mouse, mouse pad, and arrow keys (up, down, etc)
;; (require 'disable-mouse) (global-disable-mouse-mode)
(mouse-wheel-mode 0)
;; Disable arrow keys to enforce C-n, C-p, C-f and C-b use
(global-unset-key (kbd "<left>") )
(global-unset-key (kbd "<right>") )
(global-unset-key (kbd "<up>") )
(global-unset-key (kbd "<down>") )

(slime-setup '(slime-fancy slime-asdf slime-indentation slime-sbcl-exts slime-scratch))

(setq slime-lisp-implementations
      '((sbcl ("/home/pedro/projects/nyxt.sh" ""))))

(define-minor-mode centered-point-mode
  "Alaways center the cursor in the middle of the screen."
  :lighter "..."
  (cond (centered-point-mode (add-hook 'post-command-hook 'pmd/line-change))
	(t (remove-hook 'post-command-hook 'pmd/line-change))))

(defun pmd/line-change ()
  (when (eq (get-buffer-window)
            (selected-window))
    (recenter)))

(provide 'centeredpoint)
(centered-point-mode t) ;;enable it globally

;; System Crafters does not use `custom-set-variables' or `custom-set-faces'

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
   '(restclient keycast wakatime-mode ivy-prescient prescient wrap-region transpose-frame magit paredit general which-key use-package slime rainbow-delimiters popup helpful helm-core dracula-theme doom-themes doom-modeline counsel command-log-mode all-the-icons-ivy-rich))
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
           (enhance-imenu-lisp "bookmarklet-command" "class" "command" "ffi-method" "function" "internal-page-command" "internal-page-command-global" "mode" "parenscript" "user-class"))
     (eval cl-flet
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
; insert comment test
(put 'upcase-region 'disabled nil)
