Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6DF2C91AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgK3Wy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbgK3Wy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:54:56 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA30C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:54:15 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so18113110ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxnkwRTZ0Nf3UlU1Niuq+4jZM/RsNgxDizkMSh8t26E=;
        b=EIHwEmeWSB5eXKcF/tL7BDtRHh4/fYCyLEG8DrWDPF1RZoPEe+WmkQtjHAO4E303VD
         +/vrrVDC9WYna4ZCBRsx3paaRu3M+1M4o99wqfyMUNYuRjUT7gU2bT458ryuxzv0PY5f
         LcHGCfp7iAvKHJRwJD3BVMYkYqwW4AOXSaKZEWb6UHVlLg9E1A2kkJlPYhX3udfXzOqI
         rTUVVhT0TG5hFwh3uBNRnZ8gHl39runVO4sOpPg61+/4J6vayMniSLFHYPBYhGoIyPYL
         tJfTS0PEuZRxTOzUWqfQTcFcMbh1MuGIEPNxDzpZN+DzO33sYozAL4x9Xrh163Edh4Fa
         LbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxnkwRTZ0Nf3UlU1Niuq+4jZM/RsNgxDizkMSh8t26E=;
        b=Ape12ydUXpSxkHr/wL8NRPBUWqamLurkvmNWEtmF08WUjDmvaROof8yFEE+k43tuqs
         173BLkP+ftjZM0VEuY4WsqDziXBirjSsBPBXEZFv2S0pRBnRLQpv7WJy06EZDWHOAmjQ
         Y7KbOE370Gou8qPrauMClLc/+cQiVyQrWTbuEliJqpVmB5ni4rgbEYU/56+qVg38563V
         8aEKLzNvIr94/ZFidMzAvu4M8O5ktjWJaoflXlKT7I5BbsAYuSNt07aLIg+dDUD5JLY6
         aMjzKXgypYZiO3lvs39yZdSD/wc2gvhPrFQLNaEdU7VeXZGzAr+FgwJbQDsGK4WdNWqu
         5G4w==
X-Gm-Message-State: AOAM531/Tqkjh+Mv/92raiixkUHyx32AsW4+AzcHHH4eIp1Ss3ENHQZ0
        B9cE62bS0yX3eDBbcyoAEh1Ofr9JOMrlTffDI3A=
X-Google-Smtp-Source: ABdhPJx/Uv+A4sb/xDVxQU5cCKB4UBGPy39wbAm4L2zxTtcpuewFTm88sXkB+ZZj1Y/XHnFBmbbXEXoYiIy61Wyid2U=
X-Received: by 2002:a17:906:24c3:: with SMTP id f3mr69817ejb.238.1606776854418;
 Mon, 30 Nov 2020 14:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20201130184514.551950-1-shy828301@gmail.com> <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
 <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com> <20201130223347.GE840171@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201130223347.GE840171@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Nov 2020 14:54:02 -0800
Message-ID: <CAHbLzkpLp+RQrzvBLXW9=xEw1z9hUodu0TqGdjeuhFO0vW=2TA@mail.gmail.com>
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

On Mon, Nov 30, 2020 at 2:33 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Nov 30, 2020 at 12:57:47PM -0800, Yang Shi wrote:
> > On Mon, Nov 30, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
> > > > When investigating a slab cache bloat problem, significant amount of
> > > > negative dentry cache was seen, but confusingly they neither got shrunk
> > > > by reclaimer (the host has very tight memory) nor be shrunk by dropping
> > > > cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> > > > but tracing result shows they were even not scanned at all.  The further
> > > > investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> > > > reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> > > > to reboot the hosts to get the memory back.
> > > >
> > > > I didn't manage to come up with a reproducer in test environment, and the
> > > > problem can't be reproduced after rebooting.  But it seems there is race
> > > > between shrinker map bit clear and reparenting by code inspection.  The
> > > > hypothesis is elaborated as below.
> > > >
> > > > The memcg hierarchy on our production environment looks like:
> > > >                 root
> > > >                /    \
> > > >           system   user
> > > >
> > > > The main workloads are running under user slice's children, and it creates
> > > > and removes memcg frequently.  So reparenting happens very often under user
> > > > slice, but no task is under user slice directly.
> > > >
> > > > So with the frequent reparenting and tight memory pressure, the below
> > > > hypothetical race condition may happen:
> > > >
> > > >     CPU A                            CPU B                         CPU C
> > > > reparent
> > > >     dst->nr_items == 0
> > > >                                  shrinker:
> > > >                                      total_objects == 0
> > > >     add src->nr_items to dst
> > > >     set_bit
> > > >                                      retrun SHRINK_EMPTY
> > > >                                      clear_bit
> > > >                                                                   list_lru_del()
> > > > reparent again
> > > >     dst->nr_items may go negative
> > > >     due to current list_lru_del()
> > > >     on CPU C
> > > >                                  The second run of shrinker:
> > > >                                      read nr_items without any
> > > >                                      synchronization, so it may
> > > >                                      see intermediate negative
> > > >                                      nr_items then total_objects
> > > >                                      may return 0 conincidently
> > > >
> > > >                                      keep the bit cleared
> > > >     dst->nr_items != 0
> > > >     skip set_bit
> > > >     add scr->nr_item to dst
> > > >
> > > > After this point dst->nr_item may never go zero, so reparenting will not
> > > > set shrinker_map bit anymore.  And since there is no task under user
> > > > slice directly, so no new object will be added to its lru to set the
> > > > shrinker map bit either.  That bit is kept cleared forever.
> > > >
> > > > How does list_lru_del() race with reparenting?  It is because
> > > > reparenting replaces childen's kmemcg_id to parent's without protecting
> > > > from nlru->lock, so list_lru_del() may see parent's kmemcg_id but
> > > > actually deleting items from child's lru, but dec'ing parent's nr_items,
> > > > so the parent's nr_items may go negative as commit
> > > > 2788cf0c401c268b4819c5407493a8769b7007aa ("memcg: reparent list_lrus and
> > > > free kmemcg_id on css offline") says.
>
> Also note that since the introduction of the slab reparenting, list_lru_from_kmem()
> can return the parent lru.

Do you mean slab charge reparenting or lru reparenting? I think
list_lru_from_kmem() can return the parent lru since lru reparenting.

>
> > > >
> > > > Can we move kmemcg_id replacement after reparenting?  No, because the
> > > > race with list_lru_del() may result in negative src->nr_items, but it
> > > > will never be fixed.  So the shrinker may never return SHRINK_EMPTY then
> > > > keep the shrinker map bit set always.  The shrinker will be always
> > > > called for nonsense.
> > > >
> > > > Can we synchronize list_lru_del() and reparenting?  Yes, it could be
> > > > done.  But it seems we need introduce a new lock or use nlru->lock.  But
> > > > it sounds complicated to move kmemcg_id replacement code under nlru->lock.
> > > > And list_lru_del() may be called quite often to exacerbate some hot
> > > > path, i.e. dentry kill.
> > > >
> > > > So, it sounds acceptable to synchronize reading nr_items to avoid seeing
> > > > intermediate negative nr_items given the simplicity and it is typically
> > > > just called by shrinkers when counting the freeable objects.
> > > >
> > > > The patch is tested with some shrinker intensive workloads, no
> > > > noticeable regression is soptted.
> > >
> > > Hi Yang!
> > >
> > > It's really tricky, thank you for digging in! It's a perfect analysis!
> > >
> > > I wonder though, if it's better to just always set the shrinker bit on reparenting
> > > if we do reparent some items? Then we'll avoid adding new synchronization
> > > to the hot path. What do you think?
> >
> > Thanks a lot for the suggestion. I was thinking about the same
> > approach too, but I thought src->nr_items may go zero due to
> > concurrent list_lru_del() at the first place. But I just rethought the
> > whole thing, it seems impossible that dst->nr_items goes negative and
> > src->nr_items goes zero at the same time.
>
> Even if it would be possible, it seems less scary: the next reparenting
> will likely set the bit. So we'll not get into the permanently bad state.

Unfortunately, no. Once the race happens, reparenting won't set the
bit anymore since dst->nr_items won't go zero because the shrinker
will not be called.

>
> > list_lru_del() should just
> > see either dst or src, it can't manipulate both lists simultaneously.
> > So I think your suggestion should work. I will incarnate your
> > suggestion in v2.
> >
> > >
> > > --
> > >
> > > @@ -534,7 +534,6 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> > >         struct list_lru_node *nlru = &lru->node[nid];
> > >         int dst_idx = dst_memcg->kmemcg_id;
> > >         struct list_lru_one *src, *dst;
> > > -       bool set;
> > >
> > >         /*
> > >          * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> > > @@ -546,9 +545,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> > >         dst = list_lru_from_memcg_idx(nlru, dst_idx);
> > >
> > >         list_splice_init(&src->list, &dst->list);
> > > -       set = (!dst->nr_items && src->nr_items);
> > >         dst->nr_items += src->nr_items;
> > > -       if (set)
> > > +       if (src->nr_items)
> > >                 memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> > >         src->nr_items = 0;
> > >
> > >
> > > --
> > >
> > > Btw, it seems that the bug is quite old. I wonder why we haven't seen it before?
> > > Any ideas?
> >
> > It is not new, but not that old from my point of view. The
> > shrinker_map thing was introduced since v4.19, I bet pre-v4.19 kernel
> > may still dominate in production environment. And, it needs some
> > conditions (i.e. nr_inode + nr_dentry == 0 coincidently, and there is
> > not task under dst memcg directly, etc) to trigger, so it seems
> > unlikely to hit.
> >
> > And the consequence may be not noticeable to the most people at all.
> > We happened to see frequent OOMs on a couple of small machines (32G
> > memory w/o swap, but most memory was consumed by anonymous pages)
> > recently and they were already up for long time (almost 300 days),
> > then the investigation leads to this race condition.
>
> I agree that most users will unlikely notice it.
>
> But https://www.spinics.net/lists/cgroups/msg27295.html looks very similar
> and can be caused by the same problem. Once you'll have v2, let's ask
> them to test it too.

Yeah, may be the same root cause.

>
> Thanks!
