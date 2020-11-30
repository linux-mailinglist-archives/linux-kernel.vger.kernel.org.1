Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1E2C92CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbgK3XgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgK3XgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:36:04 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA82C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:35:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b4so39026plr.15
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=SdCffT91DJd0x/mWRdc6XWua7OypxDLtXhbKvEN3B+Y=;
        b=WwtcU9ge46BAEwhOlL6ngDU1bVo/gN6z3y7MNY6UjgB1mRPAgNAdnvo5OlBMn+qccy
         xMMJ0fo071Akl9hcbkQeKQAxB06GyjEVhcUMTd5zOJ72uDHLMKRCFKbarYuIG3W9d268
         OPkPTdbdXXSthAAfxoUoHlJsHLOOhgNYVAS1tMrL+xpJhTCeb2wms7WXcf67tHYUoZ0t
         DU74a0DZhTP8IIVvPqnJoqQ2eUxwD6Kfa3ji+Jcz5rSJs/4gQyLNHurovHnlRCIHifUe
         vP+b0LncMeJj8feTO9WqGWE8I303y3xC97waz647zgZd9sFyMZ1oesOdvLcW6W3Xc4pk
         6PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=SdCffT91DJd0x/mWRdc6XWua7OypxDLtXhbKvEN3B+Y=;
        b=rgGreJoxO09+Dk5usNUw6b3j6Uil+XV7VwchA1AB/GGlwZ91kMgZhQPpRSliT2asdQ
         EZqHu39ShUCexUOOUwFTcKcF/l3K0VqiIdHbSFh3jfNgLo1lBhbVHDTQX/S/84LCqo1W
         pwvP1kn5LUK1x+1nuwlTTpovYoCV9gYLmN7KxvBVNTiZtYSR8OO5HuACJo/jr+vBrtUb
         Dajh1zwJbOllECso5/sswtSBDaZiQA6Cn7pSlXc2PjQVVDuCTYqhDPCPX2S8m7y4iM/o
         235KKRlFnX+l2z42EedkOKveW5XqfzyvOwr79aqv9NcXhqe3L2CewYWLYLSCfa9VYAX9
         Xtng==
X-Gm-Message-State: AOAM5317q2ANBJkTPxKUIRRurNfp0Zf7HS54QRf3st+Z8yF8Xs6z4gNm
        SPUftugAeTb4rgR01ezUmFLSI02ucnBqZD7wfGDy
X-Google-Smtp-Source: ABdhPJwds+UAfYQft2dHxSUmHaNhiKXHWR9FSiQ/0vbuy2tnzqRr+Kx+s0BU1nhzlCzrfIssMvibqTIxiFjFP6JMzO0N
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a63:ad4a:: with SMTP id
 y10mr19846988pgo.176.1606779323651; Mon, 30 Nov 2020 15:35:23 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:35:04 -0800
Message-Id: <20201130233504.3725241-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak in tracepoints
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

The solution in this commit is to modify trace_mmap_lock_unreg() to
first stop new buffers from being handed out, and then to wait (spin)
until any existing buffer references are dropped (i.e., those trace
events complete).

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

Fixes: 0f818c4bc1f3 ("mm: mmap_lock: add tracepoints around lock acquisition")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/mmap_lock.c | 100 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 12af8f1b8a14..be38dc58278b 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -3,6 +3,7 @@
 #include <trace/events/mmap_lock.h>
 
 #include <linux/mm.h>
+#include <linux/atomic.h>
 #include <linux/cgroup.h>
 #include <linux/memcontrol.h>
 #include <linux/mmap_lock.h>
@@ -18,13 +19,28 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
 #ifdef CONFIG_MEMCG
 
 /*
- * Our various events all share the same buffer (because we don't want or need
- * to allocate a set of buffers *per event type*), so we need to protect against
- * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
- * been made.
+ * This is unfortunately complicated... _reg() and _unreg() may be called
+ * in parallel, separately for each of our three event types. To save memory,
+ * all of the event types share the same buffers. Furthermore, trace events
+ * might happen in parallel with _unreg(); we need to ensure we don't free the
+ * buffers before all inflights have finished. Because these events happen
+ * "frequently", we also want to prevent new inflights from starting once the
+ * _unreg() process begins. And, for performance reasons, we want to avoid any
+ * locking in the trace event path.
+ *
+ * So:
+ *
+ * - Use a spinlock to serialize _reg() and _unreg() calls.
+ * - Keep track of nested _reg() calls with a lock-protected counter.
+ * - Define a flag indicating whether or not unregistration has begun (and
+ *   therefore that there should be no new buffer uses going forward).
+ * - Keep track of inflight buffer users with a reference count.
  */
 static DEFINE_SPINLOCK(reg_lock);
-static int reg_refcount;
+static int reg_types_rc; /* Protected by reg_lock. */
+static bool unreg_started; /* Doesn't need synchronization. */
+/* atomic_t instead of refcount_t, as we want ordered inc without locks. */
+static atomic_t inflight_rc = ATOMIC_INIT(0);
 
 /*
  * Size of the buffer for memcg path names. Ignoring stack trace support,
@@ -46,9 +62,14 @@ int trace_mmap_lock_reg(void)
 	unsigned long flags;
 	int cpu;
 
+	/*
+	 * Serialize _reg() and _unreg(). Without this, e.g. _unreg() might
+	 * start cleaning up while _reg() is only partially completed.
+	 */
 	spin_lock_irqsave(&reg_lock, flags);
 
-	if (reg_refcount++)
+	/* If the refcount is going 0->1, proceed with allocating buffers. */
+	if (reg_types_rc++)
 		goto out;
 
 	for_each_possible_cpu(cpu) {
@@ -62,6 +83,11 @@ int trace_mmap_lock_reg(void)
 		per_cpu(memcg_path_buf_idx, cpu) = 0;
 	}
 
+	/* Reset unreg_started flag, allowing new trace events. */
+	WRITE_ONCE(unreg_started, false);
+	/* Add the registration +1 to the inflight refcount. */
+	atomic_inc(&inflight_rc);
+
 out:
 	spin_unlock_irqrestore(&reg_lock, flags);
 	return 0;
@@ -74,7 +100,8 @@ int trace_mmap_lock_reg(void)
 			break;
 	}
 
-	--reg_refcount;
+	/* Since we failed, undo the earlier increment. */
+	--reg_types_rc;
 
 	spin_unlock_irqrestore(&reg_lock, flags);
 	return -ENOMEM;
@@ -87,9 +114,23 @@ void trace_mmap_lock_unreg(void)
 
 	spin_lock_irqsave(&reg_lock, flags);
 
-	if (--reg_refcount)
+	/* If the refcount is going 1->0, proceed with freeing buffers. */
+	if (--reg_types_rc)
 		goto out;
 
+	/* This was the last registration; start preventing new events... */
+	WRITE_ONCE(unreg_started, true);
+	/* Remove the registration +1 from the inflight refcount. */
+	atomic_dec(&inflight_rc);
+	/*
+	 * Wait for inflight refcount to be zero (all inflights stopped). Since
+	 * we have a spinlock we can't sleep, so just spin. Because trace events
+	 * are "fast", and because we stop new inflights from starting at this
+	 * point with unreg_started, this should be a short spin.
+	 */
+	while (atomic_read(&inflight_rc))
+		barrier();
+
 	for_each_possible_cpu(cpu) {
 		kfree(per_cpu(memcg_path_buf, cpu));
 	}
@@ -102,6 +143,20 @@ static inline char *get_memcg_path_buf(void)
 {
 	int idx;
 
+	/*
+	 * If unregistration is happening, stop. Yes, this check is racy;
+	 * that's fine. It just means _unreg() might spin waiting for an extra
+	 * event or two. Use-after-free is actually prevented by the refcount.
+	 */
+	if (READ_ONCE(unreg_started))
+		return NULL;
+	/*
+	 * Take a reference, unless the registration +1 has been released
+	 * and there aren't already existing inflights (refcount is zero).
+	 */
+	if (!atomic_inc_not_zero(&inflight_rc))
+		return NULL;
+
 	idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
 	      MEMCG_PATH_BUF_SIZE;
 	return &this_cpu_read(memcg_path_buf)[idx];
@@ -110,27 +165,42 @@ static inline char *get_memcg_path_buf(void)
 static inline void put_memcg_path_buf(void)
 {
 	this_cpu_sub(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE);
+	/* We're done with this buffer; drop the reference. */
+	atomic_dec(&inflight_rc);
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

