;; What are we using?? (from http://www.xsteve.at/prg/emacs/.emacs.txt)
(defconst win32p
    (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")
(defconst aquap (featurep 'aquamacs) "Are we using AquaEmacs?")
(defconst macp (eq system-type 'darwin) "Are we running in Mac OS?")
(defconst cygwinp
    (eq system-type 'cygwin)
  "Are we running on a WinTel cygwin system?")
(defconst linuxp
    (or (eq system-type 'gnu/linux)
        (eq system-type 'linux))
  "Are we running on a GNU/Linux system?")
(defconst unixp
  (or linuxp
      (eq system-type 'usg-unix-v)
      (eq system-type 'berkeley-unix))
  "Are we running unix")
(defconst linux-x-p
    (and window-system linuxp)
  "Are we running under X on a GNU/Linux system?")
;; Aquamacs settings
(if aquap
    ((lambda ()
       (setq mac-command-modifier 'super)
       (setq mac-option-modifier 'meta)
       (setq mac-input-method-mode t)
       (setq default-input-method "MacOSX")
       (one-buffer-one-frame-mode -1)
)))

;; Which computer I am using?
(defconst cirrus (string-equal system-name "cirrus.pa.uky.edu")
  "Am I using cirrus?")

;;========== Add Load Path ============>
(let ((ModeDir "~/.emacs.d"))
  (add-to-list 'load-path (expand-file-name ModeDir))
  (let ((Modes
		 '("cloudy" "gnuplot" "rainbow" "rainbow-delimiters"
           "auto-complete" "magit" "auctex" "emacs-powerline"
           "powerline")))
	(dolist (Mode Modes)
	  (add-to-list 'load-path (expand-file-name
                               (concat ModeDir "/" Mode))))
	)
  )

(add-to-list 'custom-theme-load-path
             (expand-file-name "~/.emacs.d/themes/"))

;;=============== Theme ===============================>
(if macp
    (if cirrus
        (progn
          (add-to-list 'default-frame-alist '(height . 75))
          (add-to-list 'default-frame-alist '(width . 120))
          (setq initial-frame-alist '((top . 370) (left . 1650)))
          )
      (progn
        (add-to-list 'default-frame-alist '(height . 45))
        (add-to-list 'default-frame-alist '(width . 80))
        (setq initial-frame-alist '((top . 10) (left . 650)))
        )
      )
  )
;;(if window-system
;;    (load-theme 'mysteryplanet t))


(load-theme 'mysteryplanet t)


;; =============== Coding and Language ===============>
;; (set-selection-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8) ; if utf8, unable to use input method.
;; (set-language-environment 'utf-8)
;; (setq locale-coding-system 'utf-8)
;; (setq current-language-environment "utf-8")
;; (setq locale-language-names
;;       (cons '("zh_CN.UTF-8" "UTF-8" utf-8) locale-language-names))
;; Fix the width of Chinese marks.
(if linuxp
    (let ((l '(chinese-gb2312
	       gb18030-2-byte
	       gb18030-4-byte-bmp
	       gb18030-4-byte-ext-1
	       gb18030-4-byte-ext-2
	       gb18030-4-byte-smp)))
      (dolist (elt l)
	(map-charset-chars #'modify-category-entry elt ?|)
	(map-charset-chars
	 (lambda (range ignore)
	   (set-char-table-range char-width-table range 2))
	 elt))))

;;========== Basic Settings ============>
(setenv "COLUMNS" "80")
(setq user-full-name "Lancelot")
(setq user-mail-address "wangye0206@gmail.com")
(setq mail-user-agent 'message-user-agent)
(setq default-major-mode 'text-mode)
(setq default-tab-width 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq column-number-mode t)
(setq kill-ring-max 255)
(setq next-screen-context-line 5)
(setq display-time-day-and-data t)
(setq sentence-end "\\([。？！；]\\|……\\|[.?!;][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space t)
(setq frame-title-format "Lancelot's GNU Emacs 24 <%b>")
(setq auto-window-vscroll nil)
;; let the delete key delete foreward
(if linux-x-p
    (normal-erase-is-backspace-mode 1))
;; X primary selection has priority.  For emacs 24.1
(if linux-x-p
    (setq x-select-enable-primary t))

(add-hook 'text-mode-hook
          (lambda () (auto-fill-mode t)))

;; time stamp
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-format "%:u %04y-%02m-%02d %02H:%02M:%02S")
(setq time-stamp-end:"\n")

;;Add a New Line in the End if None
(setq require-final-newline t)

;;Use Enter as Newline and Indent
(global-set-key "\r" 'newline-and-indent)

;;Use y or n Instead All yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Grammar Hightlighting
(global-font-lock-mode 1)
;;Trun on Auto Save Function
(setq auto-save-default t)
;;Enable Narrow
(put 'narrow-to-region 'disabled nil)
;;Move Mouse When It Block the Typing
(mouse-avoidance-mode 'animate)
;;Automatically Identify Image Files
(auto-image-file-mode)
;;Replace Selected Text When Typing
(delete-selection-mode t)
;;Spectial Characters
(setq default-input-method "TeX")

;;Remove *bar...
(tool-bar-mode 0)
(if (not macp) (menu-bar-mode 0))
(scroll-bar-mode -1)
;; No sound alarm
(setq visible-bell t)

;;Use External 'ls' Rather than 'ls-lisp'
(setq ls-lisp-use-insert-directory-program t)
;;Non-nil if Searches and Matches Should Ignore Case
(setq case-fold-serrch t)
;;Debug When Error
(setq debug-on-error t)
;;Fringe
(setq fringe-mode 'left-only)
(setq-default right-fringe-width 0)
(setq default-indicate-buffer-boundaries '((top . left) (t . left)))
;;Dired
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)
(setq dired-dwim-target t)
;;In Transient Mark Mode, when the Mark is Active, the Region is Highlighted
(setq transient-mark-mode t)
;;Backup Control
(setq kept-old-versions 2)
(setq kept-new-versions 3)
(setq backup-directory-alist '(("." . "~/.backup/")))
(setq backup-by-copying t)
;;Spell Checking
(setq-default ispell-program-name
              (cond (linuxp "aspell")
                    (macp "/usr/local/bin/aspell")))
(add-hook 'text-mode-hook 'flyspell-mode)
;;Delete Duplicates in Minibuffer History
(setq history-delete-duplicates t)

;; Powerline
(require 'cl)
(require 'powerline)
;; Version control Settings
(require 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(require 'magit)
;;Shell Mode Settings
(setq comint-scroll-to-bottom-on-input t)
(setq comint-prompt-read-only t)
(setq comint-input-ignoredups t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;GDB
(setq gdb-show-main t)
(setq gdb-many-windows t)
;; Load GNUs functions
(require 'gnus)
;;Auto Show Matching Brace
(require 'paren)
(show-paren-mode 1)
;; CUA mode
(cua-mode t)
(setq cua-enable-cua-keys nil)
;;Do not Add a New String to 'kill-ring' When It Is the Same as the Last One
(setq kill-do-ot-save-duplicates t)
;; Don't open new frame when open file by dragging and emacsclient in
;; Mac.
(if macp (setq ns-pop-up-frames nil))

;;=========== C Mode =======================>
(add-hook 'c-mode-common-hook
          (lambda () (c-toggle-auto-hungry-state 1)))

;;CC Indention
;;(setq indent-tabs-mode nil)
;;(setq default-tab-width 4)

(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")
;; offset customizations not in my-c-style
(setq c-offsets-alist '((member-init-intro . ++)))
;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c-style t)
  ;; other customizations
  (setq tab-width 4
        ;; use tabs as indent
        indent-tabs-mode t)
  ;; we like auto-newline and hungry-delete
;  (c-toggle-auto-hungry-state 1)
  ;; key bindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'c-context-line-break)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook) 
;; whether the indentation should be controlled by the syntactic context
(setq c-syntactic-indentation t)
;; Make make command print directory information
(setq compile-command "make -w")

;;=========== Other Programming Settings =======================>
;; Subword
(add-hook 'c-mode-common-hook
          (lambda () (subword-mode 1)))
(add-hook 'python-mode-hook
          (lambda () (subword-mode 1)))

;; Whitespace mode
(require 'whitespace)
(setq-default whitespace-style
              '(tabs trailing lines space-before-tab))
(setq-default whitespace-active-style
              '(tabs trailing lines space-before-tab))
(add-hook 'emacs-lisp-mode-hook 'whitespace-mode)
(add-hook 'cc-mode-hook 'whitespace-mode)
(add-hook 'c-mode-hook 'whitespace-mode)
(add-hook 'c++-mode-hook 'whitespace-mode)
(add-hook 'python-mode-hook 'whitespace-mode)

;; Hide show mode (from emacswiki)
(defun toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (or column
       (unless selective-display
             (1+ (current-column))))))
(defun toggle-hiding (column)
  (interactive "P")
  (if hs-minor-mode
      (if (condition-case nil
              (hs-toggle-hiding)
            (error t))
          (hs-show-all))
    (toggle-selective-display column)))

(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'python-mode-hook     'hs-minor-mode)

;; CSS Mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
     (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;;Gnuplot Mode
(require 'gnuplot-mode)
(setq auto-mode-alist (append '(("\\.plot$" . gnuplot-mode)) auto-mode-alist))


;; =============== External non-programming modes ===============>
;; htmlize
;;(require 'htmlize)
;;(setq htmlize-output-type 'css)

;; ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; Grouping
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("TeX" (name . ".*\\.tex$"))
               ("Dired" (mode . dired-mode))
               ("Programming" (or
                               (mode . python-mode)
                               (mode . pov-mode)
                               (mode . asy-mode)
                               (mode . c-mode)
                               (mode . c++-mode)
                               (mode . emacs-lisp-mode)
                               (mode . scheme-mode)
                               (mode . sh-mode)
                               (mode . makefile-mode)
                               ))
               ("Process" (mode . comint-mode))
               ("Gnus" (or
                        (mode . message-mode)
                        (mode . bbdb-mode)
                        (mode . mail-mode)
                        (mode . gnus-group-mode)
                        (mode . gnus-summary-mode)
                        (mode . gnus-article-mode)
                        (name . "^\\.bbdb$")
                        (name . "^\\.newsrc-dribble")))
               ("ERC" (mode . erc-mode))
               ("Planner" (or
                           (name . "^\\*Calendar\\*$")
                           (name . "^diary$")
                           (mode . muse-mode)))
               ("Emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (name . "^\\*GNU Emacs\\*$")
                         (name . "^\\*Completions\\*$")
                         (mode . apropos-mode)
                         (mode . help-mode)
                         ))
               ))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; tooltips
;;(require 'pos-tip)

;; hippie-expand (M-/)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (concat (getenv "HOME")
                     "./.emacs.d/auto-complete/ac-dict"))
(ac-config-default)
(ac-set-trigger-key "M-/")
(setq ac-auto-show-menu nil)
(setq ac-sources '(ac-source-words-in-same-mode-buffers
                  ac-source-symbols
                  ac-source-filename
                  ac-source-functions
                  ac-source-yasnippet
                  ac-source-variables
                  ac-source-symbols
                  ac-source-features
                  ac-source-abbrev
                  ac-source-dictionary))
(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
;;(define-key ac-menu-map (kbd "M-/") 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;; Disable enter completion
(define-key ac-completing-map (kbd "RET") nil)

;; Restore previous session
;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)

;; add the last component of thepath to the filename to distinguish different files with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Rainbow mode
(require 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)

;; Rainbow-Delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; Ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; Display line number
(require 'linum)
(global-linum-mode t)
(defun toggle-linum ()           ; Toggle line numbering
  (interactive)
  (if linum-mode (linum-mode nil)
    (linum-mode t)))

;; shell-command with completion
;;(require 'shell-command)
;;(shell-command-completion-mode)

;; Anything
;;(require 'anything)

;; Protect buffers
;;(require 'keep-buffers)
;;(keep-buffers-erase-on-kill nil)
;;(keep-buffers-protect-buffer "*scratch*") 
;;(keep-buffers-protect-buffer "*Messages*")

;;Command-log mode
(autoload 'command-log-mode "command-log-mode" "Load command-log-mode minor mode")
(autoload 'global-command-log-mode "command-log-mode" "Load command-log-mode global mode")

;;Cloudy Mode
(autoload 'cloudy-mode "cloudy" "cloudy major mode" t)
(autoload 'Cloudy-make-buffer "cloudy" "open a buffer in cloudy mode" t)
(setq auto-mode-alist (append '(("\\.in$" . cloudy-mode)) auto-mode-alist))


;;=========== Home-made Functions =======================>
(defun match-paren (arg)
  "Go to the matching paren if on aparen; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; Unfill buffer
(defun unfill-buffer ()
  "Unfill current buffer."
  (interactive "")
  (setq m (point-marker))
  (beginning-of-buffer)
  (while (re-search-forward "\\([^ ]+\\) *
 *\\([^ ]\\)" nil t)
    (replace-match "\\1 \\2"))
  (set-marker m 0 (current-buffer)))

;; Word count
(defun word-count nil "Count words in buffer" (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

;; Find chars that not belong to the charset, copied from
;; http://ann77.stu.cdut.edu.cn/EmacsChineseCalendar.html
(defun find-invalid-char ()
  (interactive)
  (let (c m)
    (save-excursion
      (widen)
      (condition-case nil
          (progn
            (setq c (following-char))
            (while c
              (if (and (>= c 128)
                       (<= c 256))
                  (error ""))
              (if ( >= (point) (point-max))
                  (error ""))
              (goto-char (1+ (point)))
              (setq c (following-char))))
        (error (setq m (point)))))
    (goto-char m)))

(defun insert-date ()
  "Insert the current date according to the variable\"insert-date-format\"."
  (interactive "*")
  (insert (format-time-string "%Y-%M-%D")))

(defun toggle-line-wrap ()
  "Toggle `visual-line-mode'."
  (interactive)
  (if auto-fill-function
      ((lambda ()
         (turn-off-auto-fill)
         (visual-line-mode 1)))
    ((lambda ()
       (turn-on-auto-fill)
       (visual-line-mode -1)))))

;; Insert aproper pair of quotes
(defun insert-pair-and-retreat (str)
  "Inserts 'str' and go back one character."
  (insert str)
  (backward-char))

(defun insert-single-quotes ()
  "Inserts aproper pair of single quotes."
  (interactive)
  ;; If the last char is "\", inserts a literal char.
  (if (search-backward "\\" (- (point) 1) t)
      (progn (forward-char ) (insert "'"))
    ;; We need to detect if the quote is for, for example, "I'm", etc, or for quotation.
    (if (re-search-backward "[A-Za-z]" (- (point) 1) t)
        (progn (forward-char) (insert "’"))
      (insert-pair-and-retreat "''"))))

(defun insert-double-quotes ()
  "Inserts aproper pair of double quotes."
  (interactive)
  ;; If the lat char is "\", inserts a literal char.
  (if (search-backward "\\" (- (point) 1) t)
      (progn (forward-char) (insert "\""))
    (insert-pair-and-retreat """")))

(defun auto-insert-and-convert-dash ()
  "Converts two dashes into an en-dash, or converts a en-dash followed by adash to an em-dash."
  (interactive)
  ; If the last char is "\", inserts a literal char.
  (if (search-backward "\\" (- (point) 1) t)
      (progn (forward-char) (insert "-"))
    (progn
      (insert "-")
      (if (search-backward "--" (- (point) 2) t)
          (replace-match "-"))
      (if (search-backward "–-" (- (point) 2) t)
          (replace-match "—")))))

(define-key text-mode-map "'" 'insert-single-quotes)
(define-key text-mode-map (kbd "C-'") (lambda () (interactive) (insert ?\")))
(define-key text-mode-map "\"" 'insert-double-quotes)

;; Replace stuff like `lambda', `->' with actual unicode chars.
(defun unicode-symbol (name)
  "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW
  or GREATER-THAN into an actual Unicode character code. "
  (decode-char 'ucs (case name
                      ;; arrows
                      ('left-arrow 8592)
                      ('up-arrow 8593)
                      ('right-arrow 8594)
                      ('down-arrow 8595)
                      ('Right-arrow #x21d2)
                      ;; Math symbols
                      ('integral #x222b)
                      ('oint #x222e)
                      ('sum #x2211)
                      ('product #x220f)
                      ('infinity #x221e)
                      ('equal #X003d)
                      ('not-equal #X2260)
                      ('approximately #x2248)
                      ('identical #X2261)
                      ('not-identical #X2262)
                      ('less-than #X003c)
                      ('greater-than #X003e)
                      ('less-than-or-equal-to #X2264)
                      ('greater-than-or-equal-to #X2265)
                      ('much-less-than #x226a)
                      ('much-greater-than #x226b)
                      ('logical-and #X2227)
                      ('logical-or #X2228)
                      ('logical-neg #X00AC)
                      ('nil #X2205)
                      ('for-all #X2200)
                      ('there-exists #X2203)
                      ('element-of #X2208)
                      ('cdot #x22c5)
                      ;; boxes
                      ('double-vertical-bar #X2551)
                      ;; relational operators
                      ;; logical operators
                      ;; misc
                      ('horizontal-ellipsis #X2026)
                      ('double-exclamation #X203C)
                      ('prime #X2032)
                      ('double-prime #X2033)
                      ('dagger #x2020)
                      ;; mathematical operators
                      ('square-root #X221A)
                      ('squared #X00B2)
                      ('cubed #X00B3)
                      ;; letters
                      ('lambda #X03BB)
                      ('alpha #X03B1)
                      ('beta #X03B2)
                      ('gamma #X03B3)
                      ('delta #X03B4)
                      ('epsilon #X03B5)
                      ('zeta #X03B6)
                      ('eta #X03B7)
                      ('theta #X03B8)
                      ('iota #X03B9)
                      ('kappa #X03BA)
                      ('mu #X03BC)
                      ('nu #X03BD)
                      ('xi #X03BE)
                      ('pi #X03C0)
                      ('rho #X03C1)
                      ('sigma #X03C3)
                      ('tau #X03C4)
                      ('phi #X03C6)
                      ('chi #X03C7)
                      ('psi #X03C8)
                      ('omega #X03C9))))

(defun substitute-pattern-with-unicode (pattern symbol)
  "Add afont lock hook to replace the matched part of PATTERN with the Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
  (interactive)
  (font-lock-add-keywords
   nil `((,pattern (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                             ,(unicode-symbol symbol))
                             nil))))))

(defun substitute-patterns-with-unicode (patterns)
  "call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
  (mapcar #'(lambda (x)
              (substitute-pattern-with-unicode (car x)
                                               (cdr x)))
          patterns))

(defun elisp-unicode ()
  (interactive)
  (substitute-patterns-with-unicode
   (list (cons "(\\(lambda\\>\\)" 'lambda)
         (cons " +\\(nil\\)[ )]" 'nil))))

(add-hook 'emacs-lisp-mode-hook 'elisp-unicode)

;;=============== Global Bindings ====================>
(global-set-key (kbd "M-p") 'previous-buffer)
(global-set-key (kbd "M-n") 'next-buffer)
(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key (kbd "C-=") 'balance-windows)
(global-set-key (kbd "C-x C-a") 'anything)
(global-set-key (kbd "%") 'match-paren)
(global-set-key (kbd "M-RET") 'toggle-line-wrap)

;; ============== add other file =======================>
(load-file (expand-file-name "~/.emacs-tex.el"))
