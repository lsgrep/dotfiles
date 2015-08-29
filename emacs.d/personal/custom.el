(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
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
(ensure-package-installed 'htmlize
                          'window-numbering
                          'git-gutter
                          'window-number
                          'project-explorer
                          'paredit
                          'cider
                          'cider-eval-sexp-fu
                          'speed-type
                          'cyberpunk-theme
                          'magit-gitflow
                          'monokai-theme
                          'clj-refactor)
;;init
(package-initialize)
;;this has to be on top. or modications require confirmation

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "a444b2e10bedc64e4c7f312a737271f9a2f2542c67caa13b04d525196562bf38" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "83e584d74b0faea99a414a06dae12f11cd3176fdd4eba6674422539951bcfaa8" default)))
 '(git-gutter:added-sign " +")
 '(git-gutter:deleted-sign " -")
 '(git-gutter:modified-sign " *")
 '(package-selected-packages
   (quote
    (window-number ipython elpy powerline color-theme-sanityinc-tomorrow zenburn rotate ac-cider cyberpunk-theme cyberpunk zop-to-char zenburn-theme window-numbering web-mode volatile-highlights vkill undo-tree speed-type smex smartrep smartparens slime rainbow-mode rainbow-delimiters project-explorer ov operate-on-number move-text monokai-theme mediawiki markdown-mode magit-gitflow key-chord json-mode js2-mode ido-ubiquitous htmlize helm-projectile helm-descbinds helm-ag haskell-mode guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine git-gutter gist geiser flycheck flx-ido expand-region exec-path-from-shell elisp-slime-nav easy-kill discover-my-major diminish company-auctex company-anaconda coffee-mode clj-refactor cdlatex browse-kill-ring anzu ace-window))))

;;ui tweaks
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(global-hl-line-mode +1)

;; personal styling
(set-default-font "Hermit 16")
(load-theme 'cyberpunk);;https://github.com/tonsky/FiraCodex

;(set-face-attribute 'default nil :height 140)
(scroll-bar-mode -1)
;; show line numbers

;(global-linum-mode +1)
;(set-face-background 'linum "#1b1d1e")
;(set-face-foreground 'linum "#333333)"

;(setq linum-format " ")

;(setq linum-format " \u2442 ")
;(setq linum-format "%4d  ")

;; change command and option key
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; you know mac
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

(setenv "PATH"
        (concat
         "/usr/local/bin/" ":"
         (getenv "PATH") ; inherited from OS
         ))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
;;let's add real shortcut for eshell

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

;(setq cider-refresh-before-fn "user/stop-system!" cider-refresh-after-fn "user/start-system!")
;(setq cider-known-endpoints '(("host-a" "10.10.10.1" "7888") ("host-b" "7888")))


(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)
(global-company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

(setq company-idle-delay 0.3) ; never start completions automatically
(global-set-key (kbd "M-TAB") #'company-complete) ; use meta+tab, aka C-M-i, as manual trigger
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
(require 'erc-join)
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(erc-autojoin-mode 1)
(setq erc-max-buffer-size 700000)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs"  "#statistics"
         "#R"  "#machinelearning"  "#lisp"  "#git"
         "#networking" "#reactjs" "#clojure")))


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
(set-face-foreground 'git-gutter:modified "#1b1d1e")
(set-face-background 'git-gutter:modified "#777777")
(set-face-foreground 'git-gutter:added "#1b1d1e")
(set-face-background 'git-gutter:added "#777777")
(set-face-foreground 'git-gutter:deleted "#1b1d1e")
(set-face-background 'git-gutter:deleted "#777777")




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
(key-chord-define-global ",," 'prelude-switch-to-previous-buffer)
(key-chord-define-global "aa" 'helm-mini)
;(key-chord-define-global "@@" 'cider-restart)
(key-chord-define-global "$$" 'project-explorer-open)
;(key-chord-define-global "zz" 'cider-connect)

(setq cider-test-show-report-on-success t)

(require 'cider-mode)
(require 'clojure-mode)
(define-key clojure-mode-map (kbd "C-x c") 'cider-eval-last-sexp-to-repl)
(define-key clojure-mode-map (kbd "C-x F") 'cider-format-buffer)
(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)

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

(defun mbp-clojure-mode-keybindings ()

  (local-set-key (kbd "<f1>") 'nrepl-reset)
  (local-set-key (kbd "<f2> <return>") 'nrepl-refresh))

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
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

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
(set-face-attribute 'region nil :background "#787878")
;;window management
;; highlight the window number in pink color
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.")
;;ui performance improvement
(setq redisplay-dont-pause t)

;;I like darkep background
(set-background-color "#1b1d1e")
(set-face-background 'fringe "#1b1d1e")

(set-face-attribute 'mode-line nil
                    :foreground "gray60" :background "gray10"
                    :inverse-video nil
                    :box '(:line-width 1 :color "gray20" :style nil))

(set-face-attribute 'mode-line-inactive nil
                    :foreground "gray60" :background "gray10"
                    :inverse-video nil
                    :box '(:line-width 1 :color "gray20" :style nil))

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
(global-diff-hl-mode -1)

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
(yas-global-mode 1)

(exec-path-from-shell-initialize)


(window-numbering-mode +1)
