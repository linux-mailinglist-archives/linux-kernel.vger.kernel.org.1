Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02D3290DFA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408018AbgJPXJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407010AbgJPXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:09:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B0C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so4831174wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKfumXOLgixAy84wx3Nv6Fkz9iX4qYebEti8jMCXhGY=;
        b=GTdBD4iCkIejmT0ii834rbvngwiM3DhYbyE0f6KICAmNujfqnubYf4FptFnJ7Ysp0D
         0AbzjfrI4HXAM3FXcrrS7+gPcEpe3IBbotJjQILnBOSYFyRI7DnM/agiJPj9Sw+eK7PY
         q6wRtLdbq3KMM7iQzfrPslOjTuZ1JmpQ5JjGB/mU22P75fBHPmN7P+j+Lm4X1ybiyaIo
         iS3LK1vFKhl8x3xlYmY//o8eP72UCJ+bxVhgDZBWxb0Hq+qnU0OCajLdC4S5qV/8uPPD
         /vSGXzm3SdhEKPUQDvMeKGQ0DSf3xMwxv/7lMh522scj3xOCYR3IoxJ+sHeMtrj078aP
         IPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKfumXOLgixAy84wx3Nv6Fkz9iX4qYebEti8jMCXhGY=;
        b=Swjc2KwwOHPQMqppxw/SSK3hfF3spq7kTqRr9tHPPXA8UEKnIei5MEn2PpyjtnlJEw
         MLSqhgv/nm0eKWjszlGvCITW14OTkK4kqufgulzsKymPd35YyAZCLRQUDhOwyoZIDwX+
         4lKmWa/tMx8da3iCBlNLa7xEx1DDj96mRQZoiLgQnGy1ijiWsSGm7UEsROu+ifHZ2VWs
         xcyDSEZZLHJRERzLZ1wtvVifoUcK0PPL20T+nnkDUuAZEMRRa3VxM+lscBxySTZONjQr
         fhLZc0KtBsdUTKJWjv021/+aeVbxNg3yoRE5W80rMAa3GadV6Yjk/hOphX9oXFsz7iWS
         XgJA==
X-Gm-Message-State: AOAM531Zypna0tjZPaghHCWwuMxjFjh3lFk9/wVk4mACW9enWkNyhq0h
        gHQ+tCfGqcR2nOXrJsrvN+EkNz1ZvNKgPw==
X-Google-Smtp-Source: ABdhPJzPIxZWpPKHv3yxMqwsMLhL6oUdBGXHlkzC5ZPb9QzCCBu761qmb+/Ol2XykISQILgn3L+6XQ==
X-Received: by 2002:a5d:4b49:: with SMTP id w9mr7014571wrs.41.1602889776793;
        Fri, 16 Oct 2020 16:09:36 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id s11sm5476456wrm.56.2020.10.16.16.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:09:36 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH resend 1/6] ptrace: Keep mm around after exit_mm() for __ptrace_may_access()
Date:   Sat, 17 Oct 2020 01:09:10 +0200
Message-Id: <20201016230915.1972840-2-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016230915.1972840-1-jannh@google.com>
References: <20201016230915.1972840-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ptrace_may_access() checks can happen on target tasks that are in the
middle of do_exit(), past exit_mm(). At that point, the ->mm pointer has
been NULLed out, and the mm_struct has been mmput().

Unfortunately, the mm_struct contains the dumpability and the user_ns in
which the task last went through execve(), and we need those for
__ptrace_may_access(). Currently, that problem is handled by failing open:
If the ->mm is gone, we assume that the task was dumpable. In some edge
cases, this could potentially expose access to things like
/proc/$pid/fd/$fd of originally non-dumpable processes.
(exit_files() comes after exit_mm(), so the file descriptor table is still
there when we've gone through exit_mm().)

One way to fix this would be to move mm->user_ns and the dumpability state
over into the task_struct. However, that gets quite ugly if we want to
preserve existing semantics because e.g. PR_SET_DUMPABLE and commit_creds()
would then have to scan through all tasks sharing the mm_struct and keep
them in sync manually - that'd be a bit error-prone and overcomplicated.

(Moving these things into the signal_struct is not an option because that
is kept across executions, and pre-execve co-threads will share the
signal_struct that is also used by the task that has gone through
execve().)

I believe that this patch may be the least bad option to fix this - keep
the mm_struct (but not process memory) around with an mmgrab() reference
from exit_mm() until the task goes away completely.

Note that this moves free_task() down in order to make mmdrop_async()
available without a forward declaration.

Cc: stable@vger.kernel.org
Fixes: bfedb589252c ("mm: Add a user_ns owner to mm_struct and fix ptrace p=
ermission checks")
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/sched.h |  8 +++++++
 kernel/exit.c         |  2 ++
 kernel/fork.c         | 54 ++++++++++++++++++++++---------------------
 kernel/ptrace.c       | 10 ++++++++
 4 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..55bec6ff5626 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -747,6 +747,14 @@ struct task_struct {
=20
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
+	/*
+	 * When we exit and ->mm (the reference pinning ->mm's address space)
+	 * goes away, we stash a reference to the mm_struct itself (counted via
+	 * exit_mm->mm_count) in this member.
+	 * This allows us to continue using the mm_struct for security checks
+	 * and such even after the task has started exiting.
+	 */
+	struct mm_struct		*exit_mm;
=20
 	/* Per-thread vma caching: */
 	struct vmacache			vmacache;
diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f334e7..97253ef33486 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -476,6 +476,8 @@ static void exit_mm(void)
 	/* more a memory barrier than a real lock */
 	task_lock(current);
 	current->mm =3D NULL;
+	mmgrab(mm); /* for current->exit_mm */
+	current->exit_mm =3D mm;
 	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
 	task_unlock(current);
diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..4942428a217c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -438,32 +438,6 @@ void put_task_stack(struct task_struct *tsk)
 }
 #endif
=20
-void free_task(struct task_struct *tsk)
-{
-	scs_release(tsk);
-
-#ifndef CONFIG_THREAD_INFO_IN_TASK
-	/*
-	 * The task is finally done with both the stack and thread_info,
-	 * so free both.
-	 */
-	release_task_stack(tsk);
-#else
-	/*
-	 * If the task had a separate stack allocation, it should be gone
-	 * by now.
-	 */
-	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) !=3D 0);
-#endif
-	rt_mutex_debug_task_free(tsk);
-	ftrace_graph_exit_task(tsk);
-	arch_release_task_struct(tsk);
-	if (tsk->flags & PF_KTHREAD)
-		free_kthread_struct(tsk);
-	free_task_struct(tsk);
-}
-EXPORT_SYMBOL(free_task);
-
 #ifdef CONFIG_MMU
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
@@ -722,6 +696,34 @@ static inline void put_signal_struct(struct signal_str=
uct *sig)
 		free_signal_struct(sig);
 }
=20
+void free_task(struct task_struct *tsk)
+{
+	scs_release(tsk);
+
+#ifndef CONFIG_THREAD_INFO_IN_TASK
+	/*
+	 * The task is finally done with both the stack and thread_info,
+	 * so free both.
+	 */
+	release_task_stack(tsk);
+#else
+	/*
+	 * If the task had a separate stack allocation, it should be gone
+	 * by now.
+	 */
+	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) !=3D 0);
+#endif
+	rt_mutex_debug_task_free(tsk);
+	ftrace_graph_exit_task(tsk);
+	arch_release_task_struct(tsk);
+	if (tsk->flags & PF_KTHREAD)
+		free_kthread_struct(tsk);
+	if (tsk->exit_mm)
+		mmdrop_async(tsk->exit_mm);
+	free_task_struct(tsk);
+}
+EXPORT_SYMBOL(free_task);
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..0aedc6cf5bdc 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -342,7 +342,17 @@ static int __ptrace_may_access(struct task_struct *tas=
k, unsigned int mode)
 	 * Pairs with a write barrier in commit_creds().
 	 */
 	smp_rmb();
+	/*
+	 * Look up the target task's mm_struct. If it fails because the task is
+	 * exiting and has gone through exit_mm(), we can instead use ->exit_mm
+	 * as long as we only use members that are preserved by an mmgrab()
+	 * reference.
+	 * The only case in which both ->mm and ->exit_mm can be NULL should be
+	 * kernel threads.
+	 */
 	mm =3D task->mm;
+	if (!mm)
+		mm =3D task->exit_mm;
 	if (mm &&
 	    ((get_dumpable(mm) !=3D SUID_DUMP_USER) &&
 	     !ptrace_has_cap(cred, mm->user_ns, mode)))
--=20
2.29.0.rc1.297.gfa9743e501-goog

