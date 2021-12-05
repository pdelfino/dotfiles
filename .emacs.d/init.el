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

;; Fontsize
;;(set-face-attribute 'default nil :font "Fira Code Retina" :height 200)

;; Load theme used by System Crafters
(load-theme 'wombat)

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
;; (use-package ivy
;;   :diminish ;keeps ivy out of the mode line
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("TAB" . ivy-alt-done)	
;;          ("C-l" . ivy-alt-done)
;;          ("C-j" . ivy-next-line)
;;          ("C-k" . ivy-previous-line)
;;          :map ivy-switch-buffer-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-l" . ivy-done)
;;          ("C-d" . ivy-switch-buffer-kill)
;;          :map ivy-reverse-i-search-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 1))

;; Change mode-line to be more modern, like SpaceMacs
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Requisite to have cool icons on the doom-mode line
(use-package all-the-icons
  :if (display-graphic-p))


(slime-setup '(slime-fancy slime-asdf slime-indentation slime-sbcl-exts slime-scratch))

(setq slime-lisp-implementations
      '((sbcl ("/home/pedro/projects/nyxt.sh" ""))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-command-log-mode t)
 '(package-selected-packages '(doom-modeline ivy command-log-mode slime use-package))
 '(tooltip-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
