;; My personal function library

;; Make help-mode source code view trigger view-mode
(require 'help-mode)

(defvar my-orig-help-function-def
  (button-type-get 'help-function-def 'help-function))

(defun my-replacement-help-function-def (fun file)
  (funcall my-orig-help-function-def fun file)
  (view-mode))

(button-type-put 'help-function-def
		 'help-function
		 'my-replacement-help-function-def)

(defvar my-orig-help-variable-def
  (button-type-get 'help-variable-def 'help-function))

(defun my-replacement-help-variable-def (var &optional file)
  (funcall my-orig-help-variable-def var file)
  (view-mode))

(button-type-put 'help-variable-def
		 'help-function
		 'my-replacement-help-variable-def)

;; Paste random text into buffer
(defun my-paste-random-text (&optional paras min-words max-words)
  "Paste a number of paragraphs containing random text into buffer"
  (interactive (list
		(read-number "Paragraphs: " 10)
		(read-number "Minimum words: " 25)
		(read-number "Maximum words: " 40)))
  (let* ((paras (or paras 5))
	 (min-words (or min-words 25))
	 (max-words (or max-words 45))
	 (url (concat "http://www.randomtext.me/api/gibberish/p-"
		      (int-to-string paras) "/"
		      (int-to-string min-words) "-" (int-to-string max-words)))
	 (my-keep-just-para-text (lambda ()
				   (let ((beg (point))
					 (end (search-forward "<p>" nil t)))
				     (if end
					 (progn
					   (delete-region beg end)
					   (let ((p (search-forward "<\\/p>" nil t)))
					     (if p
						 (progn
						   (kill-backward-chars 5)
						   t)))))))))
    (save-excursion
      (insert
       (with-current-buffer
	   (url-retrieve-synchronously url)
	 (beginning-of-buffer)
	 (kill-paragraph 1)
	 (kill-line)

	 (while (funcall my-keep-just-para-text)
	   (newline 2))

	 (delete-region (point) (point-max))
	 (fill-region (point-min) (point-max))
	 
	 (let ((text (buffer-string)))
	   (kill-buffer)
	   text))))))

(provide 'my-commands)
