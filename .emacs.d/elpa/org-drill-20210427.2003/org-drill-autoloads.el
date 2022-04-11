;;; org-drill-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "org-drill" "org-drill.el" (0 0 0 0))
;;; Generated autoloads from org-drill.el

(autoload 'org-drill "org-drill" "\
Begin an interactive 'drill session'. The user is asked to
review a series of topics (headers). Each topic is initially
presented as a 'question', often with part of the topic content
hidden. The user attempts to recall the hidden information or
answer the question, then presses a key to reveal the answer. The
user then rates his or her recall or performance on that
topic. This rating information is used to reschedule the topic
for future review.

Org-drill proceeds by:

- Finding all topics (headings) in SCOPE which have either been
  used and rescheduled before, or which have a tag that matches
  `org-drill-question-tag'.

- All matching topics which are either unscheduled, or are
  scheduled for the current date or a date in the past, are
  considered to be candidates for the drill session.

- If `org-drill-maximum-items-per-session' is set, a random
  subset of these topics is presented. Otherwise, all of the
  eligible topics will be presented.

SCOPE determines the scope in which to search for
questions.  It accepts the same values as `org-drill-scope',
which see.

DRILL-MATCH, if supplied, is a string specifying a tags/property/
todo query. Only items matching the query will be considered.
It accepts the same values as `org-drill-match', which see.

If RESUME-P is non-nil, resume a suspended drill session rather
than starting a new one.

CRAM, if non-nil, will start a new session in cram mode. If
resuming a suspended session, this parameter is ignored.

\(fn &optional SCOPE DRILL-MATCH RESUME-P CRAM)" t nil)

(autoload 'org-drill-cram "org-drill" "\
Run an interactive drill session in 'cram mode'. In cram mode,
all drill items are considered to be due for review, unless they
have been reviewed within the last `org-drill-cram-hours'
hours.

\(fn &optional SCOPE DRILL-MATCH)" t nil)

(autoload 'org-drill-again "org-drill" "\
Run a new drill session, but try to use leftover due items that
were not reviewed during the last session, rather than scanning for
unreviewed items. If there are no leftover items in memory, a full
scan will be performed.

\(fn &optional SCOPE DRILL-MATCH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-drill" '("org-drill-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-drill-autoloads.el ends here
