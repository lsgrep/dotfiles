(package-initialize)
(put 'erase-buffer 'disabled nil)
;;; quick startup
(setq gc-cons-threshold 100000000)

;;; major repos
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository

(global-hl-line-mode -1)

;;changing default temp dir
(put 'temporary-file-directory 'standard-value '((file-name-as-directory "/tmp")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;spacemacs offers good themes
;;;http://themegallery.robdor.com/ 

;;; PT Mono & Theme
(use-package monokai-theme
  :ensure t
  :config (progn
            (setq monokai-use-variable-pitch nil
                  monokai-height-minus-1 1.0
                  monokai-height-plus-1 1.0
                  monokai-height-plus-2 1.0
                  monokai-height-plus-3 1.0
                  monokai-height-plus-4 1.0)
            (set-default-font "PT Mono 11")
            (load-theme 'monokai t)))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

;; Get rid of keys I hit accidentally:
(global-unset-key "\M-c")    ; don't want the capitalize thing

;;; or Emacs fucking freezes every fucking time.

;; which screw up my directory listings.  Make it put them
;; somewhere else:
(setq auto-save-list-file-prefix "~/.emacs-saves/.saves-")

(defun eshell/clear ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(defun my/turn-off-linum-mode ()
  (linum-mode -1))

(defun open-with (arg)
  "Open visited file in default external program.

With a prefix ARG always prompt for command to use."
  (interactive "P")
  (when buffer-file-name
    (shell-command (concat
                    (cond
                     ((and (not arg) (eq system-type 'darwin)) "open")
                     ((and (not arg) (member system-type '(gnu gnu/linux gnu/kfreebsd))) "xdg-open")
                     (t (read-shell-command "Open current file with: ")))
                    " "
                    (shell-quote-argument buffer-file-name)))))

(global-set-key (kbd "C-c o") 'open-with)

(defun copy-file-name-to-clipboard ()
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "copied buffer file name '%s' to the clipboard" filename))))

(setq-default indent-tabs-mode nil)
(setq tabify nil)
(setq  cursor-in-non-selected-windows nil)
;;set the background-color of selected region


;;I like darkep background

(global-linum-mode +1)
(setq linum-format " %4d ")

(set-face-attribute 'linum nil :background (face-attribute 'default :background))
(set-face-attribute 'linum nil :family (face-attribute 'default :family) :height 80)

(setq warning-minimum-level :emergency)

(defun temp-buffer ()
  (interactive)
  (switch-to-buffer "*temp*"))

(defun detabify-buffer ()
  "Calls untabify on the current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun clean-up-whitespace ()
  "Calls untabify and delete-trailing-whitespace on the current buffer."
  (interactive)
  (detabify-buffer)
  (delete-trailing-whitespace))

(global-set-key (kbd "C-x t") 'temp-buffer)

;; this whitespace is kinda killing me
(require 'whitespace)
(setq whitespace-line-column 80000) ;; limit line length
;;encoding;
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;annoying whitespace
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
      '(
        ;;(space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        ;;(newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        ))

(setenv "PATH"
        (concat (getenv "PATH") ":/usr/local/bin"))

(defun ysp/view-buffer-name ()
  "Display the filename of the current buffer."
  (interactive)
  (message (buffer-file-name)))

(defun ysp/generate-scratch-buffer ()
  "Create and switch to a temporary scratch buffer with a random
     name."
  (interactive)
  (switch-to-buffer (make-temp-name "scratch-")))

(defun ysp/split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (other-window 1))

(defun ysp/split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (other-window 1))

(defun ysp/de-unicode ()
  "Tidy up a buffer by replacing all special Unicode characters
     (smart quotes, etc.) with their more sane cousins"
  (interactive)
  (let ((unicode-map '(("[\u2018\|\u2019\|\u201A\|\uFFFD]" . "'")
                       ("[\u201c\|\u201d\|\u201e]" . "\"")
                       ("\u2013" . "--")
                       ("\u2014" . "---")
                       ("\u2026" . "...")
                       ("\u00A9" . "(c)")
                       ("\u00AE" . "(r)")
                       ("\u2122" . "TM")
                       ("[\u02DC\|\u00A0]" . " "))))
    (save-excursion
      (loop for (key . value) in unicode-map
            do
            (goto-char (point-min))
            (replace-regexp key value)))))

(defun ysp/beautify-json ()
  "Pretty-print the JSON in the marked region. Currently shells
     out to `jsonpp'--be sure that's installed!"
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "jsonpp" (buffer-name) t)))

(defun ysp/comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(defun ysp/unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun ysp/kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

(defun ysp/visit-last-dired-file ()
  "Open the last file in an open dired buffer."
  (end-of-buffer)
  (previous-line)
  (dired-find-file))

(defun ysp/visit-last-migration ()
  "Open the last file in 'db/migrate/'. Relies on projectile. Pretty sloppy."
  (interactive)
  (dired (expand-file-name "db/migrate" (projectile-project-root)))
  (hrs/visit-last-dired-file)
  (kill-buffer "migrate"))

(defun ysp/mac? ()
  "Returns `t' if this is an Apple machine, nil otherwise."
  (eq system-type 'darwin))

(defun ysp/add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(defun ysp/find-file-as-sudo ()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (when file-name
      (find-alternate-file (concat "/sudo::" file-name)))))

(defun ysp/insert-random-string (len)
  "Insert a random alphanumeric string of length len."
  (interactive)
  (let ((mycharset "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstyvwxyz"))
    (dotimes (i len)
      (insert (elt mycharset (random (length mycharset)))))))

(defun ysp/generate-password ()
  "Insert a good alphanumeric password of length 30."
  (interactive)
  (hrs/insert-random-string 30))


(global-set-key (kbd "C-x 2") 'ysp/split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'ysp/split-window-right-and-switch)

;; Show errors in this file:
;;(setq debug-on-error t)
;;(setq stack-trace-on-error t)

;;; save when necessarry
(defun save-all ()
  (interactive)
  (save-some-buffers t))

(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%Y-%m-%d" ) ;"%d.%m.%Y"
                 ((equal prefix '(4)) "%Y-%m-%d")
                 ((equal prefix '(16)) "%A, %d. %B %Y")))
        (system-time-locale "en_US"))
    (insert (format-time-string format))))

(global-set-key (kbd "C-c 1") 'insert-date)

(defun settings ()
  (interactive)
  (find-file "/work/Lispy/orgy/dots/emacs.d/init.el"))

(defun reload-settings ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun lein-settings ()
  (interactive)
  (find-file "~/.lein/profiles.clj"))

(global-set-key (kbd "C-c I") 'settings)

;; line management
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

;; jumping made a little bit easier
;; Move more quickly
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))
(
 define-key emacs-lisp-mode-map (kbd "C-c C-c") 'pp-eval-last-sexp)

;;; less crap
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq initial-buffer-choice "~/")

;;; life is short , but not my dick.
(defalias 'yes-or-no-p 'y-or-n-p)
;;; no bullshit
(delete-selection-mode t)
(global-set-key (kbd "C-x m") 'eshell)
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; better search and replace
(global-set-key (kbd "C-c %") 'query-replace-regexp)

;;; smooth scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(setq org-src-fontify-natively t)
(set-input-mode t nil t)

;;  we have to move efficiently
(global-subword-mode 1)

;; stop the crap
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #auto-save# files


(setq-default fill-column 100)
(column-number-mode t)
(setq-default indicate-empty-lines nil)

(setq truncate-partial-width-windows nil)

(setq-default truncate-lines nil)
(add-hook 'focus-out-hook 'save-all)

(use-package aggressive-indent
  :ensure t
  :config (global-aggressive-indent-mode 1))


(setq-default cursor-type 'box)
(blink-cursor-mode t)
;;; set the default shell
(setq explicit-shell-file-name "/usr/local/bin/bash")
(set-face-attribute 'fringe nil :background (face-attribute 'default :background)) ;

(set-face-attribute 'vertical-border nil :foreground (face-attribute 'default :background))


(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0)

;;; ok . this is ubuntu .
(setq x-meta-keysym 'super)
(setq x-super-keysym 'meta)

;;; you know dvorak
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package beacon
  :ensure t
  :config (beacon-mode t))


(use-package undo-tree
  :ensure t)

(defun text-mode-hook-setup ()
  ;; make `company-backends' local is critcal
  ;; or else, you will have completion in every major mode, that's very annoying!
  (make-local-variable 'company-backends)

  ;; company-ispell is the plugin to complete words
  (add-to-list 'company-backends 'company-ispell)

  ;; OPTIONAL, if `company-ispell-dictionary' is nil, `ispell-complete-word-dict' is used
  ;;  but I prefer hard code the dictionary path. That's more portable.
  (setq company-ispell-dictionary (file-truename "~/.emacs.d/english-words.txt")))

(defun toggle-company-ispell ()
  (interactive)
  (cond
   ((memq 'company-ispell company-backends)
    (setq company-backends (delete 'company-ispell company-backends))
    (message "company-ispell disabled"))
   (t
    (add-to-list 'company-backends 'company-ispell)
    (message "company-ispell enabled!"))))

(use-package company
  :ensure t
  :config (progn
            (global-company-mode t)
            (global-set-key (kbd "M-TAB") #'company-complete))

  :init (progn
          (setq company-tooltip-align-annotations t)
          (setq company-idle-delay 0.025)
          (setq company-dabbrev-ignore-case t)
          (setq company-dabbrev-downcase nil)
          (setq company-tooltip-flip-when-above t)
          (setq company-dabbrev-code-other-buffers 'code)
          (add-hook 'text-mode-hook 'text-mode-hook-setup)))



(use-package projectile
  :ensure t
  :config (projectile-global-mode t))

(use-package key-chord
  :ensure t
  :init (key-chord-mode 1)
  :config (progn (key-chord-define-global "$$" 'project-explorer-open)
                 (key-chord-define-global "xx" 'execute-extended-command)))

(use-package smartparens
  :ensure t
  :config (smartparens-global-mode t))


(use-package paredit
  :ensure t
  :config (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

(use-package rainbow-mode
  :ensure t
  :config (rainbow-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :config (progn
            (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
            ))

(use-package counsel
  :ensure t)



;;;  swiper,ivy is much better than default and helm
(use-package swiper
  :ensure t
  :config (progn
            (ivy-mode 1)
            (setq ivy-use-virtual-buffers t)
            (global-set-key "\C-s" 'swiper)
            (global-set-key (kbd "C-c C-r") 'ivy-resume)
            (global-set-key (kbd "<f6>") 'ivy-resume)
            (global-set-key (kbd "M-x") 'counsel-M-x)
            (global-set-key (kbd "C-x C-f") 'counsel-find-file)
            (global-set-key (kbd "<f1> f") 'counsel-describe-function)
            (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
            (global-set-key (kbd "<f1> l") 'counsel-load-library)
            (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
            (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
            (global-set-key (kbd "C-c g") 'counsel-git)
            (global-set-key (kbd "C-c j") 'counsel-git-grep)
            (global-set-key (kbd "C-c k") 'counsel-ag)
            (global-set-key (kbd "C-x l") 'counsel-locate)
            (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
            (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
            (setq projectile-completion-system 'ivy)))

;; Key bindings
(use-package recentf
  :ensure t
  :init (progn
          (setq recentf-max-saved-items 1024)
          (setq recentf-max-menu-items 1024)
          (recentf-mode 1)
          (global-set-key (kbd "C-c f") 'counsel-recentf)))

(use-package highlight-parentheses
  :ensure t
  :config (global-highlight-parentheses-mode nil))

(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.edn\\'" . clojure-mode))
  :init (progn
          (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
          (add-hook 'clojure-mode-hook #'yas-minor-mode)
          (add-hook 'clojure-mode-hook #'subword-mode)
          (add-hook 'clojure-mode-hook #'smartparens-mode)
          (add-hook 'clojure-mode-hook #'paredit-mode)
          (add-hook 'clojure-mode-hook #'eldoc-mode)))

(use-package clj-refactor
  :ensure t
  :defer t
  :diminish clj-refactor-mode
  :config (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package cider
  :ensure t
  :defer t
  :diminish subword-mode
  :init
  (progn
    (setq cider-show-error-buffer nil)
                                        ;    (setq cider-repl-print-length 1000)
    (add-hook 'cider-repl-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'clj-refactor-mode)))

(use-package helm-cider
  :ensure t
  :init (helm-cider-mode t))

(use-package cider-eval-sexp-fu
  :ensure t
  :defer t
  :config (require 'cider-eval-sexp-fu))

(use-package smartparens
  :ensure t
  :defer t
  :diminish smartparens-mode
  :init
  (setq sp-override-key-bindings
        '(("C-<right>" . nil)
          ("C-<left>" . nil)
          ("C-)" . sp-forward-slurp-sexp)
          ("M-<backspace>" . nil)
          ("C-(" . sp-forward-barf-sexp)))
  :config
  (use-package smartparens-config)
  (sp-use-smartparens-bindings)
  (sp--update-override-key-bindings)
  :commands (smartparens-mode show-smartparens-mode))


;; snippets , this is working quite nice now.
;; Custom blog related stuff
(use-package magit
  :ensure t
  :config (progn
            (global-set-key (kbd "C-x g") 'magit-status)))


(use-package project-explorer
  :ensure t
  :config (progn (setq pe/omit-gitignore t)
                 (setq pe/width 32)))

(use-package helm
  :ensure t
  :config   (global-set-key (kbd "C-x C-g") 'helm-imenu))


;;; python
(use-package python
  :ensure t)

(use-package jedi
  :ensure t)

(use-package elpy
  :ensure t
  :config (progn (setq elpy-rpc-backend "jedi")
                 (setq py-python-command "/usr/bin/python3")
                 (elpy-enable)
                 (elpy-use-ipython)
                 (setq python-indent 4)
                 (add-hook 'python-mode-hook 'jedi:setup)
                 (setq jedi:complete-on-dot t)))

;;; better completion for projectile
(use-package grizzl
  :ensure t
  :config
  (setq projectile-completion-system 'grizzl))

;;random text we need sometimes
(use-package lorem-ipsum
  :ensure t
  :config (lorem-ipsum-use-default-bindings))

(use-package origami
  :ensure t)

(use-package markdown-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\grimoire*\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))))

(use-package expand-region
  :ensure t
  :config (global-set-key (kbd "C-=") 'er/expand-region))

(use-package hydra   :ensure t)

(use-package ace-window
  :ensure t
  :config
  (progn (global-unset-key (kbd "M-p"))

         (add-hook 'eshell-mode-hook
                   (lambda ()
                     (define-key eshell-mode-map (kbd "M-p")
                       'ace-window)))
         (add-hook 'cider-repl-mode-hook
                   (lambda ()
                     (define-key cider-repl-mode-map (kbd "M-p")
                       'ace-window)))

         (add-hook 'markdown-mode
                   (lambda ()
                     (define-key cider-repl-mode-map (kbd "M-p")
                       'ace-window)))

         (global-set-key (kbd "M-p") 'ace-window)))

(defun ivy-switch-project ()
  (interactive)
  (ivy-read
   "Switch to project: "
   (if (projectile-project-p)
       (cons (abbreviate-file-name (projectile-project-root))
             (projectile-relevant-known-projects))
     projectile-known-projects)
   :action #'projectile-switch-project-by-name))

(global-set-key (kbd "C-c m") 'ivy-switch-project)

(use-package goto-last-change
  :ensure t
  :config (global-set-key (kbd  "C-x C-\\") 'goto-last-change))

                                        ;(global-visual-line-mode -1)

;;; web stuff
(use-package web-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yaml?\\'" . yaml-mode)))

(use-package js2-mode
  :ensure t
  :config
  (progn
    (add-hook 'js2-mode-hook 'yas-minor-mode)
    (add-hook 'js2-mode-hook 'js2-refactor-mode)
    (js2r-add-keybindings-with-prefix "C-c C-m")
    (add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))
    (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-mode))))


;;; the thing shows up makes you happy and cozy.
(use-package emmet-mode
  :ensure t
  :config (progn
            (add-hook 'web-mode-hook 'emmet-mode)
            (add-hook 'sgml-mode-hook 'emmet-mode)
            (add-hook 'css-mode-hook  'emmet-mode)))

(use-package org-bullets
  :ensure t
  :init (progn
          (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
          (add-hook 'org-mode-hook 'my/turn-off-linum-mode)
          (setq org-log-done t)
          (setq org-hide-leading-stars t)
          (setq org-ellipsis "⤵")
          (setq org-src-fontify-natively t)
          (setq org-src-tab-acts-natively t)
          (setq org-src-window-setup 'current-window)
          (setq org-tag-alist '(("@feature" . ?f)
                                ("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
          (define-key global-map "\C-cl" 'org-store-link)
          (define-key global-map "\C-ca" 'org-agenda)
          (define-key global-map "\C-cc" 'org-capture)
          (define-key org-mode-map (kbd "C-c <left>") 'org-do-promote)
          (define-key org-mode-map (kbd "C-c <right>") 'org-do-demote)
          (define-key org-mode-map (kbd "C-c <C-right>") 'org-demote-subtree)
          (define-key org-mode-map (kbd "C-c <C-left>") 'org-promte-subtree)
          (define-key org-mode-map (kbd "C-c <C-left>") 'org-promte-subtree)
          (define-key org-mode-map (kbd "C-c <up>") 'org-move-subtree-up)
          (define-key org-mode-map (kbd "C-c <down>") 'org-move-subtree-down)
          (setq org-default-notes-file "/work/Lispy/org/read.org")
          (setq org-agenda-files (list "/work/Lispy/org/read.org"
                                       "/work/Lispy/org/projects/aus.org"
                                       "/work/Lispy/org/projects/blue.org"
                                       "/work/Lispy/org/projects/mdc.org"))))

(use-package auctex
  :ensure t
  :mode ("\\.tex\\'" . latex-mode)
  :commands (latex-mode LaTeX-mode plain-tex-mode)
  :init
  (progn
    (add-hook 'LaTeX-mode-hook #'LaTeX-preview-setup)
    (add-hook 'LaTeX-mode-hook #'flyspell-mode)
    (add-hook 'LaTeX-mode-hook #'turn-on-reftex)
    (setq TeX-auto-save t
	  TeX-parse-self t
	  TeX-save-query nil
	  TeX-PDF-mode t)
    (setq-default TeX-master nil)))

(use-package diff-hl
  :ensure t
  :config (global-diff-hl-mode t))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode t))

(use-package clojure-snippets
  :ensure t)

(use-package engine-mode
  :ensure t
  :config (progn
            (defengine duckduckgo
              "https://duckduckgo.com/?q=%s"
              :keybinding "d")

            (defengine github
              "https://github.com/search?ref=simplesearch&q=%s"
              :keybinding "G")

            (defengine google
              "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
              :keybinding "g")

            (defengine stack-overflow
              "https://stackoverflow.com/search?q=%s"
              :keybinding "s")

            (defengine wikipedia
              "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
              :keybinding "w")

            (defengine wiktionary
              "https://www.wikipedia.org/search-redirect.php?family=wiktionary&language=en&go=Go&search=%s"
              :keybinding "W")

            (engine-mode t)))

(use-package helm-descbinds
  :ensure t
  :defer t
  :bind (("C-h b" . helm-descbinds)
         ("C-h w" . helm-descbinds)))

(use-package artbollocks-mode
  :ensure t
  :defer t
  :init     (add-hook 'org-mode-hook #'artbollocks-mode)
  :config
  (progn
    (setq artbollocks-weasel-words-regex
          (concat "\\b" (regexp-opt
                         '("one of the"
                           "should"
                           "just"
                           "sort of"
                           "a lot"
                           "probably"
                           "maybe"
                           "perhaps"
                           "I think"
                           "really"
                           "pretty"
                           "nice"
                           "action"
                           "utilize"
                           "leverage") t) "\\b"))
    ;; Don't show the art critic words, or at least until I figure
    ;; out my own jargon
    (setq artbollocks-jargon nil)))

;;; let's set a respectful theme.
(use-package xkcd
  :ensure t
  :defer t)

(use-package calfw
  :ensure t
  :init
  (progn
    (require 'calfw)))


(use-package go-mode
  :ensure t
  :init
  (progn (require 'go-mode-autoloads)))

(use-package smart-mode-line
  :ensure t
  :config (progn
            (setq sml/no-confirm-load-theme t)
            (sml/setup)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(go-mode scala-mode smart-mode-line calfw xkcd artbollocks-mode helm-descbinds engine-mode clojure-snippets diff-hl auctex org-bullets emmet-mode js2-mode yaml-mode web-mode goto-last-change ace-window expand-region markdown-mode origami lorem-ipsum grizzl elpy jedi helm project-explorer magit cider-eval-sexp-fu helm-cider clj-refactor clojure-mode highlight-parentheses counsel rainbow-delimiters rainbow-mode paredit smartparens key-chord projectile company undo-tree beacon which-key try aggressive-indent monokai-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
