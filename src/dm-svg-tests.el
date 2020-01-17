;;; dm-svg-tests.el --- tests for dm-svg             -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Corwin Brust

;; Author: Corwin Brust <corwin@bru.st>
;; Keywords: games

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Tests for `dm-svg' which see

;;; Code:

(defmacro dm-test-load-path ()
  "Build a temporary load-path for a test's context package."
  `(list (file-name-directory (or buffer-file-name (buffer-name)))))

(ert-deftest dm-svg--require ()
  "require `dm-svg'"
  :tags '(:dm-svg :svg :requires)
  (let ((load-path (dm-test-load-path)))
    (should (eq 'dm-svg (require 'dm-svg)))))

(ert-deftest dm-svg-or-nil-p ()
  "predicate `dm-svg-or-nil-p'"
  :tags '(:dm-svg :svg :predicate)
  (should (eq 2 (length (delete
			 nil
			 (mapcar 'svg-or-nil-p
				 (list nil t (svg-create 500 500))))))))

(ert-deftest dm-svg--create ()
  "create `dm-svg'"
  :tags '(:dm-svg :svg :create)
  (should
   (prog1 t (dolist (x (list '(nil . nil) `(,(svg-create 500 500) . "v100")))
	      (dm-svg :svg (car x) :path-data (cdr x))))))

(ert-deftest dm-svg-add-path-data ()
  "method `dm-svg-add-path-data'"
  :tags '(:dm-svg :svg :method)
  (should
   (string= "v100h100v-100h-100"
	    (let ((o (dm-svg :svg (svg-create 500 500) :path-data "v100")))
	      (add-path-data o "h100v-100h-100")))))




(provide 'dm-svg-tests)
;;; dm-svg-tests.el ends here