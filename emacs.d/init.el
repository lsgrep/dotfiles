;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)
;(setq custom-file "/Users/yusup/.emacs.d/personal/custom.el")
;(load custom-file)
(require 'package)
(package-initialize)
(put 'erase-buffer 'disabled nil)
;;; quick startup
(setq gc-cons-threshold 100000000)

;;; major repos
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository

;;; less crap
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq initial-buffer-choice "~/")

;;; smooth scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "2ef75a0b64c58767376c9e2c5f07027add146720e6fab6b196cb6a1c68ef3c3f" "f5ef7ddecf161a2951048c204c2c6d9d5be08745b136dce583056ad4b234b861" "3ed645b3c08080a43a2a15e5768b893c27f6a02ca3282576e3bc09f3d9fa3aaa" "36affb6b6328d2bfa7a31b3183cd65d6dd1a8c0945382f94de729233b9737359" "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" "95db78d85e3c0e735da28af774dfa59308db832f84b8a2287586f5b4f21a7a5b" "614f8478963ec8caac8809931c9d00f670e4519388c02f71d9d27b66d5741a7f" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "50ce37723ff2abc0b0b05741864ae9bd22c17cdb469cae134973ad46c7e48044" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "8fed5e4b89cf69107d524c4b91b4a4c35bcf1b3563d5f306608f0c48f580fdf8" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "08851585c86abcf44bb1232bced2ae13bc9f6323aeda71adfa3791d6e7fea2b6" default)))
 '(git-gutter:added-sign "☀")
 '(git-gutter:deleted-sign "☂")
 '(git-gutter:modified-sign "☁")
 '(git-gutter:window-width 2)
 '(package-selected-packages
   (quote
    (emmet-mode anaconda-mode ensime scala-mode2 scala-mode GOTO-last-change gist highlight-parentheses helm-projectile olivetti auto-yasnippet SMEX rainbow-mode nyan-mode helm counsel rainbow-delimeters company clojure-mode paredit swiper pylint pyflakes ace-window popup swiper-helm smartparens rainbow-delimiters python-mode projectile project-explorer origami monokai-theme molokai-theme markdown-mode magit-gitflow lorem-ipsum key-chord grizzl git-gutter flycheck expand-region elpy cyberpunk-theme clojure-snippets clj-refactor cider-eval-sexp-fu)))
 '(python-check-command "/usr/local/bin/pyflakes"))

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

;;; necessary packages
(ensure-package-installed
 'grizzl
 'swiper
 'git-gutter
 'window-number
 'project-explorer
 'paredit
 'recentf
 'clojure-snippets
 'origami
 'clojure-mode
 'clj-refactor
 'cider
 'web-mode
 'expand-region
 'smartparens
 'rainbow-delimiters
 'popup
 'cider-eval-sexp-fu
 'cyberpunk-theme
 'magit-gitflow
 'markdown-mode
 'company
 'spaceline
 'elpy
 'helm
 'helm-projectile
 'pylint
 'rainbow-mode
 'pyflakes
 'anaconda-mode
 'lorem-ipsum
 'python-mode
 'key-chord
 'projectile
 'nyan-mode
 'gist
 'highlight-parentheses
 'monokai-theme
 'flycheck
 'counsel
 'goto-last-change
 'ace-window
 'scala-mode2
 'ensime)

(projectile-global-mode)
(key-chord-mode 1)
(smartparens-global-mode)
(rainbow-mode 1)

;;; my dick is short ,so is my life
(defalias 'yes-or-no-p 'y-or-n-p)
;;; no bullshit
(delete-selection-mode t)

;;;
;;; rainbow makes things easier for the eyes
;;;
(nyan-mode t)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'paredit-mode) 
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
;;;
;;; end of rainbow
;;;

;;;  swiper,ivy is much better than default and helm
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key [f6] 'ivy-resume)
(setq ivy-display-style 'fancy)
;(setq projectile-completion-system 'ivy)

;; better search and replace
(global-set-key (kbd "C-c %") 'query-replace-regexp)

;;;  show recent files
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

;;ui tweaks
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(global-hl-line-mode -1)
(make-variable-buffer-local 'global-hl-line-mode)

(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)
(setq show-paren-style 'parenthesis) 
(setq show-paren-delay 0)
(global-highlight-parentheses-mode t)

;; personal styling
(set-default-font "Source Code Pro 16")
(load-theme 'cyberpunk);;https://github.com/tonsky/FiraCodex

;(set-face-attribute 'default nil :height 140)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 90))

;;;  change command and option key 
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;;; you know dvorak 
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

;;; Clojure
(require 'clojure-mode)
(require 'cider)
(setq cider-ovelays-use-font-lock t)
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
(setq cider-stacktrace-default-filters nil)
(setq cider-stacktrace-fill-column 80)
(setq nrepl-buffer-name-separator "-")
(setq nrepl-buffer-name-show-port t)


(setq cider-repl-display-in-current-window nil)
(setq cider-prompt-save-file-on-load nil)

(setq cider-repl-result-prefix ";; => ")
(setq cider-interactive-eval-result-prefix ";; => ")
(setq cider-repl-use-clojure-font-lock t)
(setq cider-switch-to-repl-command #'cider-switch-to-current-repl-buffer)
(setq cider-test-show-report-on-success t)

(setq cider-known-endpoints '(("hyper" "127.0.0.1" "33333")))
(setq cider-refresh-show-log-buffer t)



(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)

;;; Comfuckingpany
(global-company-mode)
(setq company-tooltip-align-annotations t)
(setq company-idle-delay 0.3)
(setq company-dabbrev-ignore-case nil)
(setq company-dabbrev-downcase nil)
(setq company-tooltip-flip-when-above t)
(setq company-dabbrev-code-other-buffers 'code)
;(global-set-key (kbd "M-TAB") #'company-complete) ; use meta+tab, aka C-M-i, as manual trigger
;(global-set-key (kbd "TAB") #'company-indent-or-complete-common)


(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;;; Clojure Refartoring Awesomeness, you know.
(require 'clj-refactor)
(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; (eval-after-load 'clojure-mode
;;   '(font-lock-add-keywords
;;     'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "λ")
;;                                nil))))))

;; (eval-after-load 'clojure-mode
;;   '(font-lock-add-keywords
;;     'clojure-mode `(("\\(#\\)("
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "ƒ")
;;                                nil))))))

;; (eval-after-load 'clojure-mode
;;   '(font-lock-add-keywords
;;     'clojure-mode `(("\\(#\\){"
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "∈")
;;                                nil))))))

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

;;; magit
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


;;; Git Gutterys
(require 'git-gutter)
(global-git-gutter-mode +1)
;; If you would like to use git-gutter.el and linum-mode
;(git-gutter:linum-setup)

;; background color ,modified for monokai
;(set-face-foreground 'git-gutter:modified "#282828") monokai default color
(set-face-background 'git-gutter:deleted (face-attribute 'default :background)) 
(set-face-foreground 'git-gutter:deleted (face-attribute 'font-lock-comment-face :foreground))
(set-face-background 'git-gutter:modified (face-attribute 'default :background))
(set-face-foreground 'git-gutter:modified (face-attribute 'font-lock-comment-face :foreground))
(set-face-background 'git-gutter:added (face-attribute 'default :background))
(set-face-foreground 'git-gutter:added (face-attribute 'font-lock-comment-face :foreground))

(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)


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

(key-chord-define-global ",," 'previous-buffer)

;(key-chord-define-global "@@" 'cider-restart)
(key-chord-define-global "$$" 'project-explorer-open)
(key-chord-define-global "xx" 'execute-extended-command)

(setq cider-test-show-report-on-success t)
(define-key clojure-mode-map (kbd "C-x c") 'cider-eval-last-sexp-to-repl)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-last-sexp)


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
(setq  cursor-in-non-selected-windows nil)
;;set the background-color of selected region

;; make a clear selection color
(set-face-attribute 'region nil :background "#a0c0f0")
;;window management
;; highlight the window number in pink color

;;ui performance improvement
(setq redisplay-dont-pause t)

;;I like darkep background
;(set-background-color "#1b1d1e")
;(set-background-color "#14171A")
(set-face-attribute 'fringe nil :background (face-attribute 'default :background))
(set-face-attribute 'vertical-border nil :foreground (face-attribute 'fringe :background))

;;; linum specific
;(require 'linum)

;; (set-face-attribute 'linum nil
;;                     :background (face-attribute 'default :background)
;;                     :foreground (face-attribute 'font-lock-comment-face :foreground))
;(global-linum-mode +1) 
;(setq linum-format " %4d ")

;;; annoying white vectical thing
;(set-face-attribute 'vertical-border nil :foreground (face-attribute 'fringe :background))
;(set-face-attribute 'fringe nil :foreground "gray60" :background "#14171A" :inverse-video nil :box '(:line-width 1 :color "gray20" :style nil))

;; Extra mode line faces
;;; ok, I am confident with my spellings

;;; clear within the eshell to clear the entire buffer.
(defun eshell/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(setq warning-minimum-level :emergency)
;;; python
(package-initialize)                    
(elpy-enable)
(require 'python)
(require 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--pylab")

(defun send-line-or-region ()
  (interactive)
  (if (region-active-p)
      (call-interactively 'elpy-shell-send-region-or-buffer)
    (python-shell-send-string (thing-at-point 'line))))

(define-key elpy-mode-map (kbd "C-c C-c") 'send-line-or-region)

;;; better completion for projectile
(setq projectile-completion-system 'grizzl)

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
        (system-time-locale "en_US"))
    (insert (format-time-string format))))

(global-set-key (kbd "C-c 1") 'insert-date)

(defun settings ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun reload-settings ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun fish-settings ()
  (interactive)
  (find-file "/work/Clojure/dotfiles/config.fish"))

(defun lein-settings ()
  (interactive)
  (find-file "~/.lein/profiles.clj"))

(global-set-key (kbd "C-c I") 'settings)

(column-number-mode 1)
;(require 'powerline)
;(powerline-default-theme)

(require 'origami)

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\grimoire*\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

(require 'popup)
(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))

;;; expand the region if necesarry
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;; grep project
(require 'swiper)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
;(global-set-key (kbd "C-c t") 'counsel-load-theme)

;;; Hydra window management
(require 'hydra)
(require 'windmove)
(global-set-key
   (kbd "C-x t")
   (defhydra hydra-toggle (:color teal)
     "
_a_ abbrev-mode:      %`abbrev-mode
_d_ debug-on-error    %`debug-on-error
_f_ auto-fill-mode    %`auto-fill-function
_t_ truncate-lines    %`truncate-lines

"
     ("a" abbrev-mode nil)
     ("d" toggle-debug-on-error nil)
     ("f" auto-fill-mode nil)
     ("t" toggle-truncate-lines nil)
     ("q" nil "cancel")))

(defun hydra-move-splitter-left (arg)
    "Move window splitter left."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'right))
        (shrink-window-horizontally arg)
      (enlarge-window-horizontally arg)))

(defun hydra-move-splitter-right (arg)
  "Move window splitter right."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (enlarge-window-horizontally arg)
    (shrink-window-horizontally arg)))

(defun hydra-move-splitter-up (arg)
  "Move window splitter up."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (enlarge-window arg)
    (shrink-window arg)))

(defun hydra-move-splitter-down (arg)
  "Move window splitter down."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (shrink-window arg)
    (enlarge-window arg)))

(global-set-key
   (kbd "C-M-a")
   (defhydra hydra-window (:color amaranth)
     "
Move Point^^^^   Move Splitter   ^Ace^                       ^Split^
--------------------------------------------------------------------------------
_w_, _<up>_      Shift + Move    _C-a_: ace-window           _2_: split-window-below
_a_, _<left>_                    _C-s_: ace-window-swap      _3_: split-window-right
_s_, _<down>_                    _C-d_: ace-window-delete    ^ ^
_d_, _<right>_                   ^   ^                       ^ ^
You can use arrow-keys or WASD.
"
     ("2" split-window-below nil)
     ("3" split-window-right nil)
     ("a" windmove-left nil)
     ("s" windmove-down nil)
     ("w" windmove-up nil)
     ("d" windmove-right nil)
     ("A" hydra-move-splitter-left nil)
     ("S" hydra-move-splitter-down nil)
     ("W" hydra-move-splitter-up nil)
     ("D" hydra-move-splitter-right nil)
     ("<left>" windmove-left nil)
     ("<down>" windmove-down nil)
     ("<up>" windmove-up nil)
     ("<right>" windmove-right nil)
     ("<S-left>" hydra-move-splitter-left nil)
     ("<S-down>" hydra-move-splitter-down nil)
     ("<S-up>" hydra-move-splitter-up nil)
     ("<S-right>" hydra-move-splitter-right nil)
     ("C-a" ace-window nil)
     ("u" hydra--universal-argument nil)
     ("C-s" (lambda () (interactive) (ace-window 4)) nil)
     ("C-d" (lambda () (interactive) (ace-window 16)) nil)
     ("q" nil "quit")))

;;; Setup windowing
(global-unset-key (kbd "M-p"))
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

(global-set-key (kbd "M-p") 'ace-window)

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
(global-set-key (kbd  "C-x C-\\") 'goto-last-change)

;; (defun clojure-test-filename ()
;;   (concat (projectile-project-root) 
;;           "test/" 
;;           (mapconcat #'identity
;;                      (butlast (split-string (cider-current-ns) "\\.")) "/")
;;           "/"
;;           (file-name-nondirectory (file-name-sans-extension (buffer-file-name)))
;;           "_test.clj"))

;; (defadvice projectile-toggle-between-implementation-and-test (around create-clojure-test-advice)
;;   "Visit new file if can't find test"
;;   (condition-case nil
;;       ad-do-it
;;     (error (find-file (clojure-test-filename)))))

;; (ad-activate 'projectile-toggle-between-implementation-and-test)
(require 'scala-mode2)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'clojure-mode-hook 'fci-mode)
;;cleanup modeline
(load-file "~/.emacs.d/modeline.el")


(defvar sk-big-fringe-mode nil)
(define-minor-mode sk-big-fringe-mode
  "Minor mode to hide the mode-line in the current buffer."
  :init-value nil
  :global t
  :variable sk-big-fringe-mode
  :group 'editing-basics
  (if (not sk-big-fringe-mode)
      (set-fringe-style nil)
    (set-fringe-mode
     (/ (- (frame-pixel-width)
           (* 100 (frame-char-width)))
        2))))

(require 'fill-column-indicator)
(setq fci-style 'rule)
(setq fci-rule-width 1)
(setq fci-rule-color (face-attribute 'default :background))
(fci-mode t)


;(setq-default fill-column 99999)
(setq-default fill-column 100)
(setq-default indicate-empty-lines nil)
(setq-default word-wrap t)
;;; annoying as fuck.
(visual-line-mode nil)

;;; web stuff
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

