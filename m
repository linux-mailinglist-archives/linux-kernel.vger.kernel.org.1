Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08FE2C8F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgK3U6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgK3U6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:58:46 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6BCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:58:00 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id n24so16091688edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hci+1ob7MZgwxgVIAVmLhMzaUPYPk+RYx+il0umiDZo=;
        b=Y7uUCGOG6GCkOMr5Jskg6pX9gPQ4Ewe3wXh9NqicaSTboQHEKT4h7YfsCVLDq1uqGp
         meMiaF16Ogn2WPziMCYFdt1nMCrdgjvCPA1WICsC4bzigG9Ul4wGBTkwl1GImyY5O6Ih
         1QdoALHMRGrPty02v3Ub3DZ82XB8ngnaIomVYDSHaxG23ktdU/3re18sScaauWlECztU
         5PMrM/oWRozrmMs1w4oU6DJSwbI1EVKoLAxhh8uZ+aYWM7Qfj5AUuo2CyODtbCJmhGXz
         g9ylKuh/iMfgya8NrRVLKSW1OKnP5zD72SUS1TOtyG0Co3izad2f/XpaawQqxmdLj48j
         JRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hci+1ob7MZgwxgVIAVmLhMzaUPYPk+RYx+il0umiDZo=;
        b=YV40lgNjFbWqOQBB69/sPmWhZFp/hQp5D7UiYCLYAPkjmGve6yivcYil80bb75kTEK
         3OXVEceZ4+PftNgvVgCdxHUldW8tRKxyNnfIMXqi9+X2zB8ihCOaIXLcbGmaAhDrLUxO
         crxpYuTJQ6vcMpRZo9cdCbZJFJRNPzkbDv04Sds0QcuzSkOv4f8neOZoFbMU+PmwjmLL
         ummj4TVaNrRdkFNl0a6eAsMRXt1V3nqFQP/S3mw4JmMGYPYev7dO6SHMPkCEFwss7NR+
         WkXZ9X2soU7fO/UGNHDNndLHoHNL5liI3wq3/+9oUmq7Y6ZWb5+sD/q1BENOwl7+jdiT
         Xwxw==
X-Gm-Message-State: AOAM532WOdHyqv5CZ5WVOi6taj0FbOWfFhC547I2lqfvm9wMxAUE9psF
        hk2Cy25kj6BSG35JHNo1dAY0tm7NIYu+sr3H7qQ=
X-Google-Smtp-Source: ABdhPJxu6r42VfA8JSawKiN8UCCbg+8gcCXoGwYi0EWRnD9tomOaejnjVvhO3vFGnozxnfbjl4Q9Cew8w/c4s3PcllY=
X-Received: by 2002:a05:6402:c9b:: with SMTP id cm27mr2686572edb.294.1606769879287;
 Mon, 30 Nov 2020 12:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20201130184514.551950-1-shy828301@gmail.com> <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Nov 2020 12:57:47 -0800
Message-ID: <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com>
Subject: Re: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient
 negative nr_items
To:     Roman Gushchin <guro@fb.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
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
> >
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
>
> Hi Yang!
>
> It's really tricky, thank you for digging in! It's a perfect analysis!
>
> I wonder though, if it's better to just always set the shrinker bit on reparenting
> if we do reparent some items? Then we'll avoid adding new synchronization
> to the hot path. What do you think?

Thanks a lot for the suggestion. I was thinking about the same
approach too, but I thought src->nr_items may go zero due to
concurrent list_lru_del() at the first place. But I just rethought the
whole thing, it seems impossible that dst->nr_items goes negative and
src->nr_items goes zero at the same time. list_lru_del() should just
see either dst or src, it can't manipulate both lists simultaneously.
So I think your suggestion should work. I will incarnate your
suggestion in v2.

>
> --
>
> @@ -534,7 +534,6 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>         struct list_lru_node *nlru = &lru->node[nid];
>         int dst_idx = dst_memcg->kmemcg_id;
>         struct list_lru_one *src, *dst;
> -       bool set;
>
>         /*
>          * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> @@ -546,9 +545,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>         dst = list_lru_from_memcg_idx(nlru, dst_idx);
>
>         list_splice_init(&src->list, &dst->list);
> -       set = (!dst->nr_items && src->nr_items);
>         dst->nr_items += src->nr_items;
> -       if (set)
> +       if (src->nr_items)
>                 memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
>         src->nr_items = 0;
>
>
> --
>
> Btw, it seems that the bug is quite old. I wonder why we haven't seen it before?
> Any ideas?

It is not new, but not that old from my point of view. The
shrinker_map thing was introduced since v4.19, I bet pre-v4.19 kernel
may still dominate in production environment. And, it needs some
conditions (i.e. nr_inode + nr_dentry == 0 coincidently, and there is
not task under dst memcg directly, etc) to trigger, so it seems
unlikely to hit.

And the consequence may be not noticeable to the most people at all.
We happened to see frequent OOMs on a couple of small machines (32G
memory w/o swap, but most memory was consumed by anonymous pages)
recently and they were already up for long time (almost 300 days),
then the investigation leads to this race condition.

>
>
> Thanks!
>
>
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
> > --
> > 2.26.2
> >
