;; no splash screen
(setq inhibit-startup-message t)

;; add a larger package repository
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")) 
(package-initialize)

;; a package manager
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; auto install spacemacs theme
(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

;; aliases
(defalias 'yes-or-no-p 'y-or-n-p)

;; make zsh default shell
(defvar my-term-shell "/usr/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; hide menu bar in terminal
(unless (display-graphic-p)
  (menu-bar-mode -1))

(when (window-system)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido))
 '(ido-use-filename-at-point (quote guess))
 '(package-selected-packages (quote (spacemacs-theme which-key use-package xclip))))

;; transparent background for terminal emulator
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "SRC" :family "Hack")))))

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(global-visual-line-mode t)

;; share system clipboard with emacs
(setq x-select-enable-clipboard t)

;; in sentence movement, do not require that sentences be separated with double spaces
(setq sentence-end-double-space nil)
(xclip-mode 1)

;; ;; show line numbers
;; ;; add space and solid line between line numbers and text
;; (setq linum-format "%4d \u2502 ")
;; (global-linum-mode t)

;; set transparency level
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
(set-frame-parameter (selected-frame) 'alpha '(95 50))
(add-to-list 'default-frame-alist '(alpha 95 50))

;; custom bindings
;; switch window (C-x o)
(global-set-key (kbd "M-o") 'other-window)
(windmove-default-keybindings) ; S-<left|right|up|down> to switch windows
;; resize window
(global-set-key (kbd "<M-up>") 'shrink-window)
(global-set-key (kbd "<M-down>") 'enlarge-window)
(global-set-key (kbd "<M-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<M-right>") 'enlarge-window-horizontally)
;; launch terminal
(global-set-key (kbd "<s-return>") 'ansi-term)
