Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C797427A958
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgI1INQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgI1INQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:13:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A3EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:13:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o5so176990qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLt29c0DJCXYpK+0imunGnN5pGxb5GjCimC1bYRB3LI=;
        b=nDZjTDrvZvjVfTDwWyddPVCDbWvuZYJBM52+Gr8axJHwPrd3UZ4JM+loOdojejWQoQ
         OOaeJzyFqZBB88pUgq76hyWHYy37muNcGMNz+gEjGS8c9leXtkrI8zQafgFAugo91bDE
         8iMHwHUwa93Yp2vPvdjdDAqZTasU4FvE8y+eKitnziR969XCgNjqFlG0V/kN59HDykmC
         enrvrtowoIBKctiF+rrTlGPZFsFcm2nZuYdPfYCRhSjKD+qaKnWmuFNi4WmlwCr+RFd6
         VRRmeYBRzAPVnsRKQjiJgo0HedgD827//Rkn3Vt5Av/nWx2ZKPK5mzvOuHjplznWqi3K
         k46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLt29c0DJCXYpK+0imunGnN5pGxb5GjCimC1bYRB3LI=;
        b=fF2IdUymKIpPdusbt9PW1DzDJRvuGSh7rbyT8VoqCN+os6UD0JPvd1HmroziI9qkBs
         rHYgwnlo5ZYHGCNcrIbitREIuin3vhp/3FuKtDZoKGMsBytUA86RJ4+r17L/lZixDmke
         kX/Bm1tb7rdwLOL00zBmVmNVLUJoK571VpWik9jQeZgARPmbPtcRvqN1Dkis4hqUezuh
         7jUKEtcODhJi6wKbu9dVpopCz9P9zwjxuhl6i7C7a83jAtZQZYvDLZvTDf1o9N6JjC6p
         HotsyRUhoZ0tjqXAbYaB/kD2hbbrQzHvBopLiK+jw4n7ZqFIVMlP9bS4ajQDgYJ2Ypyl
         lBug==
X-Gm-Message-State: AOAM531h9Inzjc56JBZUIPEHus9NPk7HUJ7BdapgYcsNE5RdhGV+p5BL
        L+Hv4oD73WTr0h35qR0yNf+DMy3i2upMk36a00aEpQ==
X-Google-Smtp-Source: ABdhPJxG9bDuV3NmhBNQW01pAIyxsOSht9cA0HdtX/+jLosX+jTTLtJOoaTDI5I0+eGFWefnOQZhCnF5g2GdcZTwX5k=
X-Received: by 2002:a37:a4c5:: with SMTP id n188mr356869qke.8.1601280794849;
 Mon, 28 Sep 2020 01:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200917080210.108095-1-boqun.feng@gmail.com> <20200924151226.GA56799@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CACT4Y+YxQ-v4Ym7QOwsa_Rm+iE-eauLq_W-rq6g=jsQCBYPdrQ@mail.gmail.com> <20200928080825.GA17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
In-Reply-To: <20200928080825.GA17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 10:13:03 +0200
Message-ID: <CACT4Y+YRVwpg=S=jJCzDUKmUrUhgHGC07cG95pi-HpbjHPc5Yg@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Optimize the memory usage of circular queue
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:08 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 10:03:19AM +0200, Dmitry Vyukov wrote:
> > On Thu, Sep 24, 2020 at 5:13 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > Ping ;-)
> > >
> > > Regards,
> > > Boqun
> >
> > Hi Boqun,
> >
> > Peter says this may also fix this issue:
> > https://syzkaller.appspot.com/bug?extid=62ebe501c1ce9a91f68c
> > please add the following tag to the patch so that the bug report will
> > be closed on merge:
> > Reported-by: syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com
> >
>
> Sure, I will if another version of this patch is required, otherwise (if
> this one looks good to Peter), I will rely on Peter to add the tag ;-)
> Works for you?

Yes, totally, thanks.

> Regards,
> Boqun
>
> > > On Thu, Sep 17, 2020 at 04:01:50PM +0800, Boqun Feng wrote:
> > > > Qian Cai reported a BFS_EQUEUEFULL warning [1] after read recursive
> > > > deadlock detection merged into tip tree recently. Unlike the previous
> > > > lockep graph searching, which iterate every lock class (every node in
> > > > the graph) exactly once, the graph searching for read recurisve deadlock
> > > > detection needs to iterate every lock dependency (every edge in the
> > > > graph) once, as a result, the maximum memory cost of the circular queue
> > > > changes from O(V), where V is the number of lock classes (nodes or
> > > > vertices) in the graph, to O(E), where E is the number of lock
> > > > dependencies (edges), because every lock class or dependency gets
> > > > enqueued once in the BFS. Therefore we hit the BFS_EQUEUEFULL case.
> > > >
> > > > However, actually we don't need to enqueue all dependencies for the BFS,
> > > > because every time we enqueue a dependency, we almostly enqueue all
> > > > other dependencies in the same dependency list ("almostly" is because
> > > > we currently check before enqueue, so if a dependency doesn't pass the
> > > > check stage we won't enqueue it, however, we can always do in reverse
> > > > ordering), based on this, we can only enqueue the first dependency from
> > > > a dependency list and every time we want to fetch a new dependency to
> > > > work, we can either:
> > > >
> > > > 1)    fetch the dependency next to the current dependency in the
> > > >       dependency list
> > > > or
> > > > 2)    if the dependency in 1) doesn't exist, fetch the dependency from
> > > >       the queue.
> > > >
> > > > With this approach, the "max bfs queue depth" for a x86_64_defconfig +
> > > > lockdep and selftest config kernel can get descreased from:
> > > >
> > > >         max bfs queue depth:                   201
> > > >
> > > > to (after apply this patch)
> > > >
> > > >         max bfs queue depth:                   61
> > > >
> > > > While I'm at it, clean up the code logic a little (e.g. directly return
> > > > other than set a "ret" value and goto the "exit" label).
> > > >
> > > > [1]: https://lore.kernel.org/lkml/17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com/
> > > >
> > > > Reported-by: Qian Cai <cai@redhat.com>
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > >  kernel/locking/lockdep.c | 108 ++++++++++++++++++++++++---------------
> > > >  1 file changed, 67 insertions(+), 41 deletions(-)
> > > >
> > > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > > index cccf4bc759c6..761c2327e9cf 100644
> > > > --- a/kernel/locking/lockdep.c
> > > > +++ b/kernel/locking/lockdep.c
> > > > @@ -1640,35 +1640,22 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> > > >                            int offset)
> > > >  {
> > > >       struct lock_list *entry;
> > > > -     struct lock_list *lock;
> > > > +     struct lock_list *lock = NULL;
> > > >       struct list_head *head;
> > > >       struct circular_queue *cq = &lock_cq;
> > > > -     enum bfs_result ret = BFS_RNOMATCH;
> > > >
> > > >       lockdep_assert_locked();
> > > >
> > > > -     if (match(source_entry, data)) {
> > > > -             *target_entry = source_entry;
> > > > -             ret = BFS_RMATCH;
> > > > -             goto exit;
> > > > -     }
> > > > -
> > > > -     head = get_dep_list(source_entry, offset);
> > > > -     if (list_empty(head))
> > > > -             goto exit;
> > > > -
> > > >       __cq_init(cq);
> > > >       __cq_enqueue(cq, source_entry);
> > > >
> > > > -     while ((lock = __cq_dequeue(cq))) {
> > > > -             bool prev_only_xr;
> > > > -
> > > > -             if (!lock->class) {
> > > > -                     ret = BFS_EINVALIDNODE;
> > > > -                     goto exit;
> > > > -             }
> > > > +     while (lock || (lock = __cq_dequeue(cq))) {
> > > > +             if (!lock->class)
> > > > +                     return BFS_EINVALIDNODE;
> > > >
> > > >               /*
> > > > +              * Step 1: check whether we already finish on this one.
> > > > +              *
> > > >                * If we have visited all the dependencies from this @lock to
> > > >                * others (iow, if we have visited all lock_list entries in
> > > >                * @lock->class->locks_{after,before}) we skip, otherwise go
> > > > @@ -1676,17 +1663,17 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> > > >                * list accessed.
> > > >                */
> > > >               if (lock_accessed(lock))
> > > > -                     continue;
> > > > +                     goto next;
> > > >               else
> > > >                       mark_lock_accessed(lock);
> > > >
> > > > -             head = get_dep_list(lock, offset);
> > > > -
> > > > -             prev_only_xr = lock->only_xr;
> > > > -
> > > > -             list_for_each_entry_rcu(entry, head, entry) {
> > > > -                     unsigned int cq_depth;
> > > > -                     u8 dep = entry->dep;
> > > > +             /*
> > > > +              * Step 2: check whether prev dependency and this form a strong
> > > > +              *         dependency path.
> > > > +              */
> > > > +             if (lock->parent) { /* Parent exists, check prev dependency */
> > > > +                     u8 dep = lock->dep;
> > > > +                     bool prev_only_xr = lock->parent->only_xr;
> > > >
> > > >                       /*
> > > >                        * Mask out all -(S*)-> if we only have *R in previous
> > > > @@ -1698,29 +1685,68 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> > > >
> > > >                       /* If nothing left, we skip */
> > > >                       if (!dep)
> > > > -                             continue;
> > > > +                             goto next;
> > > >
> > > >                       /* If there are only -(*R)-> left, set that for the next step */
> > > > -                     entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> > > > +                     lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
> > > > +             }
> > > >
> > > > -                     visit_lock_entry(entry, lock);
> > > > -                     if (match(entry, data)) {
> > > > -                             *target_entry = entry;
> > > > -                             ret = BFS_RMATCH;
> > > > -                             goto exit;
> > > > -                     }
> > > > +             /*
> > > > +              * Step 3: we haven't visited this and there is a strong
> > > > +              *         dependency path to this, so check with @match.
> > > > +              */
> > > > +             if (match(lock, data)) {
> > > > +                     *target_entry = lock;
> > > > +                     return BFS_RMATCH;
> > > > +             }
> > > > +
> > > > +             /*
> > > > +              * Step 4: if not match, expand the path by adding the
> > > > +              *         afterwards or backwards dependencis in the search
> > > > +              *
> > > > +              * Note we only enqueue the first of the list into the queue,
> > > > +              * because we can always find a sibling dependency from one
> > > > +              * (see label 'next'), as a result the space of queue is saved.
> > > > +              */
> > > > +             head = get_dep_list(lock, offset);
> > > > +             entry = list_first_or_null_rcu(head, struct lock_list, entry);
> > > > +             if (entry) {
> > > > +                     unsigned int cq_depth;
> > > > +
> > > > +                     if (__cq_enqueue(cq, entry))
> > > > +                             return BFS_EQUEUEFULL;
> > > >
> > > > -                     if (__cq_enqueue(cq, entry)) {
> > > > -                             ret = BFS_EQUEUEFULL;
> > > > -                             goto exit;
> > > > -                     }
> > > >                       cq_depth = __cq_get_elem_count(cq);
> > > >                       if (max_bfs_queue_depth < cq_depth)
> > > >                               max_bfs_queue_depth = cq_depth;
> > > >               }
> > > > +
> > > > +             /*
> > > > +              * Update the ->parent, so when @entry is iterated, we know the
> > > > +              * previous dependency.
> > > > +              */
> > > > +             list_for_each_entry_rcu(entry, head, entry)
> > > > +                     visit_lock_entry(entry, lock);
> > > > +next:
> > > > +             /*
> > > > +              * Step 5: fetch the next dependency to process.
> > > > +              *
> > > > +              * If there is a previous dependency, we fetch the sibling
> > > > +              * dependency in the dep list of previous dependency.
> > > > +              *
> > > > +              * Otherwise set @lock to NULL to fetch the next entry from
> > > > +              * queue.
> > > > +              */
> > > > +             if (lock->parent) {
> > > > +                     head = get_dep_list(lock->parent, offset);
> > > > +                     lock = list_next_or_null_rcu(head, &lock->entry,
> > > > +                                                  struct lock_list, entry);
> > > > +             } else {
> > > > +                     lock = NULL;
> > > > +             }
> > > >       }
> > > > -exit:
> > > > -     return ret;
> > > > +
> > > > +     return BFS_RNOMATCH;
> > > >  }
> > > >
> > > >  static inline enum bfs_result
> > > > --
> > > > 2.28.0
> > > >
