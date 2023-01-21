
;; Для ускорения загрузки Emacs
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (expt 2 23))))

;; Простая настройка интерфейса
(setq inhibit-startup-message t)
(global-display-line-numbers-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(set-frame-font "Source Code Pro-10")

;; Добавление репозитория MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Установка use-package, если не установлен
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Стартовый экран
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-banner-logo-title "Добро пожаловать домой :3")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-items '((recents  . 5)
			  (projects . 5)))
  (setq dashboard-item-names '(("Recent Files:" . "Последние файлы:")
			       ("Projects:" . "Проекты:")))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-footer nil)
  (setq dashboard-set-init-info nil))

;; Удобные отступы
(global-aggressive-indent-mode 1)
(add-to-list
 'aggressive-indent-dont-indent-if
 '(and (derived-mode-p 'c++-mode)
       (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
			   (thing-at-point 'line)))))

;; "Радужные скобки"
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Автозавершение скобок
(electric-pair-mode 1)

;; Проверка синтаксиса flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Языковой сервер
(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-show-diagnostics
	lsp-ui-sideline-show-hover
	lsp-ui-sideline-delay 0.5))
(lsp-ui-mode)

;; Помощь с командами в буффере
(use-package helm
  :config
  (setq completion-styles '(flex))
  :init
  (helm-mode 1)
  :bind
  (("M-x"     . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x b"   . helm-mini)
   ("C-x C-r" . helm-recentf)
   ("C-c i"   . helm-imenu)
   ("M-y"     . helm-show-kill-ring)
   :map helm-map
   ("C-z"     . helm-select-action)
   ("<tab>"   . helm-execute-persistent-action)))

;; Помощь с сочетаниями клавиш
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
	which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))

;; Автозавершение
(use-package company
  :config
  (setq company-minimum-prefix-lenght 1
	company-idle-delay 0.0
	company-selection-wrap-around t))
(global-company-mode)

;; Тема Nord :3
(use-package nord-theme
  :config (load-theme 'nord t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(aggressive-completion aggressive-indent rainbow-delimiters helm-projectile projectile all-the-icons dashboard company-ctags lsp-treemacs helm-lsp ls-ui lsp-ui flycheck company helm-fish-completion which-key ## helm use-package tree-sitter-langs nord-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
