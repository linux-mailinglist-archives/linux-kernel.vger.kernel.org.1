Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB202CCD5F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgLCDiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLCDiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:38:12 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAAC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 19:37:31 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so531750pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 19:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0xr/gzJjOZ5SODRA3FMIk6kL0F9ClCll/zV7XChFAo=;
        b=HY2GSLdnb+9L/xS5afBWxuK06/8OF0WB8Qry7TbjprPX+g82CLCtaIoansVJ6iP/yN
         Ly853xzIqhMgFPVTtOfOjPyHjCOa3hhkpMiX9/Y3F4EK5nr+t+i9vozAlDJK6uoQ4ELH
         GVgnmB8YgiD51Z9qYxSouucBkt/rlpBxAybh8vXXH+gQPOsW427MFn2gxo//2sqJyGsK
         +RkVDzianrbJxsJfoftjDclsHuCEuD+V4NV3Y/6K4/uCf3QRW1a0qYyIoSon6l/IzlCy
         l8jan0Jx2lIH02lSY+cnqeHhz/64Y1MUpjYQG/8CBH9U77Ru5hcIKjKApgRNH5xZY5ec
         L2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0xr/gzJjOZ5SODRA3FMIk6kL0F9ClCll/zV7XChFAo=;
        b=oBUvoshW2xAIeAgzmdMdbrJnDLiGm0BbMyQwRzD7OrqVNti9YchbKzWEy1R/l9EtqG
         vKb1jQ+EJA6HX71HECR5LswnL00mb57JwIB/3nQgA/ANgF6qh0tD+C1B8Ps0edtDWehM
         T9VPm+ONPX07Rx9DBijPSKpuxxQfcNxJNCZXzlerKCBl34tNWPZyUa1JbmykBY5LqwCG
         uN4uGoNUMgL5j30xZU9nPzl0dIFEO0pF/VWp92cqpNzIacB5sUiiiTp1PGC073zp2Ctp
         bESALx16e5EfpK6VhJAai0GJn3+W9qbVBEynX0T375bO+qsYDjRWXUZNEYpUJXve0446
         4ivw==
X-Gm-Message-State: AOAM531Gc+LoNasscqGZ7p7DpyqoW3oaqmWfkgj9Ld70xBip+dkfdqjc
        mmTTwEXeyGr4WhY9HLutv2iEbzzSo1020AAcGNCk7A==
X-Google-Smtp-Source: ABdhPJz3faoAVseY/IdtEUhGbr3UHiCxbeFjTsQ9mGrZYO95xXKjwSHdndVR49F8o3DvOqYgNRe2bLhirgEKKFAJVHo=
X-Received: by 2002:a63:ff18:: with SMTP id k24mr1286059pgi.273.1606966651315;
 Wed, 02 Dec 2020 19:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202121434.75099-1-songmuchun@bytedance.com>
 <20201202211646.GA1517142@carbon.lan> <CAMZfGtWUWAO8J6iBpQLV0T8xPAuQvFTfX9UQ7G2eM_O9C7w83w@mail.gmail.com>
 <20201203032052.GA1568874@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201203032052.GA1568874@carbon.DHCP.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 3 Dec 2020 11:36:54 +0800
Message-ID: <CAMZfGtUY11=2tna7gOv+LH5-=ossA+BPrLrC09odTw=qd3RJQg@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 11:21 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Dec 03, 2020 at 10:53:33AM +0800, Muchun Song wrote:
> > On Thu, Dec 3, 2020 at 5:16 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Dec 02, 2020 at 08:14:34PM +0800, Muchun Song wrote:
> > > > Although the ratio of the slab is one, we also should read the ratio
> > > > from the related memory_stats instead of hard-coding. And the local
> > > > variable of size is already the value of slab_unreclaimable. So we
> > > > do not need to read again. Simplify the code here.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  mm/memcontrol.c | 22 +++++++++++++++++-----
> > > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > >
> > > Hi Muchun!
> > >
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 9922f1510956..03a9c64560f6 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -1545,12 +1545,22 @@ static int __init memory_stats_init(void)
> > > >       int i;
> > > >
> > > >       for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
> > > > +             switch (memory_stats[i].idx) {
> > > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > -             if (memory_stats[i].idx == NR_ANON_THPS ||
> > > > -                 memory_stats[i].idx == NR_FILE_THPS ||
> > > > -                 memory_stats[i].idx == NR_SHMEM_THPS)
> > > > +             case NR_ANON_THPS:
> > > > +             case NR_FILE_THPS:
> > > > +             case NR_SHMEM_THPS:
> > > >                       memory_stats[i].ratio = HPAGE_PMD_SIZE;
> > > > +                     break;
> > > >  #endif
> > > > +             case NR_SLAB_UNRECLAIMABLE_B:
> > > > +                     VM_BUG_ON(i < 1);
> > > > +                     VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);
> > >
> > > Please, convert these to BUILD_BUG_ON(), they don't have to be runtime checks.
> >
> > Agree. But here we cannot use BUILD_BUG_ON(). The compiler will
> > complain about it.
>
> We can!
>
> We just need to change the condition. All we really need to check is that
> NR_SLAB_UNRECLAIMABLE_B immediately following NR_SLAB_RECLAIMABLE_B.

But I think that we need to check that memory_stats[i] immediately following
memory_stats[j] where i is the index of NR_SLAB_UNRECLAIMABLE_B and
j is the index of NR_SLAB_RECLAIMABLE_B.

>
> Something like BUILD_BUG_ON(NR_SLAB_UNRECLAIMABLE_B != NR_SLAB_RECLAIMABLE_B + 1)

So this cannot work. Thanks.

> should work (completely untested).

>
> >
> > >
> > >
> > > > +                     break;
> > > > +             default:
> > > > +                     break;
> > > > +             }
> > > > +
> > > >               VM_BUG_ON(!memory_stats[i].ratio);
> > > >               VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
> > > >       }
> > > > @@ -1587,8 +1597,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> > > >               seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
> > > >
> > >
> > > Can you, please, add a small comment here stating that we're printing
> > > unreclaimable, reclaimable and the sum of both? It will simplify the reading of the code.
> >
> > Will do.
>
> Thank you!



-- 
Yours,
Muchun
