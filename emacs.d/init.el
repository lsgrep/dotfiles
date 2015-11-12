;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
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
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   (quote
    ("196cc00960232cfc7e74f4e95a94a5977cb16fd28ba7282195338f68c84058ec" default)))
 '(fci-rule-color "#383838")
 '(git-gutter:added-sign "++ ")
 '(git-gutter:deleted-sign "-- ")
 '(git-gutter:modified-sign "** ")
 '(git-gutter:window-width 3)
 '(package-selected-packages
   (quote
    (smart-mode-line-powerline-theme smart-mode-line beacon zenburn company-emoji focus osx-dictionary idle-highlight-mode theme-changer moe-theme zenburn-theme jsx-mode gotham-theme atom-one-dark-theme atom-dark-theme 4clojure ample-theme emmet-mode anaconda-mode ensime scala-mode2 scala-mode GOTO-last-change gist highlight-parentheses helm-projectile olivetti auto-yasnippet SMEX rainbow-mode helm counsel rainbow-delimeters company clojure-mode paredit swiper pylint pyflakes ace-window popup swiper-helm smartparens rainbow-delimiters python-mode projectile project-explorer origami monokai-theme molokai-theme markdown-mode magit-gitflow lorem-ipsum key-chord grizzl git-gutter flycheck expand-region elpy cyberpunk-theme clojure-snippets clj-refactor cider-eval-sexp-fu)))
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
 'idle-highlight-mode
 'company
 'spaceline
 'fill-column-indicator
 'elpy
 'beacon
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
 'gist
 'highlight-parentheses
 'monokai-theme
 'flycheck
 'counsel
 'use-package
 'goto-last-change
 'ace-window
 'scala-mode2
 'aggressive-indent
 'ensime)

(projectile-global-mode)
(key-chord-mode 1)
(smartparens-global-mode)
(rainbow-mode 1)

;;; my dick is short ,so is my life
(defalias 'yes-or-no-p 'y-or-n-p)
;;; no bullshit
(delete-selection-mode t)

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

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
;; Key bindings
;(require 'dash-at-point)
(global-set-key (kbd "C-c d") 'dash-at-point)
(global-set-key (kbd "C-c e") 'dash-at-point-with-docset)

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
(set-frame-font "Monaco 16")
(load-theme 'monokai);;https://github.com/tonsky/FiraCodex
(set-background-color "#1b1d1e")
(set-face-foreground 'font-lock-comment-face "#465457")
(set-face-foreground 'font-lock-comment-delimiter-face "#465457")
(set-face-foreground 'font-lock-doc-face "#757575")

;;;  change command and option key 
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;;; you know dvorak 
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

(require 'use-package)
(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.edn\\'" . clojure-mode))
  :init
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook #'yas-minor-mode)         
  (add-hook 'clojure-mode-hook #'subword-mode)           
  (add-hook 'clojure-mode-hook #'smartparens-mode)
  (add-hook 'clojure-mode-hook #'paredit-mode)       
  (add-hook 'clojure-mode-hook #'eldoc-mode)
  (add-hook 'clojure-mode-hook #'idle-highlight-mode)
  (add-hook 'clojure-mode-hook (lambda () (setq dash-at-point-docset "clojure"))))

(use-package cider
  :ensure t
  :defer t
  :init (add-hook 'cider-mode-hook #'clj-refactor-mode)
  :diminish subword-mode
  :config
  (setq nrepl-log-messages t
        cider-auto-select-error-buffer nil
        cider-repl-display-in-current-window nil
        cider-repl-use-clojure-font-lock t    
        cider-prompt-save-file-on-load 'always-save
        cider-font-lock-dynamically '(macro core function var)
        nrepl-hide-special-buffers t
        cider-repl-result-prefix ";; => "
        cider-overlays-use-font-lock t)
  
  (cider-repl-toggle-pretty-printing))

(use-package cider-eval-sexp-fu
  :defer t)

(use-package clj-refactor
  :defer t
  :ensure t
  :diminish clj-refactor-mode
  :config (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package smartparens
  :defer t
  :ensure t
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


;;; Comfuckingpany
(global-company-mode)
(setq company-tooltip-align-annotations t)
(setq company-idle-delay 0.3)
(setq company-dabbrev-ignore-case nil)
(setq company-dabbrev-downcase nil)
(setq company-tooltip-flip-when-above t)
(setq company-dabbrev-code-other-buffers 'code)


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
(set-face-attribute 'region nil :background "#454545")
;;window management
;; highlight the window number in pink color

;;ui performance improvement
(setq redisplay-dont-pause t)

;;I like darkep background
(set-face-attribute 'fringe nil :background (face-attribute 'default :background))
(set-face-attribute 'vertical-border nil :foreground (face-attribute 'fringe :background))

;(global-linum-mode +1) 
;(setq linum-format " %4d ")

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

;(require 'powerline)
;(powerline-default-theme)
(require 'origami)

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\grimoire*\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

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
;(load-file "~/.emacs.d/modeline.el")
(add-to-list 'load-path "~/.emacs.d/dash-at-point.el")
(autoload 'dash-at-point "dash-at-point.el"
          "Search the word at point with Dash." t nil)

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
(setq-default fill-column 100)

(setq-default indicate-empty-lines nil)
;;; annoying as fuck.
(global-visual-line-mode -1)

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

(setq-default truncate-lines nil)
(setq truncate-partial-width-windows nil)
(set-fringe-mode '(1 . 1))


;;; save when necessarry 
(defun save-all ()
  (interactive)
  (save-some-buffers t))
(setq-default truncate-lines t)
(add-hook 'focus-out-hook 'save-all)
(global-aggressive-indent-mode 1)
;;; the thing shows up makes you happy and cozy.
(beacon-mode 1)

(setq sml/no-confirm-load-theme t)
                                        ;(setq sml/theme 'smart-mode-line-powerline)
(setq sml/theme 'dark)
(sml/setup)


;;let
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . " α")
    (yas/minor-mode . " υ")
    (paredit-mode . " π")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (git-gutter-mode . "")
    ;; Major modes
    (lisp-interaction-mode . " λλ")
    (clojure-mode . " λ")
    (hi-lock-mode . "")
    (python-mode . " Py")
                                        ; (projectile-mode . " PJ")
    (emacs-lisp-mode . " EL")
    (nxhtml-mode . " nx"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")


(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                  (mode-str (cdr cleaner))
                  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str))
             ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))


(add-hook 'after-change-major-mode-hook 'clean-mode-line)


(set-face-attribute 'mode-line nil
                    :foreground "gray60" :background (face-attribute 'default :background)
                    :inverse-video nil    :box nil)

(set-face-attribute 'mode-line-inactive nil    :foreground "gray60" :background (face-attribute 'default :background) 
                    :inverse-video nil    :box nil) 

(nyan-mode t)
