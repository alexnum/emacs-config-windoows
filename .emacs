(getenv "PATH")

(when (string-equal system-type "windows-nt")
(progn
(setq unixutils-bin "C:\\unixutils\\usr\\local\\wbin")
(setq git-bin "D:\\Program Files\\Git\\bin")
(setq node-bin "D:\\Users\\Alessandro\\AppData\\Roaming\\nvm\\v12.9.0")

(setenv "PATH"
(concat unixutils-bin ";" git-bin ";" node-bin ";"))

(setq exec-path '(unixutils-bin git-bin node-bin)))) 

(setq exec-path (append exec-path '("D:\\Users\\Alessandro\\AppData\\Roaming\\nvm\\v12.9.0")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq backup-directory-alist '(("." . "C:\\Users\\Alessandro\\emacsBkps")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages
   (quote
    (tern-auto-complete tern tide company dired-sidebar yaml-mode nginx-mode ng2-mode rmsbolt rjsx-mode projectile frame-local s ov dash-functional)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.org/packages/")
   t))

(add-to-list 'load-path "C:\\Users\\Alessandro\\AppData\\Roaming\\.emacs.d\\sidebar.el")
(require 'sidebar)
(global-set-key (kbd "C-x C-a") 'sidebar-buffers-open)

(setq js-indent-level 4)
(defun my-js-mode-hook ()
  ;;Usar espaço quando TAB for pressionado
  (setq-default tab-always-indent nil)
  ;;Não usar espaços
  (setq indent-tabs-mode nil))
(add-hook 'js-mode-hook 'my-js-mode-hook)




(global-set-key (kbd "C-x C-f") 'dired-sidebar-toggle-sidebar)
(add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))

(setq dired-sidebar-subtree-line-prefix " ")
(setq dired-sidebar-theme 'ascii)
(setq dired-sidebar-use-term-integration t)
(setq dired-sidebar-use-custom-font t)


(defun my-sidebar-mode-hook ()
  ;;Usar espaço quando TAB for pressionado
  (local-set-key (kbd "SPC") 'dired-sidebar-subtree-toggle)
  (local-set-key (kbd "q") 'dired-sidebar-hide-sidebar)
  (local-set-key (kbd "<backspace>") 'dired-sidebar-up-directory)
  (local-set-key (kbd "C-s") 'search-forward)
)

(add-hook 'dired-sidebar-mode-hook 'my-sidebar-mode-hook)

;;dired-sidebar-up-directory


(add-hook 'after-init-hook 'global-company-mode)



(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
