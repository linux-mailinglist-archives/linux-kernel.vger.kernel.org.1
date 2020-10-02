Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC7280BEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 03:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbgJBBZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 21:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBBZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 21:25:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE85C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 18:25:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so578087eja.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=Kqs8a9E5uPOTBp74swyiiF8zCX3R3DCtjj7F/Xz7M0M=;
        b=YrpQKZP4LvvC42rx/oChM9+PWWxB9yCHXQgbCQcYI7Nnbzt0fKSh60i+aejNgAmbXc
         SvsUMZkpxiy7JKwBIbiJwHpUDUdfddKsvGighKIy6yzGdTfWxkZkGNRXR5Re952f5Ga/
         Hl4Qe+15bcmgSHq1Wc6O/o1IxAlgmEVoUKoYuVH5+XmiT8T7fxocJlF6WN41M4lpGwUn
         ong/8Gi5OPDs2/zQ6e0jGFJlvTbk+zDls+z+59WjWoHkqMFhS7Mo/mAyK9WM3rL9yVEn
         LB0hnLToPsKOXZxi5YGzacuMeLRJCt0RaIOPu9f8QVIOU9oaqXKzbXRKLQC45H/wHh+z
         8emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=Kqs8a9E5uPOTBp74swyiiF8zCX3R3DCtjj7F/Xz7M0M=;
        b=qHmA4xYD2htId7NRI4ov7U5DYG5qBS+IcD+hb48uTyVB6ezOS45Me5t4s98bHDYBmq
         T9y1hIA7OfOXSCxwtFKC3U7liQYICtORWLbv56T/FKvvx1BMv7pfhv5HkpRvSdZ5yGnT
         mzX2PJQCFkPcy7GzEtDzo+oOJ1CXfMliLA2tiJUMzmi5/4XGCgOcUeqwT8Q9G/XgOD2z
         16uF7+yc30jQOSp3PtX4lmx9CCxD3rG+i1JXgmgqlEswbOWNsuNslclj0J7MJI9PXbsv
         YvNU8FqvAL7eIxiBb3LYtR+UyETYNZfxNzmFQrv1wyRu97WE43/9yvBZpFf6qrNtu2Vd
         OiUA==
X-Gm-Message-State: AOAM531rNycXZ9Xz8l0UMNrbRhCLd3elr52U6KoihvK9SXcRyMmXhk5e
        Kj33pMXlIHjG5FEdosdTiULkrZjOQd4FwEes7DNxVQ==
X-Google-Smtp-Source: ABdhPJzVu3SoEuRQ33jBZmzhi/XuwzQ/9eJHcY97azL852GtwzhzffTrBq6YxHopboXK4kUbi1LzATXGMeGFDdIdU9w=
X-Received: by 2002:a17:906:fcae:: with SMTP id qw14mr4739966ejb.537.1601601904679;
 Thu, 01 Oct 2020 18:25:04 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2020 21:25:04 -0400
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
MIME-Version: 1.0
Date:   Thu, 1 Oct 2020 21:25:04 -0400
Message-ID: <CAG48ez1rCScOo7jC2ReC7QTLNFGnpB8UvNbeiiN3pXCWbNvW+g@mail.gmail.com>
Subject: [PATCH 2/2] exec: Broadly lock nascent mm until setup_arg_pages()
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While AFAIK there currently is nothing that can modify the VMA tree of a
new mm until userspace has started running under the mm, we should properly
lock the mm here anyway, both to keep lockdep happy when adding locking
assertions and to be safe in the future in case someone e.g. decides to
permit VMA-tree-mutating operations in process_madvise_behavior_valid().

The goal of this patch is to broadly lock the nascent mm in the exec path,
from around the time it is created all the way to the end of
setup_arg_pages() (because setup_arg_pages() accesses bprm->vma).
As long as the mm is write-locked, keep it around in bprm->mm, even after
it has been installed on the task (with an extra reference on the mm, to
reduce complexity in free_bprm()).
After setup_arg_pages(), we have to unlock the mm so that APIs such as
copy_to_user() will work in the following binfmt-specific setup code.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Michel Lespinasse <walken@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/exec.c               | 68 ++++++++++++++++++++---------------------
 include/linux/binfmts.h |  2 +-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 229dbc7aa61a..fe11d77e397a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -254,11 +254,6 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 		return -ENOMEM;
 	vma_set_anonymous(vma);

-	if (mmap_write_lock_killable(mm)) {
-		err = -EINTR;
-		goto err_free;
-	}
-
 	/*
 	 * Place the stack at the largest stack address the architecture
 	 * supports. Later, we'll move this to an appropriate place. We don't
@@ -276,12 +271,9 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 		goto err;

 	mm->stack_vm = mm->total_vm = 1;
-	mmap_write_unlock(mm);
 	bprm->p = vma->vm_end - sizeof(void *);
 	return 0;
 err:
-	mmap_write_unlock(mm);
-err_free:
 	bprm->vma = NULL;
 	vm_area_free(vma);
 	return err;
@@ -364,9 +356,9 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	struct mm_struct *mm = NULL;

 	bprm->mm = mm = mm_alloc();
-	err = -ENOMEM;
 	if (!mm)
-		goto err;
+		return -ENOMEM;
+	mmap_write_lock_nascent(mm);

 	/* Save current stack limit for all calculations made during exec. */
 	task_lock(current->group_leader);
@@ -374,17 +366,12 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	task_unlock(current->group_leader);

 	err = __bprm_mm_init(bprm);
-	if (err)
-		goto err;
-
-	return 0;
-
-err:
-	if (mm) {
-		bprm->mm = NULL;
-		mmdrop(mm);
-	}
+	if (!err)
+		return 0;

+	bprm->mm = NULL;
+	mmap_write_unlock(mm);
+	mmdrop(mm);
 	return err;
 }

@@ -735,6 +722,7 @@ static int shift_arg_pages(struct vm_area_struct
*vma, unsigned long shift)
 /*
  * Finalizes the stack vm_area_struct. The flags and permissions are updated,
  * the stack is optionally relocated, and some extra space is added.
+ * At the end of this, the mm_struct will be unlocked on success.
  */
 int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
@@ -787,9 +775,6 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		bprm->loader -= stack_shift;
 	bprm->exec -= stack_shift;

-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
 	vm_flags = VM_STACK_FLAGS;

 	/*
@@ -807,7 +792,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	ret = mprotect_fixup(vma, &prev, vma->vm_start, vma->vm_end,
 			vm_flags);
 	if (ret)
-		goto out_unlock;
+		return ret;
 	BUG_ON(prev != vma);

 	if (unlikely(vm_flags & VM_EXEC)) {
@@ -819,7 +804,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	if (stack_shift) {
 		ret = shift_arg_pages(vma, stack_shift);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}

 	/* mprotect_fixup is overkill to remove the temporary stack flags */
@@ -846,11 +831,17 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	current->mm->start_stack = bprm->p;
 	ret = expand_stack(vma, stack_base);
 	if (ret)
-		ret = -EFAULT;
+		return -EFAULT;

-out_unlock:
+	/*
+	 * From this point on, anything that wants to poke around in the
+	 * mm_struct must lock it by itself.
+	 */
+	bprm->vma = NULL;
 	mmap_write_unlock(mm);
-	return ret;
+	mmput(mm);
+	bprm->mm = NULL;
+	return 0;
 }
 EXPORT_SYMBOL(setup_arg_pages);

@@ -1114,8 +1105,6 @@ static int exec_mmap(struct mm_struct *mm)
 	if (ret)
 		return ret;

-	mmap_write_lock_nascent(mm);
-
 	if (old_mm) {
 		/*
 		 * Make sure that if there is a core dump in progress
@@ -1127,11 +1116,12 @@ static int exec_mmap(struct mm_struct *mm)
 		if (unlikely(old_mm->core_state)) {
 			mmap_read_unlock(old_mm);
 			mutex_unlock(&tsk->signal->exec_update_mutex);
-			mmap_write_unlock(mm);
 			return -EINTR;
 		}
 	}

+	/* bprm->mm stays refcounted, current->mm takes an extra reference */
+	mmget(mm);
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
 	membarrier_exec_mmap(mm);
@@ -1141,7 +1131,6 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
-	mmap_write_unlock(mm);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
@@ -1397,8 +1386,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;

-	bprm->mm = NULL;
-
 #ifdef CONFIG_POSIX_TIMERS
 	exit_itimers(me->signal);
 	flush_itimer_signals();
@@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
 	me->mm->task_size = TASK_SIZE;
 	mutex_unlock(&me->signal->exec_update_mutex);
 	mutex_unlock(&me->signal->cred_guard_mutex);
+
+#ifndef CONFIG_MMU
+	/*
+	 * On MMU, setup_arg_pages() wants to access bprm->vma after this point,
+	 * so we can't drop the mmap lock yet.
+	 * On !MMU, we have neither setup_arg_pages() nor bprm->vma, so we
+	 * should drop the lock here.
+	 */
+	mmap_write_unlock(bprm->mm);
+	mmput(bprm->mm);
+	bprm->mm = NULL;
+#endif
 }
 EXPORT_SYMBOL(setup_new_exec);

@@ -1581,6 +1580,7 @@ static void free_bprm(struct linux_binprm *bprm)
 {
 	if (bprm->mm) {
 		acct_arg_size(bprm, 0);
+		mmap_write_unlock(bprm->mm);
 		mmput(bprm->mm);
 	}
 	free_arg_pages(bprm);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 0571701ab1c5..3bf06212fbae 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -22,7 +22,7 @@ struct linux_binprm {
 # define MAX_ARG_PAGES	32
 	struct page *page[MAX_ARG_PAGES];
 #endif
-	struct mm_struct *mm;
+	struct mm_struct *mm; /* nascent mm, write-locked */
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
-- 
2.28.0.806.g8561365e88-goog
