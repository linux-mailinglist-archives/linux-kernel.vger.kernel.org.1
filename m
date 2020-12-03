Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BBC2CCCE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgLCCy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgLCCy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:54:56 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1F2C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 18:54:10 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7so1355420pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 18:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDcWWcWtZ2CIT3OcyxlFsQ8cIBNK++QYLLtJ9vIR6kA=;
        b=sDSPa8a747MqIOZ3kxtOh3eGCz6jS+hENFwV7LofZs09YNQAcrvfmOunXFm1AN3MNz
         8qIpEx3Esxeo1AKK3mb9soO9OCpbXBSWyeHgFnOhkYY0yvKmUFXLGjTTByFJ+sewzvsd
         DNIjXqfF7QMMLXx0Q+ISBY6DsryjqzemNv1LEIxt7a1/rMC9LqD0539AzqRZKyX2jjQA
         tB0+wgPGI/SuFEESCOsYdE6zo++XPwYovqBs2tq/nSnzwVIcXTidTqB33Jhunv9+Wubh
         HVHhV8zsjUOOT4c9C/SaEZUBpmV4DM3n7Oye0Xtri3kHVVcu/5ac4U7J2P38HI9ITuPU
         LEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDcWWcWtZ2CIT3OcyxlFsQ8cIBNK++QYLLtJ9vIR6kA=;
        b=LfbW7/yydOyYfyZOuy6OgmVZFcgsdzksO6kRhiohG+4/6nG6DEdpRsHCAjgVl2vb6n
         bVpWtA7w7+Q6EQaOHAG8IAnASfoFJ4Y9fjgHL/F7xdLoa7STZ9yYf5I/YyV4CH/xNgWe
         1f0DnbPf0M2k4qSvxgn9oVBZSPqvYFkLhqQ2QYxoY687c3X4CkPnoDQ0xzfVpY/Mr1al
         +FUJq5zWXdB2MWQXHcEfG/sd3uKbgcpCIR2qmSjQVNYsT6QX+hTihiIPAhhz96uX7AXZ
         70GAX3eMwub5Rjl0NhJv8QvVQA1fni4GfMBbv8Q2YzeTq6i1ChZcF6sd1L3NUGq9G9sG
         7R4A==
X-Gm-Message-State: AOAM530l09oglc2C2xzPW0yfC2Q3QlpgMudxI5WGjog9Q/QdiXS7sq0g
        2SGxgJJiZqWRSpp7er30TtCUVdnPO61JPwmhzmfQLw==
X-Google-Smtp-Source: ABdhPJzbn6ILlMeH2YCPHyVeHEwZs+Ygkrr5yTMIKPfugRZMa00bTRkTBHV5D83EzuP9SV2sBAF/rx93pjmJOcAxYT4=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr972593pjt.147.1606964050137;
 Wed, 02 Dec 2020 18:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20201202121434.75099-1-songmuchun@bytedance.com> <20201202211646.GA1517142@carbon.lan>
In-Reply-To: <20201202211646.GA1517142@carbon.lan>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 3 Dec 2020 10:53:33 +0800
Message-ID: <CAMZfGtWUWAO8J6iBpQLV0T8xPAuQvFTfX9UQ7G2eM_O9C7w83w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/memcontrol: make the slab calculation consistent
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 5:16 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Dec 02, 2020 at 08:14:34PM +0800, Muchun Song wrote:
> > Although the ratio of the slab is one, we also should read the ratio
> > from the related memory_stats instead of hard-coding. And the local
> > variable of size is already the value of slab_unreclaimable. So we
> > do not need to read again. Simplify the code here.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
>
> Hi Muchun!
>
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 9922f1510956..03a9c64560f6 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1545,12 +1545,22 @@ static int __init memory_stats_init(void)
> >       int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
> > +             switch (memory_stats[i].idx) {
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -             if (memory_stats[i].idx == NR_ANON_THPS ||
> > -                 memory_stats[i].idx == NR_FILE_THPS ||
> > -                 memory_stats[i].idx == NR_SHMEM_THPS)
> > +             case NR_ANON_THPS:
> > +             case NR_FILE_THPS:
> > +             case NR_SHMEM_THPS:
> >                       memory_stats[i].ratio = HPAGE_PMD_SIZE;
> > +                     break;
> >  #endif
> > +             case NR_SLAB_UNRECLAIMABLE_B:
> > +                     VM_BUG_ON(i < 1);
> > +                     VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);
>
> Please, convert these to BUILD_BUG_ON(), they don't have to be runtime checks.

Agree. But here we cannot use BUILD_BUG_ON(). The compiler will
complain about it.

>
>
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +
> >               VM_BUG_ON(!memory_stats[i].ratio);
> >               VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
> >       }
> > @@ -1587,8 +1597,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> >               seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
> >
>
> Can you, please, add a small comment here stating that we're printing
> unreclaimable, reclaimable and the sum of both? It will simplify the reading of the code.

Will do.

>
> >               if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
> > -                     size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> > -                            memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> > +                     int idx = i - 1;
> > +
> > +                     size += memcg_page_state(memcg, memory_stats[idx].idx) *
> > +                             memory_stats[idx].ratio;
> >                       seq_buf_printf(&s, "slab %llu\n", size);
> >               }
> >       }
>
> Otherwise the patch looks good to me! Please, feel free to add
> Acked-by: Roman Gushchin <guro@fb.com>
> after addressing my comments.
>
> Thanks!
> > --
> > 2.11.0
> >



-- 
Yours,
Muchun
