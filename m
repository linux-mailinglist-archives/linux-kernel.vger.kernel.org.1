Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CBC26C6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgIPSBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgIPR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:58:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE1C02C2B8;
        Wed, 16 Sep 2020 09:14:11 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so6512322qtv.12;
        Wed, 16 Sep 2020 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fzjtftlrTKRq7aC/WWwbyeHwkfTDBPCU/tdp1Di46pA=;
        b=BGNra73NBJ4PyZVCuRSv6E1fQYW7YEeenmPYvrWRSjd+EwqrCq+xxPSku4bl4yCspm
         P86tv1neaQeRUi4v6EUdROwZdVBblPpR7l9EU4CJjXojbyl1bV8f0J9REQLoSzjsAS7V
         5Tw/TQGd2ywHCXhE1ZYoVaJPJUZvKf8gh9VeqNeWaPs6WiJksmYLR/JpG/6KpSKLz8d8
         LxpI+KChiM8hobKgeaPIrvCOz4+veRXadxyE/vrFwJnNsRJUjEqZzaCc8F8myT8dzbZ8
         o2rdlczUfhGrDtDKdQonDk/zdqKElM1abNSzFd3oW8MY7qMT51JCHKGWPJZ0S5z7DjRs
         nFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fzjtftlrTKRq7aC/WWwbyeHwkfTDBPCU/tdp1Di46pA=;
        b=U9kvR++w6cj43DCF36RIVoE16V3f25gl5JtepNWWKQ7OnAGl0yCHI/lriaawQR3P5z
         VTKLhDnq7vbjThfavuyjLyDm5ABOVgxoQwldrhj+hZ5PqCwIBEwzgSvp3NO8Wa4Ah/SM
         dMG5uMUWfSGc3vZoqb8ie4whZcqpD1BQGueHudpAOQjGyXeBf7pwezlYK9cBFaviLHTz
         mJe1JcpsJ9tzn/oKO/lF61vSZFfGi0OBYit7LWp7T3TQ12r4SnMEkvZKupQ7TAV/o3Qz
         Pu6rXsNDXru3T53ko9Psj8R7c9P7MrSGKVysYWqDUhvO9jDzzJJSV5bSYRzI9YaQYT0X
         0RlQ==
X-Gm-Message-State: AOAM533OG5pqTmyRL+Q6cJv5kA7VxDQxU/SLvPz1HFBrm4rZN+kiIXOp
        Klexy4q2x5yXOo4wQQkDYUM=
X-Google-Smtp-Source: ABdhPJztgdj5zE0ywUzUOGFRiYUm2BuLOAGnST1066D3PSzlm5ncVJH8+OI1pOduy+LucYAZEfoVZA==
X-Received: by 2002:ac8:4806:: with SMTP id g6mr11282607qtq.380.1600272850346;
        Wed, 16 Sep 2020 09:14:10 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l26sm3186238qki.62.2020.09.16.09.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 09:14:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A5EC227C0054;
        Wed, 16 Sep 2020 12:14:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 16 Sep 2020 12:14:07 -0400
X-ME-Sender: <xms:zjliX1otiyG2h33REAVoydlF0tDiLJyihUexeQvRyBfE-es-0flU6w>
    <xme:zjliX3pH73Vg_-1e7T-WUkcuIfoZTcZE67jrrVEblY0ts_Mnv4ea8AK3sni6fjV-3
    PvPql0MMS6KklHxRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddvgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:zjliXyNj8djwQCi5Xv_MI75uCcKLVuehoYWA8__AyOq_Xpk-KorcOw>
    <xmx:zjliXw4UAEEsUH-t9wiVNck7-t50_79Elx9Tq846midex_xcLKf7dQ>
    <xmx:zjliX07iOJzVWNKqpL3Cehn7a1ZVHz7hmGmu_7c0vTxBKTf1-PJHkw>
    <xmx:zzliXxud5pINnqmmn4UA96dcujNWpB8aWXhXRgmaHfz51HMkvIPNTw>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 095F63064682;
        Wed, 16 Sep 2020 12:14:05 -0400 (EDT)
Date:   Thu, 17 Sep 2020 00:14:04 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Qian Cai <cai@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC v7 11/19] lockdep: Fix recursive read lock related
 safe->unsafe detection
Message-ID: <20200916161404.GD127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
 <20200807074238.1632519-12-boqun.feng@gmail.com>
 <17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com>
 <20200916081046.GC127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916081046.GC127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 04:10:46PM +0800, Boqun Feng wrote:
> On Tue, Sep 15, 2020 at 02:32:51PM -0400, Qian Cai wrote:
> > On Fri, 2020-08-07 at 15:42 +0800, Boqun Feng wrote:
> > > Currently, in safe->unsafe detection, lockdep misses the fact that a
> > > LOCK_ENABLED_IRQ_*_READ usage and a LOCK_USED_IN_IRQ_*_READ usage may
> > > cause deadlock too, for example:
> > > 
> > > 	P1                          P2
> > > 	<irq disabled>
> > > 	write_lock(l1);             <irq enabled>
> > > 				    read_lock(l2);
> > > 	write_lock(l2);
> > > 				    <in irq>
> > > 				    read_lock(l1);
> > > 
> > > Actually, all of the following cases may cause deadlocks:
> > > 
> > > 	LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*
> > > 	LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*
> > > 	LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*_READ
> > > 	LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*_READ
> > > 
> > > To fix this, we need to 1) change the calculation of exclusive_mask() so
> > > that READ bits are not dropped and 2) always call usage() in
> > > mark_lock_irq() to check usage deadlocks, even when the new usage of the
> > > lock is READ.
> > > 
> > > Besides, adjust usage_match() and usage_acculumate() to recursive read
> > > lock changes.
> > > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > 
> > So our daily CI starts to trigger a warning (graph corruption?) below. From the
> > call traces, this recent patchset changed a few related things here and there.
> > Does it ring any bells?
> > 
> > [14828.805563][T145183] lockdep bfs error:-1
> 
> -1 is BFS_EQUEUEFULL, that means we hit the size limitation in lockdep
> searching, which is possible since recursive read deadlock detection
> tries to make the all edges (dependencies) searched. So maybe we should
> switch to DFS instead of BFS, I will look into this, in the meanwhile,
> could you try the following to see if it can help on the warnings you
> got?
> 

Found a way to resolve this while still keeping the BFS. Every time when
we want to enqueue a lock_list, we basically enqueue a whole dep list of
entries from the previous lock_list, so we can use a trick here: instead
enqueue all the entries, we only enqueue the first entry and we can
fetch other silbing entries with list_next_or_null_rcu(). Patch as
below, I also took the chance to clear the code up and add more
comments. I could see this number (in /proc/lockdep_stats):

	max bfs queue depth:                   201

down to (after apply this patch)

	max bfs queue depth:                   61

with x86_64_defconfig along with lockdep and selftest configs.

Qian, could you give it a try?

Regards,
Boqun

---------------------->8
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 454355c033d2..1cc1302bf319 100644
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

