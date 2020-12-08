Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC42D200F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLHB2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgLHB2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:28:19 -0500
Date:   Mon, 7 Dec 2020 17:27:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607390857;
        bh=QlkTVDWdDlD9axCLfz262+JNRR6RGZ1gEQl4dGSiZ4Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=cHlyroulfQGJmDEvarbejCUdP9K8ZEq/+OVYpdU6bRV90ly6mp0F728Mz3MtQabRC
         RGUs2lsWv2qK/bInkoLL0TcxhpHJY5UI7MUp81VPn0ZVhu//q2bAT7GUZwqKSRUZXz
         JwRnbrKKFdlImxF7DGBGmt/jn/CQ1hl7XrWc/ZPE=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: mmap_lock: fix use-after-free race and css ref
 leak in tracepoints
Message-Id: <20201207172735.29a0b3558a11cc194a959052@linux-foundation.org>
In-Reply-To: <20201207213358.573750-1-axelrasmussen@google.com>
References: <20201207213358.573750-1-axelrasmussen@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Dec 2020 13:33:58 -0800 Axel Rasmussen <axelrasmussen@google.com> wrote:

> syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
> is that an ongoing trace event might race with the tracepoint being
> disabled (and therefore the _unreg() callback being called). Consider
> this ordering:
> 
> T1: trace event fires, get_mm_memcg_path() is called
> T1: get_memcg_path_buf() returns a buffer pointer
> T2: trace_mmap_lock_unreg() is called, buffers are freed
> T1: cgroup_path() is called with the now-freed buffer
> 
> The solution in this commit is to switch to mutex + RCU. With the RCU
> API we can first stop new buffers from being handed out, then wait for
> existing users to finish, and *then* free the buffers.
> 
> I have a simple reproducer program which spins up two pools of threads,
> doing the following in a tight loop:
> 
>   Pool 1:
>   mmap(NULL, 4096, PROT_READ | PROT_WRITE,
>        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)
>   munmap()
> 
>   Pool 2:
>   echo 1 > /sys/kernel/debug/tracing/events/mmap_lock/enable
>   echo 0 > /sys/kernel/debug/tracing/events/mmap_lock/enable
> 
> This triggers the use-after-free very quickly. With this patch, I let it
> run for an hour without any BUGs.
> 
> While fixing this, I also noticed and fixed a css ref leak. Previously
> we called get_mem_cgroup_from_mm(), but we never called css_put() to
> release that reference. get_mm_memcg_path() now does this properly.
> 
> [1]: https://syzkaller.appspot.com/bug?extid=19e6dd9943972fa1c58a
> 

So... how does this fix differ from the previous version of this fix?

The difference is quite large:

--- a/mm/mmap_lock.c~mmap_lock-add-tracepoints-around-lock-acquisition-fix-fix
+++ a/mm/mmap_lock.c
@@ -3,13 +3,13 @@
 #include <trace/events/mmap_lock.h>
 
 #include <linux/mm.h>
-#include <linux/atomic.h>
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
@@ -19,28 +19,13 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_relea
 #ifdef CONFIG_MEMCG
 
 /*
- * This is unfortunately complicated... _reg() and _unreg() may be called
- * in parallel, separately for each of our three event types. To save memory,
- * all of the event types share the same buffers. Furthermore, trace events
- * might happen in parallel with _unreg(); we need to ensure we don't free the
- * buffers before all inflights have finished. Because these events happen
- * "frequently", we also want to prevent new inflights from starting once the
- * _unreg() process begins. And, for performance reasons, we want to avoid any
- * locking in the trace event path.
- *
- * So:
- *
- * - Use a spinlock to serialize _reg() and _unreg() calls.
- * - Keep track of nested _reg() calls with a lock-protected counter.
- * - Define a flag indicating whether or not unregistration has begun (and
- *   therefore that there should be no new buffer uses going forward).
- * - Keep track of inflight buffer users with a reference count.
+ * Our various events all share the same buffer (because we don't want or need
+ * to allocate a set of buffers *per event type*), so we need to protect against
+ * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
+ * been made.
  */
-static DEFINE_SPINLOCK(reg_lock);
-static int reg_types_rc; /* Protected by reg_lock. */
-static bool unreg_started; /* Doesn't need synchronization. */
-/* atomic_t instead of refcount_t, as we want ordered inc without locks. */
-static atomic_t inflight_rc = ATOMIC_INIT(0);
+static DEFINE_MUTEX(reg_lock);
+static int reg_refcount; /* Protected by reg_lock. */
 
 /*
  * Size of the buffer for memcg path names. Ignoring stack trace support,
@@ -54,119 +39,107 @@ static atomic_t inflight_rc = ATOMIC_INI
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
 
-	/*
-	 * Serialize _reg() and _unreg(). Without this, e.g. _unreg() might
-	 * start cleaning up while _reg() is only partially completed.
-	 */
-	spin_lock_irqsave(&reg_lock, flags);
+	mutex_lock(&reg_lock);
 
 	/* If the refcount is going 0->1, proceed with allocating buffers. */
-	if (reg_types_rc++)
+	if (reg_refcount++)
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
 
-	/* Reset unreg_started flag, allowing new trace events. */
-	WRITE_ONCE(unreg_started, false);
-	/* Add the registration +1 to the inflight refcount. */
-	atomic_inc(&inflight_rc);
-
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
+	/* Since we failed, undo the earlier ref increment. */
+	--reg_refcount;
 
-	/* Since we failed, undo the earlier increment. */
-	--reg_types_rc;
-
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
 
 	/* If the refcount is going 1->0, proceed with freeing buffers. */
-	if (--reg_types_rc)
+	if (--reg_refcount)
 		goto out;
 
-	/* This was the last registration; start preventing new events... */
-	WRITE_ONCE(unreg_started, true);
-	/* Remove the registration +1 from the inflight refcount. */
-	atomic_dec(&inflight_rc);
-	/*
-	 * Wait for inflight refcount to be zero (all inflights stopped). Since
-	 * we have a spinlock we can't sleep, so just spin. Because trace events
-	 * are "fast", and because we stop new inflights from starting at this
-	 * point with unreg_started, this should be a short spin.
-	 */
-	while (atomic_read(&inflight_rc))
-		barrier();
-
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
 
-	/*
-	 * If unregistration is happening, stop. Yes, this check is racy;
-	 * that's fine. It just means _unreg() might spin waiting for an extra
-	 * event or two. Use-after-free is actually prevented by the refcount.
-	 */
-	if (READ_ONCE(unreg_started))
+	rcu_read_lock();
+	buf = rcu_dereference(*this_cpu_ptr(&memcg_path_buf));
+	if (buf == NULL) {
+		rcu_read_unlock();
 		return NULL;
-	/*
-	 * Take a reference, unless the registration +1 has been released
-	 * and there aren't already existing inflights (refcount is zero).
-	 */
-	if (!atomic_inc_not_zero(&inflight_rc))
-		return NULL;
-
+	}
 	idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
 	      MEMCG_PATH_BUF_SIZE;
-	return &this_cpu_read(memcg_path_buf)[idx];
+	return &buf[idx];
 }
 
 static inline void put_memcg_path_buf(void)
 {
 	this_cpu_sub(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE);
-	/* We're done with this buffer; drop the reference. */
-	atomic_dec(&inflight_rc);
+	rcu_read_unlock();
 }
 
 /*
_

