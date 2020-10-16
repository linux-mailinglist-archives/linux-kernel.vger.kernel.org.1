Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE033290DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406696AbgJPW5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405567AbgJPW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:57:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:57:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so4848254wre.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FwH6tQJ2kvR/4Vz9wM7cbsmRIZSsoZ1Y81FZd6gOnM=;
        b=ewHMTuMTpWjAeY+8LJTjjCSCRGtI1vlQQ6q/+/gOqdNr/v8lHtoeOAtkHat0cs9qyG
         TcETNdIJ4AV/aRhHdfIFAkdc3ZEd35Y2Uot6+hdRwD3K7XT0fxldxLxI0GZBNlKIVPWD
         hxlJowpu3nW8GG6BDa73g+zhzTHUvS7XLeTuQ3Y7+gwhrstw3dpGTzx2w1GjxhIIk/li
         ndZEZFXoPZbiOYzL+mdi/8ZEjO7Ric7lzvoIk87295xgRTJdsgLWkfCRM4DO4LH/AzBx
         nTro3dC1TQoCEQ0BIHw6zZX6XBcscddsKHw0k390b0pUOIUnrC5hsa+wXKdWIbuAgYA6
         P3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FwH6tQJ2kvR/4Vz9wM7cbsmRIZSsoZ1Y81FZd6gOnM=;
        b=takE/z1sYgZZeARhQdudnICQNfxtAcv5ZtFNIeepzLrSREBuia1mJxVcJXfG+u8IQE
         RhtuSvf10L1+ZWuRpmLY1Y35F2u9Uk/b0PkvGM6SDhNYE9FF2c79Kce0vwBxGgNrfGHm
         0MUyTs2T9HCcBQplcOAFA1yQhUEaDBBpG7VdWmY3+ZrlfVceGCgxS6t+Pq1/AUndtfhT
         EpIrg0pZHwHFzxv9JFSDYNlWqNIK/aduaxc825oSXBwi9pHIzkzNJVQdIKj+dnAXqI1n
         XwOaYBrZsVgM/q19lql3lqpCanc2mDvicGxtrWhs1+0tthMnXg4rsI+k48/D72inmrx1
         5CMQ==
X-Gm-Message-State: AOAM531IZncunLJIwVusVD0wm99nKk85aMQww4sj3OdKPQErmdeaunhV
        siZH4PR5UCK2RL1nR0s6TvY4OA==
X-Google-Smtp-Source: ABdhPJwSmAiBuod1zFjGtnQBj6JUvit62csdXtBhw4YActL0zCxPXX6yQgHwikrwDhWMRyM6ReU11w==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr6242289wrw.243.1602889047918;
        Fri, 16 Oct 2020 15:57:27 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id 40sm5506933wrc.46.2020.10.16.15.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:57:27 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
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
        John Hubbard <jhubbard@nvidia.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH resend v3 2/2] exec: Broadly lock nascent mm until setup_arg_pages()
Date:   Sat, 17 Oct 2020 00:57:13 +0200
Message-Id: <20201016225713.1971256-3-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016225713.1971256-1-jannh@google.com>
References: <20201016225713.1971256-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
index 229dbc7aa61a..00edf833781f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -254,11 +254,6 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 		return -ENOMEM;
 	vma_set_anonymous(vma);
=20
-	if (mmap_write_lock_killable(mm)) {
-		err =3D -EINTR;
-		goto err_free;
-	}
-
 	/*
 	 * Place the stack at the largest stack address the architecture
 	 * supports. Later, we'll move this to an appropriate place. We don't
@@ -276,12 +271,9 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 		goto err;
=20
 	mm->stack_vm =3D mm->total_vm =3D 1;
-	mmap_write_unlock(mm);
 	bprm->p =3D vma->vm_end - sizeof(void *);
 	return 0;
 err:
-	mmap_write_unlock(mm);
-err_free:
 	bprm->vma =3D NULL;
 	vm_area_free(vma);
 	return err;
@@ -364,9 +356,9 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	struct mm_struct *mm =3D NULL;
=20
 	bprm->mm =3D mm =3D mm_alloc();
-	err =3D -ENOMEM;
 	if (!mm)
-		goto err;
+		return -ENOMEM;
+	mmap_write_lock_nascent(mm);
=20
 	/* Save current stack limit for all calculations made during exec. */
 	task_lock(current->group_leader);
@@ -374,17 +366,12 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	task_unlock(current->group_leader);
=20
 	err =3D __bprm_mm_init(bprm);
-	if (err)
-		goto err;
-
-	return 0;
-
-err:
-	if (mm) {
-		bprm->mm =3D NULL;
-		mmdrop(mm);
-	}
+	if (!err)
+		return 0;
=20
+	bprm->mm =3D NULL;
+	mmap_write_unlock(mm);
+	mmdrop(mm);
 	return err;
 }
=20
@@ -735,6 +722,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 /*
  * Finalizes the stack vm_area_struct. The flags and permissions are updat=
ed,
  * the stack is optionally relocated, and some extra space is added.
+ * At the end of this, the mm_struct will be unlocked on success.
  */
 int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
@@ -787,9 +775,6 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		bprm->loader -=3D stack_shift;
 	bprm->exec -=3D stack_shift;
=20
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
 	vm_flags =3D VM_STACK_FLAGS;
=20
 	/*
@@ -807,7 +792,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	ret =3D mprotect_fixup(vma, &prev, vma->vm_start, vma->vm_end,
 			vm_flags);
 	if (ret)
-		goto out_unlock;
+		return ret;
 	BUG_ON(prev !=3D vma);
=20
 	if (unlikely(vm_flags & VM_EXEC)) {
@@ -819,7 +804,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	if (stack_shift) {
 		ret =3D shift_arg_pages(vma, stack_shift);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
=20
 	/* mprotect_fixup is overkill to remove the temporary stack flags */
@@ -846,11 +831,17 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	current->mm->start_stack =3D bprm->p;
 	ret =3D expand_stack(vma, stack_base);
 	if (ret)
-		ret =3D -EFAULT;
+		return -EFAULT;
=20
-out_unlock:
+	/*
+	 * From this point on, anything that wants to poke around in the
+	 * mm_struct must lock it by itself.
+	 */
+	bprm->vma =3D NULL;
 	mmap_write_unlock(mm);
-	return ret;
+	mmput(mm);
+	bprm->mm =3D NULL;
+	return 0;
 }
 EXPORT_SYMBOL(setup_arg_pages);
=20
@@ -1114,8 +1105,6 @@ static int exec_mmap(struct mm_struct *mm)
 	if (ret)
 		return ret;
=20
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
=20
+	/* bprm->mm stays refcounted, current->mm takes an extra reference */
+	mmget(mm);
 	task_lock(tsk);
 	active_mm =3D tsk->active_mm;
 	membarrier_exec_mmap(mm);
@@ -1141,7 +1131,6 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->mm->vmacache_seqnum =3D 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
-	mmap_write_unlock(mm);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm !=3D old_mm);
@@ -1397,8 +1386,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
=20
-	bprm->mm =3D NULL;
-
 #ifdef CONFIG_POSIX_TIMERS
 	exit_itimers(me->signal);
 	flush_itimer_signals();
@@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
 	me->mm->task_size =3D TASK_SIZE;
 	mutex_unlock(&me->signal->exec_update_mutex);
 	mutex_unlock(&me->signal->cred_guard_mutex);
+
+	if (!IS_ENABLED(CONFIG_MMU)) {
+		/*
+		 * On MMU, setup_arg_pages() wants to access bprm->vma after
+		 * this point, so we can't drop the mmap lock yet.
+		 * On !MMU, we have neither setup_arg_pages() nor bprm->vma,
+		 * so we should drop the lock here.
+		 */
+		mmap_write_unlock(bprm->mm);
+		mmput(bprm->mm);
+		bprm->mm =3D NULL;
+	}
 }
 EXPORT_SYMBOL(setup_new_exec);
=20
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
--=20
2.29.0.rc1.297.gfa9743e501-goog

