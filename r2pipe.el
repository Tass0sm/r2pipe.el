3;;; r2pipe.el --- r2pipe for emacs -*- lexical-binding: t -*-

;; Author: Tassos Manganaris
;; Maintainer: Tassos Manganaris
;; Version: 0.1
;; Package-Requires: ()
;; Homepage: https://github.com/Tass0sm/r2pipe.el
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

;;; Code:

(defgroup r2pipe nil
  "Run and interact with radare2 under Emacs."
  :prefix "r2pipe-"
  :group 'tools)

(defcustom r2-bin-path "/usr/bin/r2"
  "The path to the radare2 program.")

(setq latest-output nil)

(defun r2--copy-output-filter (process output)
  (setq latest-output output))

(defun r2open (file)
  (make-process :name "r2pipe" :buffer "r2pipe"
                :command (list r2-bin-path "-q0" file)
                :connection-type 'pipe
                :filter 'my-process-filter
                :stderr (get-buffer-create " r2-stderr")))

(defun r2write (process cmd)
  (process-send-string process (concat cmd "\n")))

(defun r2cmd (process cmd)
  (r2write process cmd)
  (sit-for 0.5)
  latest-output)

(provide 'r2pipe)

;;; r2pipe.el ends here
