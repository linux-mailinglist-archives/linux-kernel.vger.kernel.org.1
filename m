Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EC27A94F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1IIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgI1IIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:08:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDCC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:08:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so192262qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5U+smSVl+4xtukEM9P0u301d1q3dkIlD3olSbf4eDuY=;
        b=X5ljRHo14HiOoVroSKoloq9NRP3x5SLNpBBbjqVXubZVVgElOdK0P4a0WPeKNaVoji
         5vwJkbMabvcpMXLN8U7zgdzFj0j5Q5CiuS/noS0Rw0BnT2Q3Z2R/PWzp5RIj0Z/1lLr0
         t7S5U2OgUX6pKDQgUp4NEj9ZdKs3xcCChbOh9yYxHam7asCDqs6yJvtbfeK+m5P+m+6u
         VvLiq/hD5A4lxh8V2GOcDFBwv/zpitdRA84qVWXjsZVI/SxkCSkLEd2b7noTiGBpaEcy
         O1TGgVShqnTn3xTFFrAV14ZfdBtYTQAFIExLtxWxkKgodLd4jDgzkRI9g8V6vLK0leRS
         +m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5U+smSVl+4xtukEM9P0u301d1q3dkIlD3olSbf4eDuY=;
        b=L3pIpl8hYjYccv3ieLHbdj6NdgHwUaMkXvMaSFVZonA8OrGco+I1uvSloAb2+P0IBX
         VsnDPzVNvsbVq4TPRzPFOP8j3JJqGmgb3K+h+Lfdzi/bhtlwcK+FceGxuGo3utCcGpP5
         4lqC25Ep2xw/R4b7t542k+LLfLrX4DxtMTSWqYz29GGUtGHClv/hDNyDJVqfcqaCs3rY
         l7YeBSJGrhorLac88MqLl1HMsGp8J2sB+vGaIvHkd01fzr51A8g32rl5qiaKRfzE6L2I
         IG8dMAdska/yuShlkbUZJwF6NgrnPvR5PzATHCv9PJHvGGnOTvKWn7gUM1sQtdRwujrh
         LUcA==
X-Gm-Message-State: AOAM530ZiwpQC7eokAXeFXv9tz0XKZUuqgpLLiYuPrmHxFlsl8nehTiq
        C9Rgbr+Ip77uBmOOOOEFBMM=
X-Google-Smtp-Source: ABdhPJzOrAW9c8nmmpcniwxuaI7GsEbhJxSsPST3Xvyk+bFPL+YET4761s9n+gpSHE8Y8YgjS3afIA==
X-Received: by 2002:a37:478c:: with SMTP id u134mr342364qka.206.1601280509402;
        Mon, 28 Sep 2020 01:08:29 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n203sm254350qke.66.2020.09.28.01.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 01:08:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9AFBC27C0054;
        Mon, 28 Sep 2020 04:08:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 28 Sep 2020 04:08:27 -0400
X-ME-Sender: <xms:-5lxX-L8a4TKQMyPHIJY_zlUnnnnLQ6Z3LI_edJXc4U9YjN0bOqd1g>
    <xme:-5lxX2LUe8v8E3LoNnA6S_jwBTG-bSXhbcQrlCYnRI2NeUx8u1vuJUGvRc1lgzpI9
    cYRGtJBxVo9fJwnPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettedvkeefgefhueduffefheekffeuveehffeuhfduffeftdefudehgfevgffg
    ieenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprg
    huthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsgho
    qhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:-5lxX-vRQaKxDB0cO7932xF7NA5J9ty5LZEB4yJW8AIG96BnN9Gmrg>
    <xmx:-5lxXzbvJsx48XzhSglHz9nMByBlfj4xk-K2y-XJvM_2MuBzjODpyQ>
    <xmx:-5lxX1Yiin2UFtSXzysazHl0TDI7UY1RSVekVvW13tq39l4m_m9xQA>
    <xmx:-5lxX4waN9NSpSJOn3GGyhcYdrJ_vqbxHMdJIw3NX_3Xg5ZF5ai39Q>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id BCFA53280065;
        Mon, 28 Sep 2020 04:08:26 -0400 (EDT)
Date:   Mon, 28 Sep 2020 16:08:25 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lockdep: Optimize the memory usage of circular queue
Message-ID: <20200928080825.GA17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200917080210.108095-1-boqun.feng@gmail.com>
 <20200924151226.GA56799@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CACT4Y+YxQ-v4Ym7QOwsa_Rm+iE-eauLq_W-rq6g=jsQCBYPdrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YxQ-v4Ym7QOwsa_Rm+iE-eauLq_W-rq6g=jsQCBYPdrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:03:19AM +0200, Dmitry Vyukov wrote:
> On Thu, Sep 24, 2020 at 5:13 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Ping ;-)
> >
> > Regards,
> > Boqun
> 
> Hi Boqun,
> 
> Peter says this may also fix this issue:
> https://syzkaller.appspot.com/bug?extid=62ebe501c1ce9a91f68c
> please add the following tag to the patch so that the bug report will
> be closed on merge:
> Reported-by: syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com
> 

Sure, I will if another version of this patch is required, otherwise (if
this one looks good to Peter), I will rely on Peter to add the tag ;-)
Works for you?

Regards,
Boqun

> > On Thu, Sep 17, 2020 at 04:01:50PM +0800, Boqun Feng wrote:
> > > Qian Cai reported a BFS_EQUEUEFULL warning [1] after read recursive
> > > deadlock detection merged into tip tree recently. Unlike the previous
> > > lockep graph searching, which iterate every lock class (every node in
> > > the graph) exactly once, the graph searching for read recurisve deadlock
> > > detection needs to iterate every lock dependency (every edge in the
> > > graph) once, as a result, the maximum memory cost of the circular queue
> > > changes from O(V), where V is the number of lock classes (nodes or
> > > vertices) in the graph, to O(E), where E is the number of lock
> > > dependencies (edges), because every lock class or dependency gets
> > > enqueued once in the BFS. Therefore we hit the BFS_EQUEUEFULL case.
> > >
> > > However, actually we don't need to enqueue all dependencies for the BFS,
> > > because every time we enqueue a dependency, we almostly enqueue all
> > > other dependencies in the same dependency list ("almostly" is because
> > > we currently check before enqueue, so if a dependency doesn't pass the
> > > check stage we won't enqueue it, however, we can always do in reverse
> > > ordering), based on this, we can only enqueue the first dependency from
> > > a dependency list and every time we want to fetch a new dependency to
> > > work, we can either:
> > >
> > > 1)    fetch the dependency next to the current dependency in the
> > >       dependency list
> > > or
> > > 2)    if the dependency in 1) doesn't exist, fetch the dependency from
> > >       the queue.
> > >
> > > With this approach, the "max bfs queue depth" for a x86_64_defconfig +
> > > lockdep and selftest config kernel can get descreased from:
> > >
> > >         max bfs queue depth:                   201
> > >
> > > to (after apply this patch)
> > >
> > >         max bfs queue depth:                   61
> > >
> > > While I'm at it, clean up the code logic a little (e.g. directly return
> > > other than set a "ret" value and goto the "exit" label).
> > >
> > > [1]: https://lore.kernel.org/lkml/17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com/
> > >
> > > Reported-by: Qian Cai <cai@redhat.com>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  kernel/locking/lockdep.c | 108 ++++++++++++++++++++++++---------------
> > >  1 file changed, 67 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > index cccf4bc759c6..761c2327e9cf 100644
> > > --- a/kernel/locking/lockdep.c
> > > +++ b/kernel/locking/lockdep.c
> > > @@ -1640,35 +1640,22 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> > >                            int offset)
> > >  {
> > >       struct lock_list *entry;
> > > -     struct lock_list *lock;
> > > +     struct lock_list *lock = NULL;
> > >       struct list_head *head;
> > >       struct circular_queue *cq = &lock_cq;
> > > -     enum bfs_result ret = BFS_RNOMATCH;
> > >
> > >       lockdep_assert_locked();
> > >
> > > -     if (match(source_entry, data)) {
> > > -             *target_entry = source_entry;
> > > -             ret = BFS_RMATCH;
> > > -             goto exit;
> > > -     }
> > > -
> > > -     head = get_dep_list(source_entry, offset);
> > > -     if (list_empty(head))
> > > -             goto exit;
> > > -
> > >       __cq_init(cq);
> > >       __cq_enqueue(cq, source_entry);
> > >
> > > -     while ((lock = __cq_dequeue(cq))) {
> > > -             bool prev_only_xr;
> > > -
> > > -             if (!lock->class) {
> > > -                     ret = BFS_EINVALIDNODE;
> > > -                     goto exit;
> > > -             }
> > > +     while (lock || (lock = __cq_dequeue(cq))) {
> > > +             if (!lock->class)
> > > +                     return BFS_EINVALIDNODE;
> > >
> > >               /*
> > > +              * Step 1: check whether we already finish on this one.
> > > +              *
> > >                * If we have visited all the dependencies from this @lock to
> > >                * others (iow, if we have visited all lock_list entries in
> > >                * @lock->class->locks_{after,before}) we skip, otherwise go
> > > @@ -1676,17 +1663,17 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> > >                * list accessed.
> > >                */
> > >               if (lock_accessed(lock))
> > > -                     continue;
> > > +                     goto next;
> > >               else
> > >                       mark_lock_accessed(lock);
> > >
> > > -             head = get_dep_list(lock, offset);
> > > -
> > > -             prev_only_xr = lock->only_xr;
> > > -
> > > -             list_for_each_entry_rcu(entry, head, entry) {
> > > -                     unsigned int cq_depth;
> > > -                     u8 dep = entry->dep;
> > > +             /*
> > > +              * Step 2: check whether prev dependency and this form a strong
> > > +              *         dependency path.
> > > +              */
> > > +             if (lock->parent) { /* Parent exists, check prev dependency */
> > > +                     u8 dep = lock->dep;
> > > +                     bool prev_only_xr = lock->parent->only_xr;
> > >
> > >                       /*
> > >                        * Mask out all -(S*)-> if we only have *R in previous
> > > @@ -1698,29 +1685,68 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> > >
> > >                       /* If nothing left, we skip */
> > >                       if (!dep)
> > > -                             continue;
> > > +                             goto next;
> > >
> > >                       /* If there are only -(*R)-> left, set that for the next step */
> > > -                     entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> > > +                     lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> > > +             }
> > >
> > > -                     visit_lock_entry(entry, lock);
> > > -                     if (match(entry, data)) {
> > > -                             *target_entry = entry;
> > > -                             ret = BFS_RMATCH;
> > > -                             goto exit;
> > > -                     }
> > > +             /*
> > > +              * Step 3: we haven't visited this and there is a strong
> > > +              *         dependency path to this, so check with @match.
> > > +              */
> > > +             if (match(lock, data)) {
> > > +                     *target_entry = lock;
> > > +                     return BFS_RMATCH;
> > > +             }
> > > +
> > > +             /*
> > > +              * Step 4: if not match, expand the path by adding the
> > > +              *         afterwards or backwards dependencis in the search
> > > +              *
> > > +              * Note we only enqueue the first of the list into the queue,
> > > +              * because we can always find a sibling dependency from one
> > > +              * (see label 'next'), as a result the space of queue is saved.
> > > +              */
> > > +             head = get_dep_list(lock, offset);
> > > +             entry = list_first_or_null_rcu(head, struct lock_list, entry);
> > > +             if (entry) {
> > > +                     unsigned int cq_depth;
> > > +
> > > +                     if (__cq_enqueue(cq, entry))
> > > +                             return BFS_EQUEUEFULL;
> > >
> > > -                     if (__cq_enqueue(cq, entry)) {
> > > -                             ret = BFS_EQUEUEFULL;
> > > -                             goto exit;
> > > -                     }
> > >                       cq_depth = __cq_get_elem_count(cq);
> > >                       if (max_bfs_queue_depth < cq_depth)
> > >                               max_bfs_queue_depth = cq_depth;
> > >               }
> > > +
> > > +             /*
> > > +              * Update the ->parent, so when @entry is iterated, we know the
> > > +              * previous dependency.
> > > +              */
> > > +             list_for_each_entry_rcu(entry, head, entry)
> > > +                     visit_lock_entry(entry, lock);
> > > +next:
> > > +             /*
> > > +              * Step 5: fetch the next dependency to process.
> > > +              *
> > > +              * If there is a previous dependency, we fetch the sibling
> > > +              * dependency in the dep list of previous dependency.
> > > +              *
> > > +              * Otherwise set @lock to NULL to fetch the next entry from
> > > +              * queue.
> > > +              */
> > > +             if (lock->parent) {
> > > +                     head = get_dep_list(lock->parent, offset);
> > > +                     lock = list_next_or_null_rcu(head, &lock->entry,
> > > +                                                  struct lock_list, entry);
> > > +             } else {
> > > +                     lock = NULL;
> > > +             }
> > >       }
> > > -exit:
> > > -     return ret;
> > > +
> > > +     return BFS_RNOMATCH;
> > >  }
> > >
> > >  static inline enum bfs_result
> > > --
> > > 2.28.0
> > >
