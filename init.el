;; Initialize package system
(require 'package)
(package-initialize)
(add-to-list 'load-path (concat user-emacs-directory "personal/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Location of customizations
(setq custom-file (concat user-emacs-directory ".emacs-custom.el"))

;; Require personal commands
(require 'my-commands)

;; General configuration
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(transient-mark-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(ido-mode 1)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backup/"))))
(define-key global-map (kbd "RET") 'newline-and-indent)
(setq scroll-conservatively 1000)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5) ((control))))

;; Fix the PATH variable when launching GUI emacs
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))

(setq find-function-C-source-directory "/Users/minerva/Source Code/emacs-24.4/src")

;; pbcopy - enable integration with OSX clipboard
(require 'pbcopy)
(turn-on-pbcopy)

;; erc
(setq erc-nick "rationalrevolt")

;; emacs-lisp
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

;; ruby-mode
(add-hook 'ruby-mode-hook 'rvm-activate-corresponding-ruby t)
