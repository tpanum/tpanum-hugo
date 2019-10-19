(require 'package)

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))

(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-always-ensure t)

(use-package org)
(use-package ox-hugo
	     :after org
	     :config
	     (defun tpanum/compile ()
	       (org-hugo-export-wim-to-md :all-subtrees)))

(print (concat "Org mode version: " (org-version)))
