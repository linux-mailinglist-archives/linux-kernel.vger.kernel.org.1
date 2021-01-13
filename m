Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F712F5146
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbhAMRmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbhAMRmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:42:52 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB33C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:42:11 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m8so2051127qvt.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HzF3MXTeCTbRlxf3/1M1iugn5XEMK7QFQKjoigiYDkw=;
        b=vOf1EwIqh/xzs3yDIbdGzIP9xv58y63igsPzrCIYRFDU5u1DbrYovhxLFnx/lx3rsi
         8dEfz3ptVFQZO7IxTOvw7tXFTHNm0k16Nsiy+QpnbDi4m8M3arl4UmMoGqWWqV1/hwMd
         lVgc5YdCdmwCASAPCeqGyqOOVpurRNnfQZN8FU14pNj5xVkCcNinQJkz6zNalyDQeh8j
         XLL8T9R8CxL1ZDQTSQfw4oW9z9ZYWKLfafANE1046olShYDsppf5ZQExmHLxhIHnidAy
         cZQqtDuvl2AUVKe+5gtZGSK2G82Ma9yREVLVPNGN48nuU2bFltI/gjaf4eU3dhIoNOIY
         EqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HzF3MXTeCTbRlxf3/1M1iugn5XEMK7QFQKjoigiYDkw=;
        b=HXEpZ12+jBCkM2rkHtw/yiY7iIrYJsOErvfMMIJJ/JsYrWne3DyozjXi9Lnig9Ty9z
         6LdpIZlsMGO8je4qlil39ZxwxizM0eWBjFc/kSaLvdA60bJwPBzgmZIPjzHHrqQfdrx7
         nCHCuBDUXN83yxz6Z2ztRViizwQsIddRRIrOMBXKPXGMhQDRPimGbnbQV8jQY1lqB0l6
         FVSGg+sB+Ju/4DKgAP19z5c/+jjWrqOCv6q7ugUsXhilcM43C2uTdvmFafpztOPTStuv
         KEZI4SxZukRctEAQww6tXN9fud0+lG8kzbBEbM8DM/VuPOBpi/K9QoT4udztIPd6N1ek
         JxWQ==
X-Gm-Message-State: AOAM531Wj57a4cN9OC953LWQz5eih1ecYnu4rqXSxw1CC7w6DwRj/LHs
        5PthH41T4EensuAjYTI/Lv4EXqmko6Y=
X-Google-Smtp-Source: ABdhPJzju57ZTb0aPBWIY91s0bPW4mHdG7ZlTu77EVKBJtuUg523fV38D6+xcSZwxfb/9AaMWh+yBMM91ok=
Sender: "figiel via sendgmr" <figiel@odra.waw.corp.google.com>
X-Received: from odra.waw.corp.google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
 (user=figiel job=sendgmr) by 2002:a0c:b59a:: with SMTP id g26mr3204411qve.26.1610559731077;
 Wed, 13 Jan 2021 09:42:11 -0800 (PST)
Date:   Wed, 13 Jan 2021 18:41:27 +0100
Message-Id: <20210113174127.2500051-1-figiel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] fs/proc: Expose RSEQ configuration
From:   Piotr Figiel <figiel@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, mathieu.desnoyers@efficios.com
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

Signed-off-by: Piotr Figiel <figiel@google.com>
---
 fs/proc/base.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..3d4712ac4370 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -662,6 +662,20 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 
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
+	seq_printf(m, "0x%llx 0x%x\n", (uint64_t)task->rseq, task->rseq_sig);
+	unlock_trace(task);
+	return 0;
+}
+#endif /* CONFIG_RSEQ */
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 /************************************************************************/
@@ -3182,6 +3196,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",       S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
@@ -3522,6 +3539,9 @@ static const struct pid_entry tid_base_stuff[] = {
 			 &proc_pid_set_comm_operations, {}),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",   S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",      S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",   S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",      S_IRUGO, proc_tid_stat),
-- 
2.30.0.284.gd98b1dd5eaa7-goog

