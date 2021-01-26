Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D563E304F34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392572AbhA0Bnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbhAZSzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:55:02 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865BC061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:54:22 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id a75so7662162qkg.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bO5cG8RVFSJvcHYvzxJ3sDdtOfyds0IikppF+3dZPH4=;
        b=jaKm19MgC/4JoiUqQYSkY3kVyuBbW2s9EX7C+M/+OpxZNu37WkSkjZuPcw4e4RHLJw
         gcFMX73CbuI88zfcfGIKpVhmbdYgIO0j59R6vK9mh14t4DHIPNPaty55w6eLo5WSmQjh
         RWZNCQAoM8pYj/ouEhx33f97ToHjKpm4m+BvHtw5vpxs0QebRmUKKIXLRTvdpWha6zfn
         bl9ZR4bUz9T1Up/zrJxBsUrGA9r2pwEAcDLIQ0zMmvGWyTd5qpgjZNjRsx9VxbIOTfV+
         wp/pc+r2ms6vFYp55VmfJKifXRVV63luHOc39zcOpUPbYmCYVhGgfYtlZP+4pGZ79Loi
         Z/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bO5cG8RVFSJvcHYvzxJ3sDdtOfyds0IikppF+3dZPH4=;
        b=ha4d9YpQdGVVRF1CtbjBaz6+8G2g7g3A5IDMNi/VpLDG6/zlR/wXWA1E0SYBR8qI6b
         HmqrPwggn9PHjYNwkLvmBHu6pTdWwoQm9wy2dc60uBCrLYcyfTFPz2zKVQ9Sto6QaFR5
         EtSp7ZFZSQq/BkI+RfI6fs6WuqdSNusVQVJo6TQnZTFdxMqHvfCcY20kDnIEqbUVxbve
         Zgptv3dM/oV+a81dLCWDRQZ+zfXsGsEmJkGUGPcCxV6Asa0mOKLxvw7YrYep+H1w0rfG
         CWvgIzNOQjLXu8B8HoGAtqrsUNYk0SbS+8VJ1jngRU2zcFosptDMF0s4XdoTavHJZ71v
         nXrw==
X-Gm-Message-State: AOAM533ecP6BSXEKT1c3dw/BgyWJgzJcDygSu6wM8THeYleVI03pxjPt
        vjI//5RRRVkAMjzZRgsc7RvYGUQNWWw=
X-Google-Smtp-Source: ABdhPJzgifMCVdj2wd8NTgdTqCAaqPNmob6DgKLSL5+bY5GcQy0FrmWK2lvoSqwKoNI1I6x3mlnToJMV1M4=
Sender: "figiel via sendgmr" <figiel@odra.waw.corp.google.com>
X-Received: from odra.waw.corp.google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
 (user=figiel job=sendgmr) by 2002:a0c:fdec:: with SMTP id m12mr7025364qvu.11.1611687261291;
 Tue, 26 Jan 2021 10:54:21 -0800 (PST)
Date:   Tue, 26 Jan 2021 19:54:12 +0100
Message-Id: <20210126185412.175204-1-figiel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3] fs/proc: Expose RSEQ configuration
From:   Piotr Figiel <figiel@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk,
        peterz@infradead.org, paulmck@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com, Piotr Figiel <figiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For userspace checkpoint and restore (C/R) some way of getting process
state containing RSEQ configuration is needed.

There are two ways this information is going to be used:
 - to re-enable RSEQ for threads which had it enabled before C/R
 - to detect if a thread was in a critical section during C/R

Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
using the address registered before C/R.

Detection whether the thread is in a critical section during C/R is
needed to enforce behavior of RSEQ abort during C/R. Attaching with
ptrace() before registers are dumped itself doesn't cause RSEQ abort.
Restoring the instruction pointer within the critical section is
problematic because rseq_cs may get cleared before the control is
passed to the migrated application code leading to RSEQ invariants not
being preserved.

To achieve above goals expose the RSEQ structure address and the
signature value with the new per-thread procfs file "rseq".

Signed-off-by: Piotr Figiel <figiel@google.com>

---

v3:
 - added locking so that the proc file always shows consistent pair of
   RSEQ ABI address and the signature
 - changed string formatting to use %px for the RSEQ ABI address
v2:
 - fixed string formatting for 32-bit architectures
v1:
 - https://lkml.kernel.org/r/20210113174127.2500051-1-figiel@google.com

---
 fs/exec.c      |  2 ++
 fs/proc/base.c | 22 ++++++++++++++++++++++
 kernel/rseq.c  |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 5d4d52039105..5d84f98847f1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1830,7 +1830,9 @@ static int bprm_execve(struct linux_binprm *bprm,
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	task_lock(current);
 	rseq_execve(current);
+	task_unlock(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..89232329d966 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -662,6 +662,22 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 
 	return 0;
 }
+
+#ifdef CONFIG_RSEQ
+static int proc_pid_rseq(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	int res = lock_trace(task);
+
+	if (res)
+		return res;
+	task_lock(task);
+	seq_printf(m, "%px %08x\n", task->rseq, task->rseq_sig);
+	task_unlock(task);
+	unlock_trace(task);
+	return 0;
+}
+#endif /* CONFIG_RSEQ */
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 /************************************************************************/
@@ -3182,6 +3198,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",       S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
@@ -3522,6 +3541,9 @@ static const struct pid_entry tid_base_stuff[] = {
 			 &proc_pid_set_comm_operations, {}),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",   S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",      S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",   S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",      S_IRUGO, proc_tid_stat),
diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937..6aea67878065 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -322,8 +322,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		ret = rseq_reset_rseq_cpu_id(current);
 		if (ret)
 			return ret;
+		task_lock(current);
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		task_unlock(current);
 		return 0;
 	}
 
@@ -353,8 +355,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+	task_lock(current);
 	current->rseq = rseq;
 	current->rseq_sig = sig;
+	task_unlock(current);
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
-- 
2.30.0.280.ga3ce27912f-goog

