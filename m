Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546762B7157
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgKQWQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:16:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:43608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQWQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:16:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04B56ABD1;
        Tue, 17 Nov 2020 22:16:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "tj@kernel.org" <tj@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Wed, 18 Nov 2020 09:16:09 +1100
Cc:     "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
In-Reply-To: <20201109161007.GF7496@mtj.duckdns.org>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
 <20201109161007.GF7496@mtj.duckdns.org>
Message-ID: <87o8jvocie.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09 2020, tj@kernel.org wrote:

> Hello,
>
> On Mon, Nov 09, 2020 at 02:11:42PM +0000, Trond Myklebust wrote:
>> That means changing all filesystem code to use cpu-intensive queues. As
>> far as I can tell, they all use workqueues (most of them using the
>> standard system queue) for fput(), dput() and/or iput() calls.
>
> I suppose the assumption was that those operations couldn't possiby be
> expensive enough to warrant other options, which doesn't seem to be the c=
ase
> unfortunately. Switching the users to system_unbound_wq, which should be
> pretty trivial, seems to be the straight forward solution.
>
> I can definitely see benefits in making workqueue smarter about
> concurrency-managed work items taking a long time. Given that nothing on
> these types of workqueues can be latency sensitive and the problem being
> reported is on the scale of tens of seconds, I think a more palatable
> approach could be through watchdog mechanism rather than hooking into
> cond_resched(). Something like:
>
> * Run watchdog timer more frequently - e.g. 1/4 of threshold.
>
> * If a work item is occupying the local concurrency for too long, set
>   WORKER_CPU_INTENSIVE for the worker and, probably, generate a warning.
>
> I still think this should generate a warning and thus can't replace
> switching to unbound wq. The reason is that the concurrency limit isn't t=
he
> only problem. A kthread needing to run on one particular CPU for tens of
> seconds just isn't great.

I don't think that using a timer to trigger a warning is sufficient.
As justification I point to "might_sleep()".  This doesn't wait for
atomic code to *actually* sleep, but produces a warning when atomic code
calls other code that *might* sleep.  This means we catch problems
during development rather that when in production.

For the same reasons, I think we need a warning when a CM-worker calls
code that *might* consume a lot of CPU, only one when it actually *does*
consume a lot of CPU.
So I think that a warning from cond_resched() is the right thing to do.
The patch below does this - it borrows CONFIG_WQ_WATCHDOG to desire whether
to check for the warning.

So I don't think that moving to workitems to system_unbound_wq is always
appropriate.  Sometimes it certain is, as in patch below.  However in
some cases it is not at all clear at the time the workitem is submitted,
how much work will be down.
nfs has a work queue (nfsiod) which handle the reply to an async RPC.
In some cases there is a tiny amount of work to be done.  In rare cases
there is a lot.  Rather than trying to deduce in advance, it is much
easier if the worker can switch mode only when it finds that there is a
lot of work to do.
The patch below supports this with workqueue_prepare_use_cpu() which
switches to CPU_INTENSIVE mode.  It doesn't unbind from the current
CPU.  Maybe it should but I suspect that wouldn't be as easy to code,
and I'm not at all sure of the benefit.

So: I propose the patch below.  Thoughts?

Thanks,
NeilBrown



From: NeilBrown <neilb@suse.de>
Date: Mon, 9 Nov 2020 13:37:17 +1100
Subject: [PATCH] workqueue: warn when cond_resched called from
 concurrency-managed worker

Several workers in concurrency-managed work queues call cond_resched().
This suggest that they might consume a lot of CPU time and are willing
to allow other code to run concurrently.
This *does* allow non-workqueue code to run but does *not* allow other
concurrency-managed work items to run on the same CPU.

In general such workers should not be run from a concurrency-managed
workqueue however:
 1/ there is no mechanism to alert coders to the fact that they are
    using the wrong work queue, and
 2/ sometimes it is not clear, when a work item is created, whether it
    will end up in code that might consume at lot of CPU time.  So
    choosing the best workqueue it not always easy.

This patch addresses both these issues:
 1/ If a concurrency-managed worker calls cond_resched() a warning
    (WARN_ON_ONCE) is generated (if CONFIG_WQ_WATCHDOG is selected).
 2/ A new interface - workqueue_prepare_use_cpu() - is provided which
    may be called by low-level code which might be called in a workqueue
    and might consume CPU.  This switches the worker to CPU_INTENSIVE
    mode so that other work items can run on the same CPU.
    This means there is no need to chose the required behaviour when
    submitting a work item, as the code can switch behaviour when needed.

This patch also changes some code to avoid the warning:
 - in some cases, system_unbound_wq is used instead of system_wq,
   when the work item will normally call cond_resched()
 - in other cases, calls to workqueue_prepare_use_cpu() are inserted.

 - in slab.c, a cond_resched() call is replaced by
     if (tif_need_resched())
            break;
   so that the worker will relinquish CPU and try again later.

There are doubtless more changes needed, but these allow me to boot and
access NFS files without warnings.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/dcache.c                |  2 ++
 fs/nfs/delegation.c        |  5 +++++
 fs/nfs/write.c             |  6 ++++++
 include/linux/rhashtable.h |  4 ++--
 include/linux/sched.h      |  2 ++
 include/linux/workqueue.h  | 30 ++++++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  2 +-
 kernel/workqueue.c         | 33 +++++++++++++++++++++++++++++++--
 lib/rhashtable.c           |  8 ++++----
 mm/page_alloc.c            | 14 ++++----------
 mm/slab.c                  |  3 ++-
 mm/truncate.c              |  3 +++
 net/sunrpc/clnt.c          |  2 +-
 security/keys/gc.c         |  8 ++++----
 security/keys/key.c        |  2 +-
 15 files changed, 98 insertions(+), 26 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..46c83f712ad3 100644
=2D-- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -686,6 +686,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	struct inode *inode =3D dentry->d_inode;
 	struct dentry *parent =3D NULL;
=20
+	workqueue_prepare_use_cpu();
+
 	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
 		goto slow_positive;
=20
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 816e1427f17e..cbf4e586ee2c 100644
=2D-- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -573,6 +573,7 @@ static int nfs_server_return_marked_delegations(struct =
nfs_server *server,
 	struct nfs_delegation *place_holder_deleg =3D NULL;
 	int err =3D 0;
=20
+	workqueue_prepare_use_cpu();
 restart:
 	/*
 	 * To avoid quadratic looping we hold a reference
@@ -1097,6 +1098,8 @@ static int nfs_server_reap_unclaimed_delegations(stru=
ct nfs_server *server,
 {
 	struct nfs_delegation *delegation;
 	struct inode *inode;
+
+	workqueue_prepare_use_cpu();
 restart:
 	rcu_read_lock();
 restart_locked:
@@ -1229,6 +1232,8 @@ static int nfs_server_reap_expired_delegations(struct=
 nfs_server *server,
 	struct inode *inode;
 	const struct cred *cred;
 	nfs4_stateid stateid;
+
+	workqueue_prepare_use_cpu();
 restart:
 	rcu_read_lock();
 restart_locked:
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 639c34fec04a..e84df784acc6 100644
=2D-- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1034,6 +1034,8 @@ nfs_scan_commit_list(struct list_head *src, struct li=
st_head *dst,
 	struct nfs_page *req, *tmp;
 	int ret =3D 0;
=20
+	workqueue_prepare_use_cpu();
+
 restart:
 	list_for_each_entry_safe(req, tmp, src, wb_list) {
 		kref_get(&req->wb_kref);
@@ -1839,6 +1841,8 @@ static void nfs_commit_release_pages(struct nfs_commi=
t_data *data)
 	struct nfs_commit_info cinfo;
 	struct nfs_server *nfss;
=20
+	workqueue_prepare_use_cpu();
+
 	while (!list_empty(&data->pages)) {
 		req =3D nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
@@ -1924,6 +1928,8 @@ static int __nfs_commit_inode(struct inode *inode, in=
t how,
 	int may_wait =3D how & FLUSH_SYNC;
 	int ret, nscan;
=20
+	workqueue_prepare_use_cpu();
+
 	nfs_init_cinfo_from_inode(&cinfo, inode);
 	nfs_commit_begin(cinfo.mds);
 	for (;;) {
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 68dab3e08aad..01ab43d4b9bb 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -788,7 +788,7 @@ static inline void *__rhashtable_insert_fast(
 	rht_assign_unlock(tbl, bkt, obj);
=20
 	if (rht_grow_above_75(ht, tbl))
=2D		schedule_work(&ht->run_work);
+		queue_work(system_unbound_wq, &ht->run_work);
=20
 	data =3D NULL;
 out:
@@ -1056,7 +1056,7 @@ static inline int __rhashtable_remove_fast_one(
 		atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
 			     rht_shrink_below_30(ht, tbl)))
=2D			schedule_work(&ht->run_work);
+			queue_work(system_unbound_wq, &ht->run_work);
 		err =3D 0;
 	}
=20
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..3a3f1d9c0bb9 100644
=2D-- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1837,6 +1837,7 @@ static inline int _cond_resched(void) { return 0; }
=20
 #define cond_resched() ({			\
 	___might_sleep(__FILE__, __LINE__, 0);	\
+	WARN_ON_ONCE(workqueue_mustnt_use_cpu());	\
 	_cond_resched();			\
 })
=20
@@ -1844,6 +1845,7 @@ extern int __cond_resched_lock(spinlock_t *lock);
=20
 #define cond_resched_lock(lock) ({				\
 	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
+	WARN_ON_ONCE(workqueue_mustnt_use_cpu());			\
 	__cond_resched_lock(lock);				\
 })
=20
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 26de0cae2a0a..6c6473ee02e1 100644
=2D-- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -626,6 +626,36 @@ static inline bool schedule_delayed_work(struct delaye=
d_work *dwork,
 	return queue_delayed_work(system_wq, dwork, delay);
 }
=20
+
+/* Following are #define rather than 'static inline' because
+ * workqueue.h (this file) is included by sched.h, so it cannot
+ * use types and macros defined in that file.
+ *
+ * If workqueue_mustnt_use_cpu() returns false and triggers a warning,
+ * it means that a worker in a concurrency-managed workqueue is calling
+ * cond_resched().  This does NOT allow other workers to run, so it can
+ * block them unduly.  Such workers should either be run on some other
+ * workqueue, such as system_unbound_wq, or must call
+ * workqueue_prepare_use_cpu() so that the worker drops out of
+ * concurrency management.
+ */
+
+#define current_is_wq_worker() (current->flags & PF_WQ_WORKER)
+#ifdef CONFIG_WQ_WATCHDOG
+bool __workqueue_may_use_cpu(void);
+#define workqueue_mustnt_use_cpu()	\
+	(current_is_wq_worker() && !__workqueue_may_use_cpu())
+#else
+#define workqueue_mustnt_use_cpu() false
+#endif
+
+void __workqueue_prepare_use_cpu(void);
+#define workqueue_prepare_use_cpu()			\
+	do {						\
+		if (current_is_wq_worker())		\
+			__workqueue_prepare_use_cpu();	\
+	} while(0)
+
 #ifndef CONFIG_SMP
 static inline long work_on_cpu(int cpu, long (*fn)(void *), void *arg)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef85d69..907707481d36 100644
=2D-- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3302,7 +3302,7 @@ static inline bool queue_kfree_rcu_work(struct kfree_=
rcu_cpu *krcp)
 			 * channels have been detached following by each
 			 * other.
 			 */
=2D			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
 		}
=20
 		// Repeat if any "free" corresponding channel is still busy.
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ab593b20fb94..3f5ee4468493 100644
=2D-- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2295,12 +2295,12 @@ __acquires(&pool->lock)
 	 * stop_machine. At the same time, report a quiescent RCU state so
 	 * the same condition doesn't freeze RCU.
 	 */
=2D	cond_resched();
+	_cond_resched();
=20
 	raw_spin_lock_irq(&pool->lock);
=20
 	/* clear cpu intensive status */
=2D	if (unlikely(cpu_intensive))
+	if (unlikely(worker->flags & WORKER_CPU_INTENSIVE))
 		worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
=20
 	/* tag the worker for identification in schedule() */
@@ -5345,6 +5345,35 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpum=
ask)
 	return ret;
 }
=20
+#ifdef CONFIG_WQ_WATCHDOG
+bool __workqueue_may_use_cpu(void)
+{
+	struct worker *worker =3D current_wq_worker();
+	if (!worker)
+		return true;
+	/* If any flag in WORKER_NOT_RUNNING is set, the worker is not
+	 * counted for concurrency control, so it can use as much CPU
+	 * as it likes.
+	 */
+	return worker->flags & WORKER_NOT_RUNNING;
+}
+EXPORT_SYMBOL(__workqueue_may_use_cpu);
+#endif
+
+void __workqueue_prepare_use_cpu(void)
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
+EXPORT_SYMBOL(__workqueue_prepare_use_cpu);
+
 #ifdef CONFIG_SYSFS
 /*
  * Workqueues with WQ_SYSFS flag set is visible to userland via
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c949c1e3b87c..1ef41411cda7 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -433,7 +433,7 @@ static void rht_deferred_worker(struct work_struct *wor=
k)
 	mutex_unlock(&ht->mutex);
=20
 	if (err)
=2D		schedule_work(&ht->run_work);
+		queue_work(system_unbound_wq, &ht->run_work);
 }
=20
 static int rhashtable_insert_rehash(struct rhashtable *ht,
@@ -468,7 +468,7 @@ static int rhashtable_insert_rehash(struct rhashtable *=
ht,
 		if (err =3D=3D -EEXIST)
 			err =3D 0;
 	} else
=2D		schedule_work(&ht->run_work);
+		queue_work(system_unbound_wq, &ht->run_work);
=20
 	return err;
=20
@@ -479,7 +479,7 @@ static int rhashtable_insert_rehash(struct rhashtable *=
ht,
=20
 	/* Schedule async rehash to retry allocation in process context. */
 	if (err =3D=3D -ENOMEM)
=2D		schedule_work(&ht->run_work);
+		queue_work(system_unbound_wq, &ht->run_work);
=20
 	return err;
 }
@@ -579,7 +579,7 @@ static struct bucket_table *rhashtable_insert_one(
=20
 	atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))
=2D		schedule_work(&ht->run_work);
+		queue_work(system_unbound_wq, &ht->run_work);
=20
 	return NULL;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..69770135e8eb 100644
=2D-- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4557,17 +4557,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	}
=20
 out:
=2D	/*
=2D	 * Memory allocation/reclaim might be called from a WQ context and the
=2D	 * current implementation of the WQ concurrency control doesn't
=2D	 * recognize that a particular WQ is congested if the worker thread is
=2D	 * looping without ever sleeping. Therefore we have to do a short sleep
=2D	 * here rather than calling cond_resched().
+	/* This might take a while - allow workqueue to schedule other
+	 * work in parallel.
 	 */
=2D	if (current->flags & PF_WQ_WORKER)
=2D		schedule_timeout_uninterruptible(1);
=2D	else
=2D		cond_resched();
+	workqueue_prepare_use_cpu();
+	cond_resched();
 	return ret;
 }
=20
diff --git a/mm/slab.c b/mm/slab.c
index b1113561b98b..2e50603e1b26 100644
=2D-- a/mm/slab.c
+++ b/mm/slab.c
@@ -3994,7 +3994,8 @@ static void cache_reap(struct work_struct *w)
 			STATS_ADD_REAPED(searchp, freed);
 		}
 next:
=2D		cond_resched();
+		if (tif_need_resched())
+			break;
 	}
 	check_irq_on();
 	mutex_unlock(&slab_mutex);
diff --git a/mm/truncate.c b/mm/truncate.c
index 18cec39a9f53..b333130a7629 100644
=2D-- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -324,6 +324,7 @@ void truncate_inode_pages_range(struct address_space *m=
apping,
 	else
 		end =3D (lend + 1) >> PAGE_SHIFT;
=20
+	workqueue_prepare_use_cpu();
 	pagevec_init(&pvec);
 	index =3D start;
 	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
@@ -538,6 +539,7 @@ unsigned long __invalidate_mapping_pages(struct address=
_space *mapping,
 	unsigned long count =3D 0;
 	int i;
=20
+	workqueue_prepare_use_cpu();
 	pagevec_init(&pvec);
 	while (index <=3D end && pagevec_lookup_entries(&pvec, mapping, index,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
@@ -717,6 +719,7 @@ int invalidate_inode_pages2_range(struct address_space =
*mapping,
 	if (mapping->nrpages =3D=3D 0 && mapping->nrexceptional =3D=3D 0)
 		goto out;
=20
+	workqueue_prepare_use_cpu();
 	pagevec_init(&pvec);
 	index =3D start;
 	while (index <=3D end && pagevec_lookup_entries(&pvec, mapping, index,
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 62e0b6c1e8cf..1ce66672481f 100644
=2D-- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -906,7 +906,7 @@ rpc_free_client(struct rpc_clnt *clnt)
 	put_cred(clnt->cl_cred);
=20
 	INIT_WORK(&clnt->cl_work, rpc_free_client_work);
=2D	schedule_work(&clnt->cl_work);
+	queue_work(system_unbound_wq, &clnt->cl_work);
 	return parent;
 }
=20
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 3c90807476eb..a4ad04b78833 100644
=2D-- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -57,7 +57,7 @@ void key_schedule_gc(time64_t gc_at)
=20
 	if (gc_at <=3D now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
 		kdebug("IMMEDIATE");
=2D		schedule_work(&key_gc_work);
+		queue_work(system_unbound_wq, &key_gc_work);
 	} else if (gc_at < key_gc_next_run) {
 		kdebug("DEFERRED");
 		key_gc_next_run =3D gc_at;
@@ -72,7 +72,7 @@ void key_schedule_gc(time64_t gc_at)
 void key_schedule_gc_links(void)
 {
 	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
=2D	schedule_work(&key_gc_work);
+	queue_work(system_unbound_wq, &key_gc_work);
 }
=20
 /*
@@ -106,7 +106,7 @@ void key_gc_keytype(struct key_type *ktype)
 	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
=20
 	kdebug("schedule");
=2D	schedule_work(&key_gc_work);
+	queue_work(system_unbound_wq, &key_gc_work);
=20
 	kdebug("sleep");
 	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
@@ -319,7 +319,7 @@ static void key_garbage_collector(struct work_struct *w=
ork)
 	}
=20
 	if (gc_state & KEY_GC_REAP_AGAIN)
=2D		schedule_work(&key_gc_work);
+		queue_work(system_unbound_wq, &key_gc_work);
 	kleave(" [end %x]", gc_state);
 	return;
=20
diff --git a/security/keys/key.c b/security/keys/key.c
index e282c6179b21..f990e226d74a 100644
=2D-- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -647,7 +647,7 @@ void key_put(struct key *key)
 		key_check(key);
=20
 		if (refcount_dec_and_test(&key->usage))
=2D			schedule_work(&key_gc_work);
+			queue_work(system_unbound_wq, &key_gc_work);
 	}
 }
 EXPORT_SYMBOL(key_put);
=2D-=20
2.29.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+0S6kOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbl69hAAi8bKozrYYTt7ZdtmhEh6MPTmpsbsUeuPRm+C
ygDaYSa1NVx9cc2eVE5GslLzu/NUfn4mR/oR69mIxph0+uq27uiB4MaxucRvuCPI
TdWvhd0KSNGQ6KXUoKe/yr28k4idWDN5/nG/opW8LqBmkocM0nuvLSYb3Epvlo90
zwV4KZ1DlV3BSGrl5YM9/IIVEx7GJVfJzEIVxL9QI3w+BDpnmTf1ssTKbIU3YB3F
zxRtI9Nz1irtfs0gc+j84IjNf08bgweAMx8aoI/RYxY7v1yZNzEzTbE3zmNSDVtB
L7v/cNZFi/WV78HEl2jv6ENPywanggD3A+QgQaw93lQ3nt2afUro0q7jd/8pT/qG
4Yl4jUcrj0NPhBvPcxSgOVAOvFHKiZVP8qtyvLhct/iHLKkJwARtoEqLsbYbiqkM
5t1hGZB+6D/HmM/gS9dxsyxIfbP8V71wQwicsyVDJyW+wz1l25hB3hasupYuJakg
mUvl8ZXpybbyxGvRbWZpMUzdDCQveIKDU6poiWB7Ga8dc6grIOhPmLi4Fyn9oTLG
m6UEGBGR2r1iZ3LpcPAQtZ9Efls23HQjSTObAsFrfw1JQJCGwmT0tHLQvbBlZvGk
PR2rmGed35kGsfiBgeQcUWVrF6SLAVBgRbSOHpUXao81MMiLzllI+sRPANdaW8VH
kO61cOQ=
=WZZe
-----END PGP SIGNATURE-----
--=-=-=--
