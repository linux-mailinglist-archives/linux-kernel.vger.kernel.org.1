Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663E12AAFA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgKICzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:55:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:55560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgKICzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:55:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "To"
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1A38ABF4;
        Mon,  9 Nov 2020 02:55:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 09 Nov 2020 13:54:59 +1100
Subject: [PATCH rfc] workqueue: honour cond_resched() more effectively.
cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Michal Hocko <mhocko@suse.com>
cc:     linux-kernel@vger.kernel.org
Message-ID: <87v9efp7cs.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


If a worker task for a normal (bound, non-CPU-intensive) calls
cond_resched(), this allows other non-workqueue processes to run, but
does *not* allow other workqueue workers to run.  This is because
workqueue will only attempt to run one task at a time on each CPU,
unless the current task actually sleeps.

This is already a problem for should_reclaim_retry() in mm/page_alloc.c,
which inserts a small sleep just to convince workqueue to allow other
workers to run.

It can also be a problem for NFS when closing a very large file (e.g.
100 million pages in memory).  NFS can call the final iput() from a
workqueue, which can then take long enough to trigger a workqueue-lockup
warning, and long enough for performance problems to be observed.

I added a WARN_ON_ONCE() in cond_resched() to report when it is run from
a workqueue, and got about 20 hits during boot, many of system_wq (aka
"events") which suggests there is a real chance that worker are being
delayed unnecessarily be tasks which are written to politely relinquish
the CPU.

I think that once a worker calls cond_resched(), it should be treated as
though it was run from a WQ_CPU_INTENSIVE queue, because only cpu-intensive
tasks need to call cond_resched().  This would allow other workers to be
scheduled.

The following patch achieves this I believe.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 include/linux/sched.h     |  7 ++++++-
 include/linux/workqueue.h |  2 ++
 kernel/sched/core.c       |  4 ++++
 kernel/workqueue.c        | 16 +++++++++++++++-
 mm/page_alloc.c           | 12 +-----------
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..728870965df1 100644
=2D-- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1784,7 +1784,12 @@ static inline int test_tsk_need_resched(struct task_=
struct *tsk)
 #ifndef CONFIG_PREEMPTION
 extern int _cond_resched(void);
 #else
=2Dstatic inline int _cond_resched(void) { return 0; }
+static inline int _cond_resched(void)
+{
+	if (current->flags & PF_WQ_WORKER)
+		workqueue_cond_resched();
+	return 0;
+}
 #endif
=20
 #define cond_resched() ({			\
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 8b505d22fc0e..7bcc5717d80f 100644
=2D-- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -626,6 +626,8 @@ static inline bool schedule_delayed_work(struct delayed=
_work *dwork,
 	return queue_delayed_work(system_wq, dwork, delay);
 }
=20
+void workqueue_cond_resched(void);
+
 #ifndef CONFIG_SMP
 static inline long work_on_cpu(int cpu, long (*fn)(void *), void *arg)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..5b2e38567a0c 100644
=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5620,6 +5620,8 @@ SYSCALL_DEFINE0(sched_yield)
 #ifndef CONFIG_PREEMPTION
 int __sched _cond_resched(void)
 {
+	if (current->flags & PF_WQ_WORKER)
+		workqueue_cond_resched();
 	if (should_resched(0)) {
 		preempt_schedule_common();
 		return 1;
@@ -5643,6 +5645,8 @@ int __cond_resched_lock(spinlock_t *lock)
 	int resched =3D should_resched(PREEMPT_LOCK_OFFSET);
 	int ret =3D 0;
=20
+	if (current->flags & PF_WQ_WORKER)
+		workqueue_cond_resched();
 	lockdep_assert_held(lock);
=20
 	if (spin_needbreak(lock) || resched) {
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f271..fd2e9557b1a6 100644
=2D-- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2296,7 +2296,7 @@ __acquires(&pool->lock)
 	spin_lock_irq(&pool->lock);
=20
 	/* clear cpu intensive status */
=2D	if (unlikely(cpu_intensive))
+	if (unlikely(worker->flags & WORKER_CPU_INTENSIVE))
 		worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
=20
 	/* tag the worker for identification in schedule() */
@@ -5330,6 +5330,20 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpum=
ask)
 	return ret;
 }
=20
+void workqueue_cond_resched(void)
+{
+	struct worker *worker =3D current_wq_worker();
+
+	if (worker && !(worker->flags & WORKER_CPU_INTENSIVE)) {
+		struct worker_pool *pool =3D worker->pool;
+
+		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+		if (need_more_worker(pool))
+			wake_up_worker(pool);
+	}
+}
+EXPORT_SYMBOL(workqueue_cond_resched);
+
 #ifdef CONFIG_SYSFS
 /*
  * Workqueues with WQ_SYSFS flag set is visible to userland via
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 13cc653122b7..0d5720ecbfe7 100644
=2D-- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4420,17 +4420,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	}
=20
 out:
=2D	/*
=2D	 * Memory allocation/reclaim might be called from a WQ context and the
=2D	 * current implementation of the WQ concurrency control doesn't
=2D	 * recognize that a particular WQ is congested if the worker thread is
=2D	 * looping without ever sleeping. Therefore we have to do a short sleep
=2D	 * here rather than calling cond_resched().
=2D	 */
=2D	if (current->flags & PF_WQ_WORKER)
=2D		schedule_timeout_uninterruptible(1);
=2D	else
=2D		cond_resched();
+	cond_resched();
 	return ret;
 }
=20
=2D-=20
2.29.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+or4MOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbm8fw//QQj2OJJmdYIwlK74vrB/MWouaOnNA8fEj1u+
1K8XzrVpmFFUmZjldX6VKEbubPy6XfTu6+AMKrJakWes+8XNIs4XJRgNXx44ZVdx
B8KIrTr3ZoDsb4egwmlwy2LlbpqS5b5HBnDqkeOa6d4HeHXC+0w97/TgE0VRF6EI
waWyLVZq7booxf99KASi34nNGcidsVcVFmwV0HVTrgfiVpVP612mb/FliOo7/0it
ABs8LEq9dnlNiQhnsSergl0imrKBFY8K1cdxUe0ay4dlAas0X1ksVqDW9ozrLUrb
+7N7vpa3VMrPth9mxq3xPYwgJxznxm5j3fBvw5+sxI/zqjpyG5qOPAmnQ2SwpoMF
wvc6jLebAEfW0e5P/jv4EIbbRZfhI800kPONPw5NS9PAir3sMBCyAhiC/ks/py5J
/n1ij3EmdWN1dWSFX1oKhBrUnFlPJDnrsLgl3OG/xYmVKx1570LUSeIoy4yAdT8u
DMBy9CIdt9gefKSKo5ReeHiXHFOsU45ekwttsADUISU7HZa5r0E6qYTJtMgZZhUF
uUhJdD5rLUbe/n8BrG7KoesHbCsLZNTU1J5LED+bWvEgOvVHyk50Glp18yPAFoMI
gEVDzEc3Y7TFL2Zvz2BP/MUL5UVZRE+TvCJzZ8v9rjN30+HB7sdrsANsFU5YVk/P
CkdwRsY=
=ONf0
-----END PGP SIGNATURE-----
--=-=-=--
