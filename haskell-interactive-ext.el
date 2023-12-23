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


(defun haskell-eval-line ()
  "Evaluate the current line in the Haskell REPL."
  (interactive)
  (with-current-buffer (current-buffer)
    (haskell-interactive-copy-to-prompt)
    (haskell-interactive-switch)
    (save-excursion
      (goto-char (point-max))
      (end-of-line)))
  (haskell-interactive-mode-return)
  (haskell-interactive-switch-back))


;;(defun haskell-eval-line-or-region ()
;;

;; Configuration options
(defcustom haskell-interactive-auto-switch t
  "Automatically switch to the REPL after evaluation."
  :type 'boolean
  :group 'haskell-interactive
  :local t)

(provide 'haskell-interactive-ext)
;;; haskell-interactive-ext.el ends here