Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2106A28FC74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393807AbgJPCkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393798AbgJPCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:40:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A6C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d81so960203wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pvEughYKhq6CPlCwy3Gb88MacOrMK6GsoP9z00bpKRo=;
        b=HYu9FnLyQSFSJmzxotOAKKwXADM27PjlJfnilMOVzzmweirs2scSTtjZxmW19WFqbs
         qKhVuz2d4dNSGIxsoo5WUcepJaEhXiT/mvkHYzy+ITRq0rrraQ9Tb3Dafm8iwb7v0lwt
         hbwAfsD7vq3O8xlwMJ4oUxxCNqRvcwURiW46MBI557AdjxFD0AMoL6LSrzRfZfbgnPoe
         N1urYaQDLUyElj/nIYY6u3bDOYoCOG12lB+tNkzQBw3Z9dsapQKSf2tgcWW/x4UacSwx
         1JrOInTm+F21s2HkGMw/6OK9Hc6RbGwkLUxjMU2X7mR+AeFOYGcoxHfohgRoK8ybyCmK
         NLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvEughYKhq6CPlCwy3Gb88MacOrMK6GsoP9z00bpKRo=;
        b=kusqEQ4wwK5l2jXjXmtaCGjPv1emA9Zs822MZ1kz3FaoAr3GWwxqJaRYCdXHYUIQge
         sa6gcK3mDtkHqeSW608Ehdy82A1PzaSP7jLg2Pli6AHogqdmPLlW7G8/etImt/a9nh2S
         dQyx2RjkHDUDWvhIYCq5eIHrZk1IY9ZOYna5rXXWSu146ln+3cvFg60nCSHGYJVJzIhz
         6NBRrHFeX5Ze2cSNx/upa29KhSlSwnBbojzHDBlsnqBaMvFn6LaN9rlyYDhlxx1sp+Qy
         Nb1g/SEfVBrZRnl7xqwP+EVS5FubGUV2SfJ4uqwyXrSa0M3WBg6GWUAZ1s4VkpSEpGrT
         Awww==
X-Gm-Message-State: AOAM532Gj25yArlhg50GfZ8JGGFaW79LEXDbC55y537Dnkka7Srln9sE
        ymgMF3V4k6rgUZ/WipSWcztrgQ==
X-Google-Smtp-Source: ABdhPJwVT5RN/jLxGSRyml+j1Ke4WERT80MS8k60n76yy/6+aaqzCEh+GU7QKYNDx5gbZUww9+LjmQ==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr1371136wmh.21.1602816034173;
        Thu, 15 Oct 2020 19:40:34 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id x18sm1543168wrg.4.2020.10.15.19.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 19:40:33 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 1/6] ptrace: Keep mm around after exit_mm() for __ptrace_may_access()
Date:   Fri, 16 Oct 2020 04:40:14 +0200
Message-Id: <20201016024019.1882062-2-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016024019.1882062-1-jannh@google.com>
References: <20201016024019.1882062-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Fixes: bfedb589252c ("mm: Add a user_ns owner to mm_struct and fix ptrace permission checks")
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
 
 	/* Per-thread vma caching: */
 	struct vmacache			vmacache;
diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f334e7..97253ef33486 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -476,6 +476,8 @@ static void exit_mm(void)
 	/* more a memory barrier than a real lock */
 	task_lock(current);
 	current->mm = NULL;
+	mmgrab(mm); /* for current->exit_mm */
+	current->exit_mm = mm;
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
-	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) != 0);
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
@@ -722,6 +696,34 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
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
+	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) != 0);
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
@@ -342,7 +342,17 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
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
 	mm = task->mm;
+	if (!mm)
+		mm = task->exit_mm;
 	if (mm &&
 	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
 	     !ptrace_has_cap(cred, mm->user_ns, mode)))
-- 
2.29.0.rc1.297.gfa9743e501-goog

