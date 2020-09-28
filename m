Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74727A9F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgI1IvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1IvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:51:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3hr/baIV2Vgn58h+/4M3UNkA2hJQDc8KQMKG5Bx+L7g=; b=CqlvUnjbRNCqsfcuv2xLwhyy22
        U0WlZ+KEX/wWInAO7VZwbmCPCmLTAqZFYsaF0h9+xaOulovJasasgnNb2Ba7StD9XwHN7Ly15xSeT
        IopvAlYSmUAGCx4srePJw+CH/iBrqh2qi6HXLYkylBMOhA9b9sVF23fSiN0KNKt5gKvP3HiJdTmJd
        jlOJ0BqEdNYJtvWeQt0rM8OLIHoSnoY+At5w83R9Lafy7/auZ/Ccc4YkjeK7SAuTe7mWzTXIApLtt
        MtuhvQm0lQa4CXHCdErjHBJAATyKzTqDjmu2n3ep0XoV9uHvbau1SHgx8cnIi6EoO9vaLc4aPvdgE
        4gZJ0aWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMosE-0007sV-AG; Mon, 28 Sep 2020 08:51:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11131304B90;
        Mon, 28 Sep 2020 10:51:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDBA120419041; Mon, 28 Sep 2020 10:51:04 +0200 (CEST)
Date:   Mon, 28 Sep 2020 10:51:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Qian Cai <cai@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lockdep: Optimize the memory usage of circular queue
Message-ID: <20200928085104.GE2611@hirez.programming.kicks-ass.net>
References: <20200917080210.108095-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917080210.108095-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:01:50PM +0800, Boqun Feng wrote:

>  	__cq_init(cq);
>  	__cq_enqueue(cq, source_entry);
>  
> +	while (lock || (lock = __cq_dequeue(cq))) {
> +		if (!lock->class)
> +			return BFS_EINVALIDNODE;
>  
>  		/*
> +		 * Step 1: check whether we already finish on this one.
> +		 *
>  		 * If we have visited all the dependencies from this @lock to
>  		 * others (iow, if we have visited all lock_list entries in
>  		 * @lock->class->locks_{after,before}) we skip, otherwise go

> @@ -1698,29 +1685,68 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
>  
>  			/* If nothing left, we skip */
>  			if (!dep)
> +				goto next;
>  
>  			/* If there are only -(*R)-> left, set that for the next step */
> +			lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> +		}
>  
> +		/*
> +		 * Step 3: we haven't visited this and there is a strong
> +		 *         dependency path to this, so check with @match.
> +		 */
> +		if (match(lock, data)) {
> +			*target_entry = lock;
> +			return BFS_RMATCH;
> +		}
> +
> +		/*
> +		 * Step 4: if not match, expand the path by adding the
> +		 *         afterwards or backwards dependencis in the search
> +		 *
> +		 * Note we only enqueue the first of the list into the queue,
> +		 * because we can always find a sibling dependency from one
> +		 * (see label 'next'), as a result the space of queue is saved.
> +		 */
> +		head = get_dep_list(lock, offset);
> +		entry = list_first_or_null_rcu(head, struct lock_list, entry);
> +		if (entry) {
> +			unsigned int cq_depth;
> +
> +			if (__cq_enqueue(cq, entry))
> +				return BFS_EQUEUEFULL;
>  
>  			cq_depth = __cq_get_elem_count(cq);
>  			if (max_bfs_queue_depth < cq_depth)
>  				max_bfs_queue_depth = cq_depth;
>  		}
> +
> +		/*
> +		 * Update the ->parent, so when @entry is iterated, we know the
> +		 * previous dependency.
> +		 */
> +		list_for_each_entry_rcu(entry, head, entry)
> +			visit_lock_entry(entry, lock);

This confused me for a while. I think it might be a little clearer if we
put this inside the previous block.

Alternatively, we could try and write it something like so:

		/*
		 * Step 4: if not match, expand the path by adding the
		 *         afterwards or backwards dependencis in the search
		 */
		first = true;
		head = get_dep_list(lock, offset);
		list_for_each_entry_rcu(entry, head, entry) {
			visit_lock_entry(entry, lock);

			if (!first)
				continue;

			/*
			 * Only enqueue the first entry of the list,
			 * we'll iterate it's siblings at the next
			 * label.
			 */
			first = false;
			if (__cq_enqueue(cq, entry))
				return BFS_EQUEUEFULL;

			cq_depth = __cq_get_elem_count(cq);
			if (max_bfs_queue_depth < cq_depth)
				max_bfs_queue_depth = cq_depth;
		}

Hmm?

> +next:
> +		/*
> +		 * Step 5: fetch the next dependency to process.
> +		 *
> +		 * If there is a previous dependency, we fetch the sibling
> +		 * dependency in the dep list of previous dependency.
> +		 *
> +		 * Otherwise set @lock to NULL to fetch the next entry from
> +		 * queue.
> +		 */
> +		if (lock->parent) {
> +			head = get_dep_list(lock->parent, offset);
> +			lock = list_next_or_null_rcu(head, &lock->entry,
> +						     struct lock_list, entry);
> +		} else {
> +			lock = NULL;
> +		}

I think that if we hide this in a __bfs_next() helper, the iteration
becomes nicer.

>  	}
> -exit:
> +
> +	return BFS_RNOMATCH;
>  }

How's this?

---
Subject: lockdep: Optimize the memory usage of circular queue
From: Boqun Feng <boqun.feng@gmail.com>
Date: Thu, 17 Sep 2020 16:01:50 +0800

From: Boqun Feng <boqun.feng@gmail.com>

Qian Cai reported a BFS_EQUEUEFULL warning [1] after read recursive
deadlock detection merged into tip tree recently. Unlike the previous
lockep graph searching, which iterate every lock class (every node in
the graph) exactly once, the graph searching for read recurisve deadlock
detection needs to iterate every lock dependency (every edge in the
graph) once, as a result, the maximum memory cost of the circular queue
changes from O(V), where V is the number of lock classes (nodes or
vertices) in the graph, to O(E), where E is the number of lock
dependencies (edges), because every lock class or dependency gets
enqueued once in the BFS. Therefore we hit the BFS_EQUEUEFULL case.

However, actually we don't need to enqueue all dependencies for the BFS,
because every time we enqueue a dependency, we almostly enqueue all
other dependencies in the same dependency list ("almostly" is because
we currently check before enqueue, so if a dependency doesn't pass the
check stage we won't enqueue it, however, we can always do in reverse
ordering), based on this, we can only enqueue the first dependency from
a dependency list and every time we want to fetch a new dependency to
work, we can either:

  1)	fetch the dependency next to the current dependency in the
	dependency list
or

  2)	if the dependency in 1) doesn't exist, fetch the dependency from
	the queue.

With this approach, the "max bfs queue depth" for a x86_64_defconfig +
lockdep and selftest config kernel can get descreased from:

        max bfs queue depth:                   201

to (after apply this patch)

        max bfs queue depth:                   61

While I'm at it, clean up the code logic a little (e.g. directly return
other than set a "ret" value and goto the "exit" label).

[1]: https://lore.kernel.org/lkml/17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com/

Reported-by: Qian Cai <cai@redhat.com>
Reported-by: syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200917080210.108095-1-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c |  101 ++++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 40 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1606,6 +1606,15 @@ static inline void bfs_init_rootb(struct
 	lock->only_xr = (hlock->read != 0);
 }
 
+static inline struct lock_list *__bfs_next(struct lock_list *lock, int offset)
+{
+	if (!lock || !lock->parent)
+		return NULL;
+
+	return list_next_or_null_rcu(get_dep_list(lock->parent, offset),
+				     &lock->entry, struct lock_list, entry);
+}
+
 /*
  * Breadth-First Search to find a strong path in the dependency graph.
  *
@@ -1639,36 +1648,25 @@ static enum bfs_result __bfs(struct lock
 			     struct lock_list **target_entry,
 			     int offset)
 {
+	struct circular_queue *cq = &lock_cq;
+	struct lock_list *lock = NULL;
 	struct lock_list *entry;
-	struct lock_list *lock;
 	struct list_head *head;
-	struct circular_queue *cq = &lock_cq;
-	enum bfs_result ret = BFS_RNOMATCH;
+	unsigned int cq_depth;
+	bool first;
 
 	lockdep_assert_locked();
 
-	if (match(source_entry, data)) {
-		*target_entry = source_entry;
-		ret = BFS_RMATCH;
-		goto exit;
-	}
-
-	head = get_dep_list(source_entry, offset);
-	if (list_empty(head))
-		goto exit;
-
 	__cq_init(cq);
 	__cq_enqueue(cq, source_entry);
 
-	while ((lock = __cq_dequeue(cq))) {
-		bool prev_only_xr;
-
-		if (!lock->class) {
-			ret = BFS_EINVALIDNODE;
-			goto exit;
-		}
+	while ((lock = __bfs_next(lock, offset)) || (lock = __cq_dequeue(cq))) {
+		if (!lock->class)
+			return BFS_EINVALIDNODE;
 
 		/*
+		 * Step 1: check whether we already finish on this one.
+		 *
 		 * If we have visited all the dependencies from this @lock to
 		 * others (iow, if we have visited all lock_list entries in
 		 * @lock->class->locks_{after,before}) we skip, otherwise go
@@ -1680,13 +1678,13 @@ static enum bfs_result __bfs(struct lock
 		else
 			mark_lock_accessed(lock);
 
-		head = get_dep_list(lock, offset);
-
-		prev_only_xr = lock->only_xr;
-
-		list_for_each_entry_rcu(entry, head, entry) {
-			unsigned int cq_depth;
-			u8 dep = entry->dep;
+		/*
+		 * Step 2: check whether prev dependency and this form a strong
+		 *         dependency path.
+		 */
+		if (lock->parent) { /* Parent exists, check prev dependency */
+			u8 dep = lock->dep;
+			bool prev_only_xr = lock->parent->only_xr;
 
 			/*
 			 * Mask out all -(S*)-> if we only have *R in previous
@@ -1701,26 +1699,49 @@ static enum bfs_result __bfs(struct lock
 				continue;
 
 			/* If there are only -(*R)-> left, set that for the next step */
-			entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
+			lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
+		}
+
+		/*
+		 * Step 3: we haven't visited this and there is a strong
+		 *         dependency path to this, so check with @match.
+		 */
+		if (match(lock, data)) {
+			*target_entry = lock;
+			return BFS_RMATCH;
+		}
 
+		/*
+		 * Step 4: if not match, expand the path by adding the
+		 *         afterwards or backwards dependencis in the search
+		 *
+		 */
+		first = true;
+		head = get_dep_list(lock, offset);
+		list_for_each_entry_rcu(entry, head, entry) {
 			visit_lock_entry(entry, lock);
-			if (match(entry, data)) {
-				*target_entry = entry;
-				ret = BFS_RMATCH;
-				goto exit;
-			}
-
-			if (__cq_enqueue(cq, entry)) {
-				ret = BFS_EQUEUEFULL;
-				goto exit;
-			}
+
+			/*
+			 * Note we only enqueue the first of the list into the
+			 * queue, because we can always find a sibling
+			 * dependency from one (see _bfs_next()), as a result
+			 * the space of queue is saved.
+			 */
+			if (!first)
+				continue;
+
+			first = false;
+
+			if (__cq_enqueue(cq, entry))
+				return BFS_EQUEUEFULL;
+
 			cq_depth = __cq_get_elem_count(cq);
 			if (max_bfs_queue_depth < cq_depth)
 				max_bfs_queue_depth = cq_depth;
 		}
 	}
-exit:
-	return ret;
+
+	return BFS_RNOMATCH;
 }
 
 static inline enum bfs_result
