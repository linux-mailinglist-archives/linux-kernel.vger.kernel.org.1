Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84CB2D1C37
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgLGVeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLGVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:34:46 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2965EC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 13:34:06 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id c11so12292586qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 13:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cn9dwjO1FYcWQADH/EAbIN2YNbcmphKHUetK7tfw3zE=;
        b=dnQQoB3k6QHILcZmviO5bBY/QhSefQqhrh5pI+3bZlnZ3lYYhNucWT5TuALFZuG6SZ
         KYlA0JraZnvnDYYLj84AHk2OBZy/Ui9ij/oF4bBlNeYxhiKCk+Vuohai3mibhXse6Nb6
         1Uyl7pA06nDCKPjU78q3A/W/BqF/muoe8wTgUcQqOcIA7GPlpy5si0/vr+Z4xzRuktjD
         NbGTU5Bq8SnLyic3QrxqznxJ5orwUF4LscJuc4U0dWqA3SWdK0WdJ/+sHJR7P8JZAYLt
         i8Aw6q01DfbqOM8iInXDUdExQz01s4eBnqt2+ROc/zfxK8KxJdwfI4rmvA9hkU/F4vgb
         W8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cn9dwjO1FYcWQADH/EAbIN2YNbcmphKHUetK7tfw3zE=;
        b=GtgObFCklhEawPA795rTf2YtHLLlYsY/lCo1HzaNYBWTjT2WQRjkQBH2wF53G4NfBB
         LUJD5U3EPUgCcjrmseKkMgYG+B8CLZJMEUbUZ0j5bPNEXZT8dMguav/vvlJu/SvVgJUB
         W4cqwzivC84jebTUuD4iSuieN8NqmlUGbdkBUqOACiHv5cOnzeK/U0TfgmwDP4XxnXCx
         8FItqR+20OIVNoLNnfiAdxPpHhd6cJBF6hmjTFbVFdALBWfCDRKDeFv77kdzbF6U1SQL
         tV/vwl95A90U4lmtPqPOufO93yDNyfmA632aovrRbiLW8JCw5Gpe4YyTNHiC4OfN9rX9
         ZAtw==
X-Gm-Message-State: AOAM531JQ1XfRF2xs3LY4J1a4nG8PQBlX/joMPSxaKT3H8iPcM/PJGT+
        agIgA/wN/m7JnxH1Z/8MyyeWW1pJxBYW2b/VyKOq
X-Google-Smtp-Source: ABdhPJz1Y+Ryu8EzW9OiqR9q8hSwEINfWTKKTsIABv1Zwb2CxN34za/Az0UvjCylTJC6O1mOPnSZZSZg4lyXd3ue6zRu
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:443:: with SMTP id
 cc3mr23112125qvb.53.1607376844581; Mon, 07 Dec 2020 13:34:04 -0800 (PST)
Date:   Mon,  7 Dec 2020 13:33:58 -0800
Message-Id: <20201207213358.573750-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v3] mm: mmap_lock: fix use-after-free race and css ref leak in tracepoints
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
is that an ongoing trace event might race with the tracepoint being
disabled (and therefore the _unreg() callback being called). Consider
this ordering:

T1: trace event fires, get_mm_memcg_path() is called
T1: get_memcg_path_buf() returns a buffer pointer
T2: trace_mmap_lock_unreg() is called, buffers are freed
T1: cgroup_path() is called with the now-freed buffer

The solution in this commit is to switch to mutex + RCU. With the RCU
API we can first stop new buffers from being handed out, then wait for
existing users to finish, and *then* free the buffers.

I have a simple reproducer program which spins up two pools of threads,
doing the following in a tight loop:

  Pool 1:
  mmap(NULL, 4096, PROT_READ | PROT_WRITE,
       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)
  munmap()

  Pool 2:
  echo 1 > /sys/kernel/debug/tracing/events/mmap_lock/enable
  echo 0 > /sys/kernel/debug/tracing/events/mmap_lock/enable

This triggers the use-after-free very quickly. With this patch, I let it
run for an hour without any BUGs.

While fixing this, I also noticed and fixed a css ref leak. Previously
we called get_mem_cgroup_from_mm(), but we never called css_put() to
release that reference. get_mm_memcg_path() now does this properly.

[1]: https://syzkaller.appspot.com/bug?extid=19e6dd9943972fa1c58a

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/mmap_lock.c | 123 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 40 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 12af8f1b8a14..dcdde4f722a4 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -6,9 +6,10 @@
 #include <linux/cgroup.h>
 #include <linux/memcontrol.h>
 #include <linux/mmap_lock.h>
+#include <linux/mutex.h>
 #include <linux/percpu.h>
+#include <linux/rcupdate.h>
 #include <linux/smp.h>
-#include <linux/spinlock.h>
 #include <linux/trace_events.h>
 
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
@@ -23,8 +24,8 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
  * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
  * been made.
  */
-static DEFINE_SPINLOCK(reg_lock);
-static int reg_refcount;
+static DEFINE_MUTEX(reg_lock);
+static int reg_refcount; /* Protected by reg_lock. */
 
 /*
  * Size of the buffer for memcg path names. Ignoring stack trace support,
@@ -38,99 +39,141 @@ static int reg_refcount;
  */
 #define CONTEXT_COUNT 4
 
-DEFINE_PER_CPU(char *, memcg_path_buf);
-DEFINE_PER_CPU(int, memcg_path_buf_idx);
+static DEFINE_PER_CPU(char __rcu *, memcg_path_buf);
+static char **tmp_bufs;
+static DEFINE_PER_CPU(int, memcg_path_buf_idx);
+
+/* Called with reg_lock held. */
+static void free_memcg_path_bufs(void)
+{
+	int cpu;
+	char **old = tmp_bufs;
+
+	for_each_possible_cpu(cpu) {
+		*(old++) = rcu_dereference_protected(
+			per_cpu(memcg_path_buf, cpu),
+			lockdep_is_held(&reg_lock));
+		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), NULL);
+	}
+
+	/* Wait for inflight memcg_path_buf users to finish. */
+	synchronize_rcu();
+
+	old = tmp_bufs;
+	for_each_possible_cpu(cpu) {
+		kfree(*(old++));
+	}
+
+	kfree(tmp_bufs);
+	tmp_bufs = NULL;
+}
 
 int trace_mmap_lock_reg(void)
 {
-	unsigned long flags;
 	int cpu;
+	char *new;
 
-	spin_lock_irqsave(&reg_lock, flags);
+	mutex_lock(&reg_lock);
 
+	/* If the refcount is going 0->1, proceed with allocating buffers. */
 	if (reg_refcount++)
 		goto out;
 
+	tmp_bufs = kmalloc_array(num_possible_cpus(), sizeof(*tmp_bufs),
+				 GFP_KERNEL);
+	if (tmp_bufs == NULL)
+		goto out_fail;
+
 	for_each_possible_cpu(cpu) {
-		per_cpu(memcg_path_buf, cpu) = NULL;
-	}
-	for_each_possible_cpu(cpu) {
-		per_cpu(memcg_path_buf, cpu) = kmalloc(
-			MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_NOWAIT);
-		if (per_cpu(memcg_path_buf, cpu) == NULL)
-			goto out_fail;
-		per_cpu(memcg_path_buf_idx, cpu) = 0;
+		new = kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_KERNEL);
+		if (new == NULL)
+			goto out_fail_free;
+		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), new);
+		/* Don't need to wait for inflights, they'd have gotten NULL. */
 	}
 
 out:
-	spin_unlock_irqrestore(&reg_lock, flags);
+	mutex_unlock(&reg_lock);
 	return 0;
 
+out_fail_free:
+	free_memcg_path_bufs();
 out_fail:
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(memcg_path_buf, cpu) != NULL)
-			kfree(per_cpu(memcg_path_buf, cpu));
-		else
-			break;
-	}
-
+	/* Since we failed, undo the earlier ref increment. */
 	--reg_refcount;
 
-	spin_unlock_irqrestore(&reg_lock, flags);
+	mutex_unlock(&reg_lock);
 	return -ENOMEM;
 }
 
 void trace_mmap_lock_unreg(void)
 {
-	unsigned long flags;
-	int cpu;
-
-	spin_lock_irqsave(&reg_lock, flags);
+	mutex_lock(&reg_lock);
 
+	/* If the refcount is going 1->0, proceed with freeing buffers. */
 	if (--reg_refcount)
 		goto out;
 
-	for_each_possible_cpu(cpu) {
-		kfree(per_cpu(memcg_path_buf, cpu));
-	}
+	free_memcg_path_bufs();
 
 out:
-	spin_unlock_irqrestore(&reg_lock, flags);
+	mutex_unlock(&reg_lock);
 }
 
 static inline char *get_memcg_path_buf(void)
 {
+	char *buf;
 	int idx;
 
+	rcu_read_lock();
+	buf = rcu_dereference(*this_cpu_ptr(&memcg_path_buf));
+	if (buf == NULL) {
+		rcu_read_unlock();
+		return NULL;
+	}
 	idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
 	      MEMCG_PATH_BUF_SIZE;
-	return &this_cpu_read(memcg_path_buf)[idx];
+	return &buf[idx];
 }
 
 static inline void put_memcg_path_buf(void)
 {
 	this_cpu_sub(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE);
+	rcu_read_unlock();
 }
 
 /*
  * Write the given mm_struct's memcg path to a percpu buffer, and return a
- * pointer to it. If the path cannot be determined, NULL is returned.
+ * pointer to it. If the path cannot be determined, or no buffer was available
+ * (because the trace event is being unregistered), NULL is returned.
  *
  * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
  * disabled by the caller before calling us, and re-enabled only after the
  * caller is done with the pointer.
+ *
+ * The caller must call put_memcg_path_buf() once the buffer is no longer
+ * needed. This must be done while preemption is still disabled.
  */
 static const char *get_mm_memcg_path(struct mm_struct *mm)
 {
+	char *buf = NULL;
 	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
 
-	if (memcg != NULL && likely(memcg->css.cgroup != NULL)) {
-		char *buf = get_memcg_path_buf();
+	if (memcg == NULL)
+		goto out;
+	if (unlikely(memcg->css.cgroup == NULL))
+		goto out_put;
 
-		cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
-		return buf;
-	}
-	return NULL;
+	buf = get_memcg_path_buf();
+	if (buf == NULL)
+		goto out_put;
+
+	cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
+
+out_put:
+	css_put(&memcg->css);
+out:
+	return buf;
 }
 
 #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
-- 
2.29.2.576.ga3fc446d84-goog

