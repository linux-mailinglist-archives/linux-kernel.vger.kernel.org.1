Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7672CA975
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgLARVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLARVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:21:15 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:20:34 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so5770784ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTaZh6qlC8fMdWEL3sssg+oqlnsdSx1UbYzoEkEYxpc=;
        b=iZ9PBj8OrO9axqQj9THLEa9tudhLlyOEDMd7OcQ8Yr3Ui8/Y+VpnEwWZ+ym7P73dCd
         M2+N7aH5hhWNrPDeKtOD5UP/YvCboyDJ98ogdGit8AjwQeqqupFONC01G/5/Nfkrm8xV
         LYi3s21IvnchYtCswfCCgAlTTLycYXKRwk0aD2oVhihLNnr90l8GvYwfieV82D/Bb8cs
         kepqreIyDPi0JCeRvFaNBHuUoD9j+jDOQy+MTvuDNPtw2MID6Qjag5FRBN898gLXtUUE
         /2uSCbLYhk/69pVWZM7KdMznhCYUa5X7tPlAN3PCEyXVpaZifBFzM9cMNWF2b64K7gLt
         VhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTaZh6qlC8fMdWEL3sssg+oqlnsdSx1UbYzoEkEYxpc=;
        b=NqmKdpnF2PUN8NcJWK3ldSBjwKkQOfNQRxm8igP/f9pDyIpl6WvTjfT5yGjU3l/2xM
         xxUdMxclfEvhLzyHTlo3bOhH9nQlV+pafbArS5tRhb2dSmJZwztVnBxy22qPDv+fpF0S
         Q5nF2DQ9txER1shQjhWyYF/oNYn+WtCOLAAMwifuhlCNa/9VtPrfxXfgWL/KIq3pXEio
         eYx9kObUT9rnVxnRsOzVhT1ZBkMAszbdVsa9ci8W8uuljzPjME+lAKShB7ZOZ38pd0QV
         simwq4sT2nOUNBB02U/b+O6F22d9Il33iyynUfH2ik0fzsL4GiKV/kCbhUOHx3khIcq8
         nczw==
X-Gm-Message-State: AOAM530N4rWUZmlg3F8Wi018tHEafaPjPG4UyQDUFYZEkHlhYOTCmifx
        M5b5I5zBfwQSCO9n7NfGF4ljGZSB+nn73acIzKU=
X-Google-Smtp-Source: ABdhPJyX343fuQFvay2XOLPeBFYpa63dwr3R4ZUlIIJjGT0gzDRcuvKcvP6Zv58hmAxTMWidVK7z47KXN8RJjP/kljI=
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr2969468ejb.499.1606843233520;
 Tue, 01 Dec 2020 09:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20201130184514.551950-1-shy828301@gmail.com> <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
 <cb3af838-9a01-dd49-6d96-44df425c2050@virtuozzo.com> <CAHbLzkp5fUsFsi7kYeEgQnd7atbzn_oUdQ0BSJ-QBrw+w-2MCg@mail.gmail.com>
 <b289239e-5fa8-0787-47d4-d0a356fdfe58@virtuozzo.com>
In-Reply-To: <b289239e-5fa8-0787-47d4-d0a356fdfe58@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Dec 2020 09:20:21 -0800
Message-ID: <CAHbLzkqsrJDPFkEd9o_J5xkB9_=hc=EBu0ppTN-AJfwSn2crng@mail.gmail.com>
Subject: Re: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient
 negative nr_items
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 9:17 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 01.12.2020 20:15, Yang Shi wrote:
> > On Tue, Dec 1, 2020 at 2:25 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 30.11.2020 23:09, Roman Gushchin wrote:
> >>> On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
> >>>> When investigating a slab cache bloat problem, significant amount of
> >>>> negative dentry cache was seen, but confusingly they neither got shrunk
> >>>> by reclaimer (the host has very tight memory) nor be shrunk by dropping
> >>>> cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> >>>> but tracing result shows they were even not scanned at all.  The further
> >>>> investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> >>>> reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> >>>> to reboot the hosts to get the memory back.
> >>>>
> >>>> I didn't manage to come up with a reproducer in test environment, and the
> >>>> problem can't be reproduced after rebooting.  But it seems there is race
> >>>> between shrinker map bit clear and reparenting by code inspection.  The
> >>>> hypothesis is elaborated as below.
> >>>>
> >>>> The memcg hierarchy on our production environment looks like:
> >>>>                 root
> >>>>                /    \
> >>>>           system   user
> >>>>
> >>>> The main workloads are running under user slice's children, and it creates
> >>>> and removes memcg frequently.  So reparenting happens very often under user
> >>>> slice, but no task is under user slice directly.
> >>>>
> >>>> So with the frequent reparenting and tight memory pressure, the below
> >>>> hypothetical race condition may happen:
> >>>>
> >>>>     CPU A                            CPU B                         CPU C
> >>>> reparent
> >>>>     dst->nr_items == 0
> >>>>                                  shrinker:
> >>>>                                      total_objects == 0
> >>>>     add src->nr_items to dst
> >>>>     set_bit
> >>>>                                      retrun SHRINK_EMPTY
> >>>>                                      clear_bit
> >>>>                                                                   list_lru_del()
> >>>> reparent again
> >>>>     dst->nr_items may go negative
> >>>>     due to current list_lru_del()
> >>>>     on CPU C
> >>>>                                  The second run of shrinker:
> >>>>                                      read nr_items without any
> >>>>                                      synchronization, so it may
> >>>>                                      see intermediate negative
> >>>>                                      nr_items then total_objects
> >>>>                                      may return 0 conincidently
> >>>>
> >>>>                                      keep the bit cleared
> >>>>     dst->nr_items != 0
> >>>>     skip set_bit
> >>>>     add scr->nr_item to dst
> >>>>
> >>>> After this point dst->nr_item may never go zero, so reparenting will not
> >>>> set shrinker_map bit anymore.  And since there is no task under user
> >>>> slice directly, so no new object will be added to its lru to set the
> >>>> shrinker map bit either.  That bit is kept cleared forever.
> >>>>
> >>>> How does list_lru_del() race with reparenting?  It is because
> >>>> reparenting replaces childen's kmemcg_id to parent's without protecting
> >>>> from nlru->lock, so list_lru_del() may see parent's kmemcg_id but
> >>>> actually deleting items from child's lru, but dec'ing parent's nr_items,
> >>>> so the parent's nr_items may go negative as commit
> >>>> 2788cf0c401c268b4819c5407493a8769b7007aa ("memcg: reparent list_lrus and
> >>>> free kmemcg_id on css offline") says.
> >>>>
> >>>> Can we move kmemcg_id replacement after reparenting?  No, because the
> >>>> race with list_lru_del() may result in negative src->nr_items, but it
> >>>> will never be fixed.  So the shrinker may never return SHRINK_EMPTY then
> >>>> keep the shrinker map bit set always.  The shrinker will be always
> >>>> called for nonsense.
> >>>>
> >>>> Can we synchronize list_lru_del() and reparenting?  Yes, it could be
> >>>> done.  But it seems we need introduce a new lock or use nlru->lock.  But
> >>>> it sounds complicated to move kmemcg_id replacement code under nlru->lock.
> >>>> And list_lru_del() may be called quite often to exacerbate some hot
> >>>> path, i.e. dentry kill.
> >>>>
> >>>> So, it sounds acceptable to synchronize reading nr_items to avoid seeing
> >>>> intermediate negative nr_items given the simplicity and it is typically
> >>>> just called by shrinkers when counting the freeable objects.
> >>>>
> >>>> The patch is tested with some shrinker intensive workloads, no
> >>>> noticeable regression is soptted.
> >>>
> >>> Hi Yang!
> >>>
> >>> It's really tricky, thank you for digging in! It's a perfect analysis!
> >>>
> >>> I wonder though, if it's better to just always set the shrinker bit on reparenting
> >>> if we do reparent some items? Then we'll avoid adding new synchronization
> >>> to the hot path. What do you think?
> >>>
> >>> --
> >>>
> >>> @@ -534,7 +534,6 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> >>>       struct list_lru_node *nlru = &lru->node[nid];
> >>>       int dst_idx = dst_memcg->kmemcg_id;
> >>>       struct list_lru_one *src, *dst;
> >>> -     bool set;
> >>>
> >>>       /*
> >>>        * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> >>> @@ -546,9 +545,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> >>>       dst = list_lru_from_memcg_idx(nlru, dst_idx);
> >>>
> >>>       list_splice_init(&src->list, &dst->list);
> >>> -     set = (!dst->nr_items && src->nr_items);
> >>>       dst->nr_items += src->nr_items;
> >>> -     if (set)
> >>> +     if (src->nr_items)
> >>>               memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> >>>       src->nr_items = 0;
> >>
> >> This looks like a good fix.
> >>
> >> To make a code more clear, we may also want to group neighbouring lines
> >> under the same "if" branch in Yang's v2 resend.
> >
> > You mean something like the below (diff based on Roman's proposal)?
> >
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index 127c2cf9f831..fe230081690b 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -545,10 +545,12 @@ static void memcg_drain_list_lru_node(struct
> > list_lru *lru, int nid,
> >         dst = list_lru_from_memcg_idx(nlru, dst_idx);
> >
> >         list_splice_init(&src->list, &dst->list);
> > -       dst->nr_items += src->nr_items;
> > -       if (src->nr_items)
> > +
> > +       if (src->nr_items) {
> > +               dst->nr_items += src->nr_items;
> >                 memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> > -       src->nr_items = 0;
> > +               src->nr_items = 0;
> > +       }
> >
> >         spin_unlock_irq(&nlru->lock);
>
> Yes.

Thanks for confirming. Will solve all the comments in v2.
