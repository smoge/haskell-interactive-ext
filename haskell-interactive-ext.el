;;; haskell-interactive-ext.el --- Customized interaction with Haskell REPL -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Bernardo Barros
;;
;; Version: 0.0.1
;; Keywords: languages, haskell, interactive
;; Homepage: https://github.com/smoge/haskell-interactive-ext
;;
;; This file is not part of GNU Emacs.
;;

;;; Commentary:

;; Just a few customization on haskell interactive.

;;; Code:

(require 'haskell)




(defun haskell-eval-line-or-region ()
  "Evaluate the current line or region in the Haskell REPL and return to the buffer."
  (interactive)
  (if (use-region-p)
      (progn
        ;; If region is active, copy it.
        (copy-region-as-kill (region-beginning) (region-end))
        (haskell-interactive-switch)
        (yank)
        (haskell-interactive-mode-return)
        (other-window 1)) ; switch back to original buffer
    ;; Else, copy the current line.
    (haskell-interactive-copy-to-prompt)
    (haskell-interactive-switch)
    (goto-char (point-max))
    (end-of-line)
    (haskell-interactive-mode-return)
    (haskell-interactive-switch-back)))


(define-key haskell-mode-map (kbd "S-<return>") 'haskell-eval-line-or-region)




;; Configuration options
(defcustom haskell-interactive-auto-switch t
  "Automatically switch to the REPL after evaluation."
  :type 'boolean
  :group 'haskell-interactive
  :local t)

(provide 'haskell-interactive-ext)
;;; haskell-interactive-ext.el ends here




;; (require 'subr-x)

;; (defun my-run-haskell-expr ()
;;   "Get haskell expression"
;;   (interactive)
;;   (search-backward "-- >>>")
;;   (setq my-expr
;;         (string-remove-prefix "-- >>>" (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
;;   (my-haskell-interactive-mode-run-expr my-expr)
;;   )

;; (defun my-haskell-interactive-mode-run-expr (expr)
;;   "Run the given expression."
;;   (let ((session (haskell-interactive-session))
;;         (process (haskell-interactive-process)))
;;     (haskell-process-queue-command
;;      process
;;      (make-haskell-command
;;       :state (list session process expr 0)
;;       :go (lambda (state)
;;             ;; (goto-char (point-max))
;;             ;; (insert "\n")
;;             (end-of-line)
;;             (insert "\n")
;;             (beginning-of-line)
;;             (setq haskell-interactive-mode-result-end
;;                   (point-max))
;;             (haskell-process-send-string (cadr state)
;;                                          (haskell-interactive-mode-multi-line (cl-caddr state)))
;;             (haskell-process-set-evaluating (cadr state) t))
;;       :complete
;;       (lambda (state response)
;;         (haskell-process-set-evaluating (cadr state) nil)
;;         (unless (haskell-interactive-mode-trigger-compile-error state response)
;;           (my-haskell-interactive-mode-expr-result state response)))))))

;; (defun my-haskell-interactive-mode-expr-result (state response)
;;   "Print the result of evaluating the expression."
;;   ;; (mapc 'insert (split-string-and-unquote response))
;;   (mapc (lambda (str) (progn
;;                         (insert "-- ")
;;                         (insert str)
;;                         (insert "\n")))
;;         (split-string-and-unquote response "\n")))
