(require 'package)
(package-initialize)

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository

;; there are necessary
(defun ensure-package-installed (&rest packages)
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if t
           (package-install package)
         package)))
   packages))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;;add your packages here
(ensure-package-installed
 'swiper
 'swiper-helm
 'git-gutter
 'window-number
 'project-explorer
 'paredit
 'recentf
 'clojure-snippets
 'clojure-mode
 'cider
 'smartparens
 'cider-eval-sexp-fu
 'cyberpunk-theme
 'magit-gitflow
 'company
 'elpy
 'lorem-ipsum
 'python-mode
 'key-chord
 'projectile
 'monokai-theme
 'flycheck
 'molokai-theme
 'clj-refactor)


(projectile-global-mode)
(key-chord-mode 1)
(smartparens-global-mode)

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key [f6] 'ivy-resum)

(global-set-key (kbd "C-c C-c") 'eval-last-sexp)
;; better search and replace
(global-set-key (kbd "C-c %") 'query-replace-regexp)
;;this has to be on top. or modications require confirmation

(require 'recentf)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode +1)


(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x m") 'eshell)

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(global-set-key (kbd "C-c f") 'recentf-ido-find-file)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("08851585c86abcf44bb1232bced2ae13bc9f6323aeda71adfa3791d6e7fea2b6" default)))
 '(package-selected-packages
   (quote
    (lorem-ipsum flycheck python-mode lisp-mode key-chord company company-mode smartparens molokai-theme clj-refactor monokai-theme magit-gitflow cyberpunk-theme cider-eval-sexp-fu cider clojure-snippets paredit project-explorer window-number git-gutter swiper)))
 '(send-mail-function (quote sendmail-send-it)))

;;ui tweaks
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(global-hl-line-mode -1)

;; personal styling
(set-default-font "Fira Mono 16")
(load-theme 'molokai);;https://github.com/tonsky/FiraCodex

;(set-face-attribute 'default nil :height 140)
(scroll-bar-mode -1)
;; show line numbers

(global-linum-mode -1)
;(set-face-background 'linum "#1b1d1e")
;(set-face-foreground 'linum "#333333)"

;(setq linum-format " ")

;(setq linum-format " \u2442 ")
;(setq linum-format " %4d ")

;; change command and option key
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; you know mac
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;; clojure start

(require 'clojure-mode)
(require 'cider)
;; clojure related stuff
;; enable eldoc in clojure buffers
(add-hook 'cider-mode-hook #'eldoc-mode)
;; hide *nrepl* connection
(setq nrepl-hide-special-buffers t)

(setq cider-repl-tab-command #'indent-for-tab-command)

(setq cider-auto-mode nil)
;;dont log communications with log server
(setq nrepl-log-messages nil)
(setq cider-prefer-local-resources t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-show-error-buffer nil)
(setq cider-show-error-buffer 'only-in-repl)
(setq cider-auto-select-error-buffer nil)
(setq cider-stacktrace-default-filters '(tooling dup))

(setq cider-stacktrace-fill-column 80)
(setq nrepl-buffer-name-separator "-")

(setq nrepl-buffer-name-show-port t)
(setq cider-repl-display-in-current-window t)
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-result-prefix ";; => ")
(setq cider-interactive-eval-result-prefix ";; => ")
(setq cider-repl-use-clojure-font-lock t)
(setq cider-switch-to-repl-command #'cider-switch-to-current-repl-buffer)
(setq cider-test-show-report-on-success t)
(setq cider-show-error-buffer nil)
(setq cider-auto-select-error-buffer nil)

;(setq cider-refresh-before-fn "user/stop-system!" cider-refresh-after-fn "user/start-system!")
;(setq cider-known-endpoints '(("host-a" "10.10.10.1" "7888") ("host-b" "7888")))

(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)
(global-company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

(setq company-idle-delay 0.3) ; never start completions automatically
;(global-set-key (kbd "M-TAB") #'company-complete) ; use meta+tab, aka C-M-i, as manual trigger
;(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(require 'clj-refactor)
(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(require 'cider-eval-sexp-fu)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;clojure  end
;; tramp , remote file manipulation
(setq tramp-chunksize 500)
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(setq tramp-debug-buffer t)
(setq tramp-verbose 10)

;;changing default temp dir
(put 'temporary-file-directory 'standard-value '((file-name-as-directory "/tmp")))
;; snippets , this is working quite nice now.
;; Custom blog related stuff

(setq org-src-fontify-natively t)
;(set-input-mode t nil t)


(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

;; full screen magit-status
(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

(define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)


;; let's make changed code visible to us.
(require 'git-gutter)
(global-git-gutter-mode +1)

;; background color ,modified for monokai
;(set-face-foreground 'git-gutter:modified "#282828") monokai default color

(set-face-foreground 'git-gutter:deleted "#1b1d1e")
(set-face-background 'git-gutter:deleted "#465765")
(set-face-foreground 'git-gutter:modified "#1b1d1e")
(set-face-background 'git-gutter:modified "#465765")
(set-face-foreground 'git-gutter:added "#1b1d1e")
(set-face-background 'git-gutter:added "#465765")

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

(global-set-key (kbd "M-G") 'beginning-of-buffer)
(global-set-key (kbd "M-R") 'end-of-buffer)

(key-chord-define-global "''" 'other-window)
(key-chord-define-global ",," 'previous-buffer)

;(key-chord-define-global "@@" 'cider-restart)
(key-chord-define-global "$$" 'project-explorer-open)
(key-chord-define-global "xx" 'execute-extended-command)
;(key-chord-define-global "zz" 'cider-connect)

(setq cider-test-show-report-on-success t)
(define-key clojure-mode-map (kbd "C-x c") 'cider-eval-last-sexp-to-repl)
(define-key clojure-mode-map (kbd "C-x F") 'cider-format-buffer)

(defun yui-compress ()
  (interactive)
  (call-process-region
   (point-min) (point-max) "yuicompressor" t t nil (buffer-file-name)))

(require 'project-explorer)
(setq pe/omit-gitignore t)
(setq pe/width 28)

;;refresh all namespaces
(defun nrepl-refresh ()
  (interactive)
  (call-interactively 'cider-switch-to-relevant-repl-buffer)
  (goto-char (point-max))
  (insert "(clojure.tools.namespace.repl/refresh)")
  (cider-repl-return))

;; reset your system
(defun nrepl-reset ()
  (interactive)
  (call-interactively 'cider-switch-to-relevant-repl-buffer)
  (goto-char (point-max))
  (insert "(user/reset)")
  (cider-repl-return))

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

(defun nrepl-run-all-tests (ns)
  (interactive (list (cider-current-ns)))
  (call-interactively 'cider-switch-to-relevant-repl-buffer)
  (goto-char (point-max))
  (insert (format "(cljs.user/run-tests '%s)" ns))
  (cider-repl-return))

(defun mbp-clojure-mode-keybindings ()
  (local-set-key (kbd "C-c C-s") 'nrepl-refresh)
  (local-set-key (kbd "<f5>") 'nrepl-reset)
  (local-set-key (kbd "<f6>") 'nrepl-run-all-tests))

(add-hook 'clojure-mode-hook 'mbp-clojure-mode-keybindings)

(global-set-key (kbd "C-x t") 'temp-buffer)

;; this whitespace is kinda killing me
;(setq prelude-whitespace nil)
;(setq prelude-clean-whitespace-on-save nil)
(setq prelude-flyspell nil)
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
  (setq default-buffer-file-coding-system 'utf-8))

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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; fullscreen
(toggle-frame-fullscreen)

;;all I want is working cursor
(setq-default cursor-type 'bar)
(set-cursor-color "#FABD2F")
(blink-cursor-mode t)

;; Show errors in this file:
;;(setq debug-on-error t)
;(setq stack-trace-on-error t)

;; Automatically uncompress .gz files
(global-set-key "\M-z" 'redo)
(global-set-key (kbd "C-x C-g") 'helm-imenu)

;; Get rid of keys I hit accidentally:
(global-unset-key "\M-c")    ; don't want the capitalize thing


;; which screw up my directory listings.  Make it put them
;; somewhere else:
(setq auto-save-list-file-prefix "~/.emacs-saves/.saves-")

(setq-default indent-tabs-mode nil)
(setq tabify nil)
(setq fill-column 75)
(setq  cursor-in-non-selected-windows nil)
;;set the background-color of selected region

;; make a clear selection color
;(set-face-attribute 'region nil :background "#787878")
;;window management
;; highlight the window number in pink color
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.")
;;ui performance improvement
(setq redisplay-dont-pause t)

;;I like darkep background
(set-background-color "#1b1d1e")
(set-face-background 'fringe "#1b1d1e")

(set-face-attribute 'mode-line nil :foreground "gray60" :background "#1b1d1e" :inverse-video nil :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute 'mode-line-inactive nil :foreground "gray60" :background "#1b1d1e" :inverse-video nil :box '(:line-width 1 :color "gray20" :style nil))

;; keep a smooth look of it
;(set-face-background 'fringe "#1B1D1E")

;;linum colors , hide distracting information , focus on the most important things
;; I want a snappy Emacs
(global-flycheck-mode -1)


;clear within the eshell to clear the entire buffer.
(defun eshell/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))
(setq warning-minimum-level :emergency)

;;python stuff
(package-initialize)
(elpy-enable)
(require 'python)
(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--pylab")

(defun send-line-or-region ()
  (interactive)
  (if (region-active-p)
      (call-interactively 'elpy-shell-send-region-or-buffer)
    (python-shell-send-string (thing-at-point 'line))))

(define-key elpy-mode-map (kbd "C-c C-c") 'send-line-or-region)

;; code fucking snippets
;(yas-reload-all)
;(yas-global-mode 1)
;(add-hook 'clojure-mode-hook #'yas-minor-mode)

;;better comp
(setq projectile-completion-system 'grizzl)
(setq  helm-mode-fuzzy-match t)
(setq  helm-completion-in-region-fuzzy-match t)
(setq helm-M-x-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)
(setq helm-locate-fuzzy-match t)
(setq helm-apropos-fuzzy-match t)
(setq helm-lisp-fuzzy-completion t)

;;let's add some helm stuff,fuzzy and beautiful

;; custom stuff
(defun get-search-term (beg end)
  "message region or \"empty string\" if none highlighted"
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (point-min) (point-min))))
  (let ((selection (buffer-substring-no-properties beg end)))
    (if (= (length selection) 0)
        (message "empty string")
      (message selection))))


(defun eshell-here ()
  "Opens up a new shell in the directory associated with the current buffer's file."
  (interactive)
  (let* ((parent (file-name-directory (buffer-file-name)))
         (name   (car
                  (last
                   (split-string parent "/" t)))))
    (split-window-vertically)
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

;;random text we need sometimes
(lorem-ipsum-use-default-bindings)

;;  we have to move efficiently 
(global-subword-mode 1)

;; stop the crap
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #auto-save# files

(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%Y-%m-%d" ) ;"%d.%m.%Y"
                 ((equal prefix '(4)) "%Y-%m-%d")
                 ((equal prefix '(16)) "%A, %d. %B %Y")))
        (system-time-locale "de_DE"))
    (insert (format-time-string format))))

(global-set-key (kbd "C-c 1") 'insert-date)


