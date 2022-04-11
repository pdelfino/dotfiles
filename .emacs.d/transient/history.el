((git-commit-insert-pseudo-header nil)
 (magit-am
  ("--3way"))
 (magit-blame
  ("-w"))
 (magit-branch nil)
 (magit-commit nil
               ("--reuse-message=ORIG_HEAD"))
 (magit-diff
  ("--no-ext-diff" "--stat"))
 (magit-dispatch nil)
 (magit-fetch nil)
 (magit-log
  ("-n256" "--graph" "--decorate")
  ("-n256" "--author=Pedro Delfino" "--graph" "--decorate")
  ("-n256" "--author=Pedro Delfino" "--grep= 79504ca" "--graph" "--decorate"))
 (magit-log:--grep " 79504ca")
 (magit-pull nil
             ("--rebase"))
 (magit-push nil
             ("--force-with-lease")
             ("--force"))
 (magit-rebase
  ("--autostash")
  nil)
 (magit-reset nil)
 (magit-revision-history "ORIG_HEAD")
 (magit-stash nil)
 (magit-submodule nil)
 (magit-tag nil)
 (magit:--author "Pedro Delfino"))
