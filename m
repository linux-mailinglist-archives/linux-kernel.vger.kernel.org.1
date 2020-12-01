Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD66D2CAD6C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgLAUdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgLAUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:33:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C20C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:32:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so3853080ybq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ZqJGffJqojVDywd5iA+saKYtaK0ksB5X2p2c7/wMo68=;
        b=sRtSCv85U3mgoHTCCKuIe3IydVP5JCqhrlNOpmTHf18GDUJQGfjjJoS0BaIGErYKs0
         a8mGMrBK4gcH8us++/YmgyvvIqkNJdWLhMvKfDeNlZV23iYo1x0/rxegaGCp29Fmq81q
         oPWZvMO88lTpddhb9ZeGGDD2XtLENKrw6+B0xR35abxe/X2L5rk/+dgI/j0Fk4pJttUw
         Oho+f4HJWpAis/D0R6i/EfHxxV1CcsXmBdT0Uru08e47UuFQG260Ed10HubOTOdwqvmS
         PHMFqirXeL0h0lf6V/UlTJ7u7M1V1Ki6t8zr/OcexcA0olByfRwqlJ/yHd1uIyz+WaTN
         xJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ZqJGffJqojVDywd5iA+saKYtaK0ksB5X2p2c7/wMo68=;
        b=qBozrA83AsxwZF99AcbB/tSkPfDWG30ITeTz0JDSgMgvwDQqQtfSPBKwvXJPa1zQD2
         azFpS7j0TA4M9aFjqzPpWDi6ZSeYN5fpcvPo4hnvh3o8LLMg08OHgUCKM7kFx8wTVZjp
         LDOrp2qBJtJaLdmeTguRoi8iH/ziJDs/5r6v0mwWv6rSyU/vRkGKqjOjpYunH2VcTKud
         9Mgk5hAZlHPZe0seAS0r8snSTlWqsdbbXjzptxoYbPMFZj3qV7qjpPGan4tsxJo+iFiv
         rGB4k5mXBtAu/dbLkVA5lnt0LsRnS/9L7rRjaDICUnEKKbsx/k2kB1WUZK/dCVV9dtqT
         ZkXg==
X-Gm-Message-State: AOAM531VPYy9gJ7cU9l9E91PEfc/fI8gxeyfly49yzl4ONmY0R5oXdMv
        j512DFk1BPxkNVpm41yTJO6HGzbc2N+gbvjBspWg
X-Google-Smtp-Source: ABdhPJz2JxxtHnwSdlcwZziGYIxl1ieUUdgfqJTu+cxGeypLzwESvA4JNhON3W17leeRXqzI+9CwY7QJBly4r0oCrsPK
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:be52:: with SMTP id
 d18mr5875372ybm.176.1606854774534; Tue, 01 Dec 2020 12:32:54 -0800 (PST)
Date:   Tue,  1 Dec 2020 12:32:49 -0800
Message-Id: <20201201203249.4172751-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] mm: mmap_lock: fix use-after-free race and css ref leak in tracepoints
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
Cc:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        dsahern@kernel.org, gregkh@linuxfoundation.org, kuba@kernel.org,
        liuhangbin@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org,
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
 mm/mmap_lock.c | 104 +++++++++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 38 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 12af8f1b8a14..5a3349bf1501 100644
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
@@ -38,99 +39,126 @@ static int reg_refcount;
  */
 #define CONTEXT_COUNT 4
 
-DEFINE_PER_CPU(char *, memcg_path_buf);
-DEFINE_PER_CPU(int, memcg_path_buf_idx);
+static DEFINE_PER_CPU(char __rcu *, memcg_path_buf);
+static DEFINE_PER_CPU(int, memcg_path_buf_idx);
+
+/* Called with reg_lock held. */
+static void free_memcg_path_bufs(void)
+{
+	int cpu;
+	char *old;
+
+	for_each_possible_cpu(cpu) {
+		old = rcu_dereference_protected(per_cpu(memcg_path_buf, cpu),
+						lockdep_is_held(&reg_lock));
+		if (old == NULL)
+			break;
+		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), NULL);
+		/* Wait for inflight memcg_path_buf users to finish. */
+		synchronize_rcu();
+		kfree(old);
+	}
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
 
 	for_each_possible_cpu(cpu) {
-		per_cpu(memcg_path_buf, cpu) = NULL;
-	}
-	for_each_possible_cpu(cpu) {
-		per_cpu(memcg_path_buf, cpu) = kmalloc(
-			MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_NOWAIT);
-		if (per_cpu(memcg_path_buf, cpu) == NULL)
+		new = kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_KERNEL);
+		if (new == NULL)
 			goto out_fail;
-		per_cpu(memcg_path_buf_idx, cpu) = 0;
+		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), new);
+		/* Don't need to wait for inflights, they'd have gotten NULL. */
 	}
 
 out:
-	spin_unlock_irqrestore(&reg_lock, flags);
+	mutex_unlock(&reg_lock);
 	return 0;
 
 out_fail:
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(memcg_path_buf, cpu) != NULL)
-			kfree(per_cpu(memcg_path_buf, cpu));
-		else
-			break;
-	}
+	free_memcg_path_bufs();
 
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
+	if (buf == NULL)
+		return NULL;
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
2.29.2.454.gaff20da3a2-goog

