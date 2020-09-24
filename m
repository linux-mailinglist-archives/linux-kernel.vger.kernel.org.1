Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A382774F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgIXPMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgIXPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:12:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37333C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:12:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so3220134qtw.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vg4a2YgFjoJ9B75KAvzotsRbT0K43DN2jebINFLz4IM=;
        b=ZyPhsyeNSbU1Lwt+KDMRt+xRsiXvi9ADDXz+UjeMDX5wnErYX85XspH/n32y5ohaVG
         d/0OHkSV5G5ian/Bx0eMiZqN+CJcO9KSy8M7Kol9eBhmbTEOZwObZrv3dy3Vw1lvlNbV
         mYhSwNESozgbdvTDQVt806Lb6SxqqId72gAiRNka57/iGpfl/+FQyR9zY9iSVhP9JWi7
         BOzkRd9hH0LZGAgJlQLzBMB3G3DOr7SuCHCxMjekotXGfYc+TjRARCvj0Li3pxXi40Dl
         xDwYLhIocc9zRN7u7VWwGVbOB0V3DH6KEhUTGvFDR9prMiLl0upmLlFYNtZx/kH2H0W6
         lXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vg4a2YgFjoJ9B75KAvzotsRbT0K43DN2jebINFLz4IM=;
        b=Wk26DTxV4oZAqAt8XadagGO5R5eUbHl59PHDeGEXN0veVyaIcHu8NqtvR4mRcbDPDd
         Cj0qlYve3U4UlDcEgikMxYb0TJyJGT6i7uRy85dR06n0y6cv/UYU4Pod5sv8HdMZdBdn
         Oo9PzdVp+GzizQQ/AM2f/0tjKkt8f7A8HXx2AoasI2+UK0XnvWix8upIU4cr+V4f6n+j
         NnVkwVs7j62SkQ8Nq6YLiPj9kQ6Y0UxyOTbaVfnRA7ktUU9uFpEIx/ACbeQ/IM1UXon6
         HA2yzLsJ4k2rs6z6u7/GDJTdfs5ot9gSZB3CvqIpKTymC8nhZmO7JOWkImSjLyDzpFE9
         0i8A==
X-Gm-Message-State: AOAM533IXkQrcaq0ox1H7JLHAW7YTvM24XFLs9IPLLQx5/fTsuj2B73T
        n4Fl8SzYoaQSy3O6W82Hpa0=
X-Google-Smtp-Source: ABdhPJwAhg/jUhSWZCiRhkfZX34sR5ZrKDwPPXBSFS6HT+pPh1olXzQoAdn1cp3jYBf/J0VGuB4dYA==
X-Received: by 2002:ac8:60d9:: with SMTP id i25mr5836002qtm.209.1600960351330;
        Thu, 24 Sep 2020 08:12:31 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f3sm2328189qtg.71.2020.09.24.08.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 08:12:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6A05B27C0054;
        Thu, 24 Sep 2020 11:12:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 24 Sep 2020 11:12:29 -0400
X-ME-Sender: <xms:XLdsX6mGSiOpSotPs0Gv_JoZs-rzRh7jz5HvONNjtwQb5RPN5pLdxQ>
    <xme:XLdsXx1IefU2Ly8VFXGAexHGJikdD4ienHJvFn1uxq4Dh8LX_jTSDDFFnT7q8WK9w
    g8vUYWe4sNH1mpMww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduud
    drjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:XLdsX4oaihOo1WUk53DIlP-97bNUStCb-bs9h-j754Zbw5Z9EX9v0w>
    <xmx:XLdsX-m0wM3G1PHlMF4rzli8Mjtu4fOHrG9B-aZQWrEtDGFbxKq50Q>
    <xmx:XLdsX40hps7ELUhB4ejTW-itgJobf6cErWSOYhXetkgqY_5nujalkg>
    <xmx:XbdsX7SjMckZgoruDG-zySyr_NFVjw-4JfHMHQ0v2En-4TWJRwBO4Q>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2E773280059;
        Thu, 24 Sep 2020 11:12:27 -0400 (EDT)
Date:   Thu, 24 Sep 2020 23:12:26 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lockdep: Optimize the memory usage of circular queue
Message-ID: <20200924151226.GA56799@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200917080210.108095-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917080210.108095-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping ;-)

Regards,
Boqun

On Thu, Sep 17, 2020 at 04:01:50PM +0800, Boqun Feng wrote:
> Qian Cai reported a BFS_EQUEUEFULL warning [1] after read recursive
> deadlock detection merged into tip tree recently. Unlike the previous
> lockep graph searching, which iterate every lock class (every node in
> the graph) exactly once, the graph searching for read recurisve deadlock
> detection needs to iterate every lock dependency (every edge in the
> graph) once, as a result, the maximum memory cost of the circular queue
> changes from O(V), where V is the number of lock classes (nodes or
> vertices) in the graph, to O(E), where E is the number of lock
> dependencies (edges), because every lock class or dependency gets
> enqueued once in the BFS. Therefore we hit the BFS_EQUEUEFULL case.
> 
> However, actually we don't need to enqueue all dependencies for the BFS,
> because every time we enqueue a dependency, we almostly enqueue all
> other dependencies in the same dependency list ("almostly" is because
> we currently check before enqueue, so if a dependency doesn't pass the
> check stage we won't enqueue it, however, we can always do in reverse
> ordering), based on this, we can only enqueue the first dependency from
> a dependency list and every time we want to fetch a new dependency to
> work, we can either:
> 
> 1)	fetch the dependency next to the current dependency in the
> 	dependency list
> or
> 2)	if the dependency in 1) doesn't exist, fetch the dependency from
> 	the queue.
> 
> With this approach, the "max bfs queue depth" for a x86_64_defconfig +
> lockdep and selftest config kernel can get descreased from:
> 
>         max bfs queue depth:                   201
> 
> to (after apply this patch)
> 
>         max bfs queue depth:                   61
> 
> While I'm at it, clean up the code logic a little (e.g. directly return
> other than set a "ret" value and goto the "exit" label).
> 
> [1]: https://lore.kernel.org/lkml/17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com/
> 
> Reported-by: Qian Cai <cai@redhat.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/locking/lockdep.c | 108 ++++++++++++++++++++++++---------------
>  1 file changed, 67 insertions(+), 41 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index cccf4bc759c6..761c2327e9cf 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1640,35 +1640,22 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
>  			     int offset)
>  {
>  	struct lock_list *entry;
> -	struct lock_list *lock;
> +	struct lock_list *lock = NULL;
>  	struct list_head *head;
>  	struct circular_queue *cq = &lock_cq;
> -	enum bfs_result ret = BFS_RNOMATCH;
>  
>  	lockdep_assert_locked();
>  
> -	if (match(source_entry, data)) {
> -		*target_entry = source_entry;
> -		ret = BFS_RMATCH;
> -		goto exit;
> -	}
> -
> -	head = get_dep_list(source_entry, offset);
> -	if (list_empty(head))
> -		goto exit;
> -
>  	__cq_init(cq);
>  	__cq_enqueue(cq, source_entry);
>  
> -	while ((lock = __cq_dequeue(cq))) {
> -		bool prev_only_xr;
> -
> -		if (!lock->class) {
> -			ret = BFS_EINVALIDNODE;
> -			goto exit;
> -		}
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
> @@ -1676,17 +1663,17 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
>  		 * list accessed.
>  		 */
>  		if (lock_accessed(lock))
> -			continue;
> +			goto next;
>  		else
>  			mark_lock_accessed(lock);
>  
> -		head = get_dep_list(lock, offset);
> -
> -		prev_only_xr = lock->only_xr;
> -
> -		list_for_each_entry_rcu(entry, head, entry) {
> -			unsigned int cq_depth;
> -			u8 dep = entry->dep;
> +		/*
> +		 * Step 2: check whether prev dependency and this form a strong
> +		 *         dependency path.
> +		 */
> +		if (lock->parent) { /* Parent exists, check prev dependency */
> +			u8 dep = lock->dep;
> +			bool prev_only_xr = lock->parent->only_xr;
>  
>  			/*
>  			 * Mask out all -(S*)-> if we only have *R in previous
> @@ -1698,29 +1685,68 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
>  
>  			/* If nothing left, we skip */
>  			if (!dep)
> -				continue;
> +				goto next;
>  
>  			/* If there are only -(*R)-> left, set that for the next step */
> -			entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> +			lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> +		}
>  
> -			visit_lock_entry(entry, lock);
> -			if (match(entry, data)) {
> -				*target_entry = entry;
> -				ret = BFS_RMATCH;
> -				goto exit;
> -			}
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
> -			if (__cq_enqueue(cq, entry)) {
> -				ret = BFS_EQUEUEFULL;
> -				goto exit;
> -			}
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
>  	}
> -exit:
> -	return ret;
> +
> +	return BFS_RNOMATCH;
>  }
>  
>  static inline enum bfs_result
> -- 
> 2.28.0
> 
