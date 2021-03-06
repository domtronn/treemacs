;;; treemacs.el --- A tree style file viewer package

;; Copyright (C) 2017 Alexander Miller

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;; Customize interface definitions.

;;; Code:

(defgroup treemacs nil
  "A major mode for displaying the file system in a tree layout."
  :group 'files
  :prefix "treemacs-"
  :link '(url-link :tag "Repository" "https://github.com/Alexander-Miller/treemacs"))

(defgroup treemacs-faces nil
  "Faces for treemacs' syntax highlighting."
  :group 'treemacs
  :group 'faces)

(defgroup treemacs-configuration nil
  "Treemacs configuration options."
  :group 'treemacs
  :prefix "treemacs-")

(defcustom treemacs-indentation 2
  "The number of spaces each level is indented in the tree."
  :type 'integer
  :group 'treemacs-configuration)

(defcustom treemacs-width 35
  "Width of the treemacs buffer."
  :type 'integer
  :group 'treemacs-configuration)

(defcustom treemacs-show-hidden-files t
  "Dotfiles will be shown if this is set to t and be hidden otherwise."
  :type 'boolean
  :group 'treemacs-configuration)

(defcustom treemacs-follow-after-init nil
  "When t always run `treemacs-follow' after building a treemacs-buffer.

A treemacs buffer is built when after calling `treemacs-init' or
`treemacs-projectle-init'. This will ignore `treemacs-follow-mode'."
  :type 'boolean
  :group 'treemacs-configuration)

(defcustom treemacs-header-function 'treemacs--create-header
  "The function which is used to create the header string for treemacs buffers.
Treemacs offers two builtin header creators:
1) `treemacs--create-header' (the default), which will simply output the current
   treemacs root.
2) `treemacs--create-header-projectile', which will first try to find the name of
   the current projectile project and fall back on `treemacs--create-header' if
   no project name is found.
Other than these two functions this value may be made to use any custom function
which takes as input a string (the absolute path of the current treemacs root)
and outputs the string header to be inserted in the treemacs buffer."
  :type 'function
  :group 'treemacs-configuration)

(defcustom treemacs-icons-hash (make-hash-table :test 'equal)
  "Hash table containing a mapping of icons onto file extensions."
  :type 'plist
  :group 'treemacs-configuration)

(defcustom treemacs-git-integration nil
  "When t use different faces for files' different git states."
  :type 'boolean
  :group 'treemacs-configuration)

(defcustom treemacs-dotfiles-regex (rx bol "." (1+ any))
  "Files matching this regular expression count as dotfiles."
  :type 'regexp
  :group 'treemacs-configuration)

(defcustom treemacs-change-root-without-asking nil
  "When t don't ask to change the root when calling `treemacs-find-file'."
  :type 'boolean
  :group 'treemacs-configuration)

(defcustom treemacs-never-persist nil
  "When t treemacs will never persist its state.
By default treemacs' state is written to disk in `treemacs--persist-file' if it
detects a session saving mechanism like desktop save mode so it can be restored
on the next launch."
  :type 'boolean
  :group 'treemacs-configuration)

(defcustom treemacs-sorting 'alphabetic-desc
  "Indicates how treemeacs will sort its files and directories.
Files will still always be shown after directories.
Valid values are
 * alphabetic-asc,
 * alphabetic-desc,
 * size-asc,
 * size-desc,
 * mod-time-asc,
 * mod-time-desc."
  :type '(choice (const alphabetic-asc)
                 (const alphabetic-desc)
                 (const size-asc)
                 (const size-desc)
                 (const mod-time-asc)
                 (const mod-time-desc))
  :group 'treemacs-configuration)

(defcustom treemacs-ignored-file-predicates
  '(treemacs--std-ignore-file-predicate)
  "List of predicates to test for files ignored by Emacs.

Ignored files will *never* be shown in the treemacs buffer (unlike dotfiles)
whose presence is controlled by `treemacs-show-hidden-files').

Each predicate is a function that takes the filename as its only argument and
returns t if the file should be ignored and nil otherwise. A file whose name
returns t for *any* function in this list counts as ignored.

By default this list contains `treemacs--std-ignore-file-predicate' which
filters out '.', '..', Emacs' lock files as well as flycheck's temp files, and
therefore should not be directly overwritten, but added to and removed from
instead."
  :type 'list
  :group 'treemacs-configuration)

(defcustom treemacs-file-event-delay 5000
  "How long (in milliseconds) to collect file events before refreshing.
When treemacs receives a file change notification it doesn't immediately refresh
and instead waits `treemacs-file-event-delay' milliseconds to collect further
file change events. This is done so as to avoid refreshing multiple times in a
short time.
See also `treemacs-filewatch-mode'."
  :type 'integer
  :group 'treemacs-configuration)

(provide 'treemacs-customization)

;;; treemacs-customization.el ends here
