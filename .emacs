;; For information on specific entries, see:
;; http://www.emacswiki.org
;;
;; Remeber:
;;  C-h v and C-h f to see variables and
;;  C-x C-e to evaluate the last sexp
;;

;; -----------------------------------------------------------------------
;; Set modes
;;
(menu-bar-mode 1)                                   ;; Enable the menu bar
(tool-bar-mode 0)                                   ;; disable the tool bar
(blink-cursor-mode t)                               ;; make the cursor blink
(show-paren-mode t)                                 ;; highlight the matching paren
(set-scroll-bar-mode 'right)                        ;; scrollbar to the right side
(line-number-mode t)                                ;; show the line number
(delete-selection-mode t)                           ;; replace highlighted selection when typing
(fset 'yes-or-no-p 'y-or-n-p)                       ;; enables "y" or "n" instead of "yes" and "no"


;; -----------------------------------------------------------------------
;; set global variables
;;
(setq-default
    inhibit-startup-message t                       ;; get rid of the annoying startup messages
    initial-scratch-message nil                     ;; nothing in the scratch
    indent-tabs-mode nil                            ;; don't use TAB characters, except for makefiles
    mouse-wheel-scroll-amount '(3 ((shift) . 3))    ;; 3 lines per mouse wheel
    mouse-wheel-progressive-speed nil               ;; mouse wheel doesn't accelerate
)

;; -----------------------------------------------------------------------
;; appearance
;; These are all C compiled things that setup the default
;; appearance of the emacs window
;;
(setq default-frame-alist
    '(
        (top . 20)
        (left . 20)
        (width . 150)
        (height . 50)
        (cursor-color . "#000000")
        (border-color . "#3f3f3f")
        (background-color . "#ffffff")
        (foreground-color . "#000000")
        (mouse-color . "#000000")
        (scroll-bar-width . 12)
    )
)

;; -----------------------------------------------------------------------
;; mode hooks
;; Most importantly the hook to run when a C++ file is opened.
;; Use this to set up indentation, special keys, etc.
;;
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(defun my-c-mode-common-hook ()
    (c-add-style "MyCStyle"
        '((c-basic-offset . 4)
          (c-offsets-alist . ((case-label . 0)
                              (access-label . -)
                              (innamespace . 0)
                              (substatement-open . 0))))
        t)
    (setq c-tab-always-indent nil)
    (define-key c-mode-base-map [(return)] 'newline-and-indent)
    (message "C Mode Hook Complete")
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'makefile-mode-hook (lambda () (setq indent-tabs-mode t)))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Kill the minibuffer when you mouse out of it
;; gets rid of the "Command attempted to use minibuffer while
;; in minibuffer" annoyance
(add-hook 'mouse-leave-buffer-hook
      (lambda ()
        (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
          (abort-recursive-edit))))

;; -----------------------------------------------------------------------
;; cua mode makes parts of emacs work like windows editors
;; most importantly highlight/cut/copy/paste
;;
(cua-mode t)
(setq cua-auto-tabify-rectangles nil)               ;; Don't tabify after rectangle commands
(transient-mark-mode 1)                             ;; No region when it is not highlighted
(setq cua-keep-region-after-copy nil)               ;; No region after cut/copy/paste

;; -----------------------------------------------------------------------
;; The custom set parts are set by emacs when you do
;; M-x custome-group
;;
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "#000000"))))
 '(font-lock-comment-face ((t (:foreground "#009900"))))
 '(font-lock-constant-face ((t (:foreground "#000000"))))
 '(font-lock-function-name-face ((t (:foreground "#000000"))))
 '(font-lock-keyword-face ((t (:foreground "#0000ff"))))
 '(font-lock-preprocessor-face ((t (:foreground "#0000ff"))))
 '(font-lock-string-face ((t (:foreground "#990000"))))
 '(font-lock-type-face ((t (:foreground "#0000ff"))))
 '(font-lock-variable-name-face ((t (:foreground "#000000"))))
 '(menu ((((type x-toolkit)) (:background "#cccccc"))))
 '(scroll-bar ((t (:foreground "#555555")))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil))
