3;;; r2pipe.el --- r2pipe for emacs -*- lexical-binding: t -*-

;; Author: Tassos Manganaris
;; Maintainer: Tassos Manganaris
;; Version: 0.1
;; Package-Requires: ()
;; Homepage:
;; Keywords: radare, radare2, reverse engineering


;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; r2pipe for emacs

;; start with making a radare2 subprocess under emacs.

;; write a command to that process by sending a newline terminated string to
;; it's stdin and flushing.
;; f : String -> Process -> IO ()

;; read the result by collecting the output from the process's stdout.
;; f : Process -> IO (String)

;;; Code:

(defvar r2-bin-path "/home/tassos/.guix-profile/bin/r2")
(defvar latest-output nil)

(defun my-process-filter (process output)
  (setq latest-output output))

(defun r2open (file)
  (make-process :name "r2pipe" :buffer "r2pipe"
                :command (list r2-bin-path "-q0" file)
                :connection-type 'pipe
                :filter 'my-process-filter
                :stderr (get-buffer-create "r2-stderr")))

(defun r2write (process cmd)
  (process-send-string process (concat cmd "\n")))

(defun r2read ()
  latest-output)

(defun r2cmd (process cmd)
  (r2write process cmd)
  (r2read))

(provide 'r2pipe)

;;; r2pipe.el ends here
