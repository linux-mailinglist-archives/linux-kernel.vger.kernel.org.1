Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5634A26D59C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIQIGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIQICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:02:23 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D04C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:02:22 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q10so551155qvs.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fhygmezCkDaWyBWA3QO/ZeCUvayCLqKQ0BE+1Y7oI/w=;
        b=QWDNGnr1h1VKLgWmMmPx13C24ZzlcmhOknW9K4dgHPES20eYxbOBoI3ALyBL8BbwQw
         hGFbjLv5h5dBJEpEW+/cVueOO0LdoBr5vdIW4NQrRekOtC0YUUFeOKHSkxmx8sJEtfJP
         b/qQnCQ0I0gRqzbigd4J0riZCnLyjYEX9gaqdT28CL3EcbdPZ8iM1Q5/XDEuKSIlfIZ4
         +5aGlvOwHLxKxv8kZgZxR5MklgH0yQPo94fR4IRo03bhODmukUPIqtN2YGg45bRHfQkN
         rHNC4qjRtd97ZX5Jy23aPFasWBBf3aRGTYJ5EHdY43Y+t5oe9cOgqsnb0FT2BhyXLMqw
         FF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fhygmezCkDaWyBWA3QO/ZeCUvayCLqKQ0BE+1Y7oI/w=;
        b=G/s+ntnynkr/5v/pv//bThvT42hItohUmb8PGABokvAAQ30uhcEQ1g40Q58/aPMiKN
         UnkheIwNCjMOsAi9+ZMWJaecCDNNgFEgKlEl8ViNIhMOoYq7hik0PhjKh4LmooMwOqwW
         +cR4bjbTapjvB0CmXnXsMktOsRV0GyZOpimPh+K/kgm2f82YkeiWTlgkSOTt/ssIYJG9
         qxEqJQTQeus7j0C7tZ62ktKSuOMXgovLCojSdAWZG3w/Df0uW00AVnA9QlCMPskvpJWB
         ZhJYD8BmxJLFOYnfwGANms+ZkHFjrJMomwG5LeuEIv03WcwxAja+R8kniLhJof60ots+
         InGg==
X-Gm-Message-State: AOAM532AHtgmKmqlz9saNnZb6e+EQsVXJyvP6HqkfgmcUcAHfD7PgAKh
        chYLWJ9Y5kuJEeAIztrsoON+2iNDYeQ=
X-Google-Smtp-Source: ABdhPJzLynJY7K3Qhmq9nSaR+yUJFR/5AJs+xDiwwE4Lm0ePdsqWySuRbmbXNFzCY+vq24YBqecPQg==
X-Received: by 2002:a05:6214:a11:: with SMTP id dw17mr10565795qvb.62.1600329741836;
        Thu, 17 Sep 2020 01:02:21 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x59sm20996267qte.14.2020.09.17.01.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 01:02:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9F83D27C0054;
        Thu, 17 Sep 2020 04:02:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Sep 2020 04:02:19 -0400
X-ME-Sender: <xms:ChhjX_Y4QkuHNTlMVSvPZgDa_0u0gdXguVnNR0zqeGFy2r8mC6I5yw>
    <xme:ChhjX-ZgHamXLMvDvXPVj4FoKPgz2kx6YU66PaTUCWcztA0N3dVL5diC0r8WVRJzR
    4leedtUFnNHnQgf3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdefgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduuddurd
    ejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvg
X-ME-Proxy: <xmx:ChhjXx8--SWC1x-7xAtmETYfhYhD2nNXTF5CcoCbOQUWVoKvT6XwRw>
    <xmx:ChhjX1q5ZoRRcl9uqAwvz5HpJw3bRkar_vdyQLu7WK47JUj4NTjDVA>
    <xmx:ChhjX6qLf9Ea7DzD3gmrXgQgNqcQs4dPrHz1FNiQo3CvTYRWPHkb3Q>
    <xmx:CxhjXzmD-P0m-9FYYECxyvhQOrcc-bcxIZqdV8QNSbWV_4xOu6EN8A>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id C22033064685;
        Thu, 17 Sep 2020 04:02:17 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] lockdep: Optimize the memory usage of circular queue
Date:   Thu, 17 Sep 2020 16:01:50 +0800
Message-Id: <20200917080210.108095-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 108 ++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 41 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cccf4bc759c6..761c2327e9cf 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1640,35 +1640,22 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 			     int offset)
 {
 	struct lock_list *entry;
-	struct lock_list *lock;
+	struct lock_list *lock = NULL;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
-	enum bfs_result ret = BFS_RNOMATCH;
 
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
+	while (lock || (lock = __cq_dequeue(cq))) {
+		if (!lock->class)
+			return BFS_EINVALIDNODE;
 
 		/*
+		 * Step 1: check whether we already finish on this one.
+		 *
 		 * If we have visited all the dependencies from this @lock to
 		 * others (iow, if we have visited all lock_list entries in
 		 * @lock->class->locks_{after,before}) we skip, otherwise go
@@ -1676,17 +1663,17 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 		 * list accessed.
 		 */
 		if (lock_accessed(lock))
-			continue;
+			goto next;
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
@@ -1698,29 +1685,68 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 
 			/* If nothing left, we skip */
 			if (!dep)
-				continue;
+				goto next;
 
 			/* If there are only -(*R)-> left, set that for the next step */
-			entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
+			lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
+		}
 
-			visit_lock_entry(entry, lock);
-			if (match(entry, data)) {
-				*target_entry = entry;
-				ret = BFS_RMATCH;
-				goto exit;
-			}
+		/*
+		 * Step 3: we haven't visited this and there is a strong
+		 *         dependency path to this, so check with @match.
+		 */
+		if (match(lock, data)) {
+			*target_entry = lock;
+			return BFS_RMATCH;
+		}
+
+		/*
+		 * Step 4: if not match, expand the path by adding the
+		 *         afterwards or backwards dependencis in the search
+		 *
+		 * Note we only enqueue the first of the list into the queue,
+		 * because we can always find a sibling dependency from one
+		 * (see label 'next'), as a result the space of queue is saved.
+		 */
+		head = get_dep_list(lock, offset);
+		entry = list_first_or_null_rcu(head, struct lock_list, entry);
+		if (entry) {
+			unsigned int cq_depth;
+
+			if (__cq_enqueue(cq, entry))
+				return BFS_EQUEUEFULL;
 
-			if (__cq_enqueue(cq, entry)) {
-				ret = BFS_EQUEUEFULL;
-				goto exit;
-			}
 			cq_depth = __cq_get_elem_count(cq);
 			if (max_bfs_queue_depth < cq_depth)
 				max_bfs_queue_depth = cq_depth;
 		}
+
+		/*
+		 * Update the ->parent, so when @entry is iterated, we know the
+		 * previous dependency.
+		 */
+		list_for_each_entry_rcu(entry, head, entry)
+			visit_lock_entry(entry, lock);
+next:
+		/*
+		 * Step 5: fetch the next dependency to process.
+		 *
+		 * If there is a previous dependency, we fetch the sibling
+		 * dependency in the dep list of previous dependency.
+		 *
+		 * Otherwise set @lock to NULL to fetch the next entry from
+		 * queue.
+		 */
+		if (lock->parent) {
+			head = get_dep_list(lock->parent, offset);
+			lock = list_next_or_null_rcu(head, &lock->entry,
+						     struct lock_list, entry);
+		} else {
+			lock = NULL;
+		}
 	}
-exit:
-	return ret;
+
+	return BFS_RNOMATCH;
 }
 
 static inline enum bfs_result
-- 
2.28.0

