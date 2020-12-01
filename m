Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002552CA96C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgLARUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgLART6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:19:58 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4438C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:19:17 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id y22so4431043edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQKIIhxcjoKVEtwnQ+W/fhUOvKOLq2pB3RUeQtzqXE0=;
        b=mHJRr5IQ0LM2xeUQGg8kKZ4FHj8Yn4VIVKEcX3t0MtTupgfvFybzy3Rph+eEuHpjon
         rPote0nXx21oj8cJmXYSEHIwjLihOrFdZziNCckU5Agi0jt2ryCcBRmPZpxrnmaxR1vS
         F8AaUCJsQJWIhBOjahpFJ49UB/wv398rJbPufSwaGUjnU4FNSfkFFxlgRpttTbwZp1JP
         +MUQMUR5ToW0ImCOa96JISZY9+0PhIE1IFDJkIhBSO2gpu3kZ89gILYkghqm7wgzkWmg
         we5dc/k7I5r73vYF3lqnzLokNA+zJ5DhIa7h1sxMMes3Hv1+gRVvkxULSzam2t8G9MVh
         Ba1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQKIIhxcjoKVEtwnQ+W/fhUOvKOLq2pB3RUeQtzqXE0=;
        b=VATzIA98d4QLELBtFFqPVfLTCOdQBd1/XvxtdlbQ1oE+o+tkDQqqZy5UO/g2U8JHoz
         qulmavcnPkTyv8VPro0IHFZtjnOTJm/SZ2LkakDRDcc5eTsLBKYDKxzmXbmAmEuo2tcU
         LrL11lYRIa4bVe8/IeXW8HnDSGa21mtrGl10MWWyZU6AtGkIQPZ9CKulFXBgt7rEVGtj
         ZqHkE0UL5ho3Xqmb42aTPcUijcwdfocoSyK1XRCnYb6MoBQk1NiiZHgTq4qcjXsCS+IK
         py0kW71ltt5Y2nc172CuWhDSJzk93hBqRJf5BtB56ohTR2+6+3+CXKyRg4ymUXc9/Dpt
         6YMQ==
X-Gm-Message-State: AOAM533dIHVl9jm+Mw/6AMd2wT14HmsZHYqnagJLp97zbMfQGYAh46T/
        C7cHw+mZNHIN56OfNNMMDM8C2w9Ou7iLC9FQwmI=
X-Google-Smtp-Source: ABdhPJwPxJwfKRbLCo1ScpWc5QcnUc5Bh0dSP8w2ecuzPNnP0wjC2azPfNOI/vc4wzbVVpi9wlWUn67wFNbpDGQPT6A=
X-Received: by 2002:a05:6402:1c8a:: with SMTP id cy10mr4016563edb.151.1606843156527;
 Tue, 01 Dec 2020 09:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20201130184514.551950-1-shy828301@gmail.com> <b97edff8-4339-e3d1-3499-b14acdd5dd55@virtuozzo.com>
In-Reply-To: <b97edff8-4339-e3d1-3499-b14acdd5dd55@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Dec 2020 09:19:04 -0800
Message-ID: <CAHbLzkpwCXXfHZx2pwkkvLLK3_8pKt8q-Aec=qnLhVFnmvq=Vw@mail.gmail.com>
Subject: Re: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient
 negative nr_items
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:09 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 30.11.2020 21:45, Yang Shi wrote:
> > When investigating a slab cache bloat problem, significant amount of
> > negative dentry cache was seen, but confusingly they neither got shrunk
> > by reclaimer (the host has very tight memory) nor be shrunk by dropping
> > cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> > but tracing result shows they were even not scanned at all.  The further
> > investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> > reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> > to reboot the hosts to get the memory back.
> >
> > I didn't manage to come up with a reproducer in test environment, and the
> > problem can't be reproduced after rebooting.  But it seems there is race
> > between shrinker map bit clear and reparenting by code inspection.  The
> > hypothesis is elaborated as below.
> >
> > The memcg hierarchy on our production environment looks like:
> >                 root
> >                /    \
> >           system   user
> >
> > The main workloads are running under user slice's children, and it creates
> > and removes memcg frequently.  So reparenting happens very often under user
> > slice, but no task is under user slice directly.
> >
> > So with the frequent reparenting and tight memory pressure, the below
> > hypothetical race condition may happen:
> >
> >     CPU A                            CPU B                         CPU C
> > reparent
> >     dst->nr_items == 0
> >                                  shrinker:
> >                                      total_objects == 0
> >     add src->nr_items to dst
> >     set_bit
> >                                      retrun SHRINK_EMPTY
> >                                      clear_bit
> >                                                                   list_lru_del()
> > reparent again
> >     dst->nr_items may go negative
> >     due to current list_lru_del()
> >     on CPU C
> >                                  The second run of shrinker:
> >                                      read nr_items without any
> >                                      synchronization, so it may
> >                                      see intermediate negative
> >                                      nr_items then total_objects
> >                                      may return 0 conincidently
> >
> >                                      keep the bit cleared
> >     dst->nr_items != 0
> >     skip set_bit
> >     add scr->nr_item to dst
>
> Good catch, Yang. Thanks for investigating this.
>
> But I agree with Roman it's better to fix that in rare-called place
> (memcg_drain_list_lru_node()), than in hot place (list_lru_count_one()).

Yes, agreed. Will incarnate Roman's proposal in v2.

>
> Also, I'd added to description of new patch a reference to memcg_offline_kmem(),
> because this is the place, where child->kmemcg_id is rewritten, and
> this is the reason of lru's nr_items may become negative.

Sure.

>
> > After this point dst->nr_item may never go zero, so reparenting will not
> > set shrinker_map bit anymore.  And since there is no task under user
> > slice directly, so no new object will be added to its lru to set the
> > shrinker map bit either.  That bit is kept cleared forever.
> >
> > How does list_lru_del() race with reparenting?  It is because
> > reparenting replaces childen's kmemcg_id to parent's without protecting
> > from nlru->lock, so list_lru_del() may see parent's kmemcg_id but
> > actually deleting items from child's lru, but dec'ing parent's nr_items,
> > so the parent's nr_items may go negative as commit
> > 2788cf0c401c268b4819c5407493a8769b7007aa ("memcg: reparent list_lrus and
> > free kmemcg_id on css offline") says.
> >
> > Can we move kmemcg_id replacement after reparenting?  No, because the
> > race with list_lru_del() may result in negative src->nr_items, but it
> > will never be fixed.  So the shrinker may never return SHRINK_EMPTY then
> > keep the shrinker map bit set always.  The shrinker will be always
> > called for nonsense.
> >
> > Can we synchronize list_lru_del() and reparenting?  Yes, it could be
> > done.  But it seems we need introduce a new lock or use nlru->lock.  But
> > it sounds complicated to move kmemcg_id replacement code under nlru->lock.
> > And list_lru_del() may be called quite often to exacerbate some hot
> > path, i.e. dentry kill.
> >
> > So, it sounds acceptable to synchronize reading nr_items to avoid seeing
> > intermediate negative nr_items given the simplicity and it is typically
> > just called by shrinkers when counting the freeable objects.
> >
> > The patch is tested with some shrinker intensive workloads, no
> > noticeable regression is soptted.
> >
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/list_lru.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index 5aa6e44bc2ae..5c128a7710ff 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -178,10 +178,17 @@ unsigned long list_lru_count_one(struct list_lru *lru,
> >       struct list_lru_one *l;
> >       unsigned long count;
> >
> > -     rcu_read_lock();
> > +     /*
> > +      * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> > +      * we have to use IRQ-safe primitives here to avoid deadlock.
> > +      *
> > +      * Hold the lock to prevent from seeing transient negative
> > +      * nr_items value.
> > +      */
> > +     spin_lock_irq(&nlru->lock);
> >       l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
> >       count = READ_ONCE(l->nr_items);
> > -     rcu_read_unlock();
> > +     spin_unlock_irq(&nlru->lock);
> >
> >       return count;
> >  }
> >
>
>
