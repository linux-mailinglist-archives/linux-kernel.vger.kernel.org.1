Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8B2D113C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgLGM6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgLGM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:58:21 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F210C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:57:35 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so9859892pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 04:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6NT57stNU0XDGX2I8AiHgmrG8IdQvHx6UdW5r4PrTU=;
        b=ynKCNHc0hoYaubBLO2yot1cMk5pT7ZlOB4fRj7Htb16hVwAmW8M9gY7MDYOXTJ95Mb
         SrG+v40Amfbh0/fUq/cdWLsgjIx9Fjl2t7frw9gYAOHxgcBw5ZASltdxl5jGsphNwYMm
         yZVBFXQYa8FPmhii3kQk31G8hY1Eai+HHbJxW9mTnS4+MfE1cYom490tgrRsNNtwL05+
         SLVFqFAlt+DBWc/iocnNSuFe+y3Iukt+GiQi6pKXhGLUtUhCSTP2UyXB+wpYwAxrO/tP
         h1ycyed2NkO78WuCIjfe7C5hdLFCS9qMFNL4B6dlNSDsClUxbq0ud/F4vMEYuq4UCO4L
         5Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6NT57stNU0XDGX2I8AiHgmrG8IdQvHx6UdW5r4PrTU=;
        b=Kj2bgNYPPwd55ys+94tBOOe/B5+QKnwLgdz4Qf5qo7L75Sxtyyh3Dzr3hSkTopm2Ke
         YDHz52kOaZ/vapz0RN3qUidTg1sIi5IOwlsopDzT2p44YUi00heI9Pj3yivkr/D34mQq
         pQpG2wVGThGPi+TjJ0Vmk4AQv2VCVeMM2ND0trT3VL//nymVC19ZT4FKXqNSxZbjkad3
         F15G9kAmhx1SE1AznKZX+G11N/HE5k5HvNaaQcy5lD9TAOwKwGfoVadNJqzT2CXfw049
         rlxHtXbPkD7RuVougDCKNYZyQm7VfOcRg+/WBC1reFfmcghwTal0nD2NI1WWJxuHLqme
         Sq+Q==
X-Gm-Message-State: AOAM532GRxSeEsLvidBqVL9VV1MZHqLQn0RnUVVM3EktFWYc/JpviO9c
        tMKfnMqgXDo5Yj7+bkrJn2jQdWuoLUlFV3NbUB1OsQ==
X-Google-Smtp-Source: ABdhPJxDduBK16GT+JoiOw4qerDvuVoZO1uD0cVugIWmA5+CwHWZMgSKCcVsK8E8JIhFH40nZdxIwhaVgrAAvNgRcYE=
X-Received: by 2002:a63:1203:: with SMTP id h3mr14738079pgl.273.1607345854770;
 Mon, 07 Dec 2020 04:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20201206085639.12627-1-songmuchun@bytedance.com> <20201207123605.GH25569@dhcp22.suse.cz>
In-Reply-To: <20201207123605.GH25569@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 20:56:58 +0800
Message-ID: <CAMZfGtUhG26cTgbSmg4g+rwOtEFhgbE3QXPR_LUf3FS-s=YbOA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: optimize per-lruvec stats
 counter memory usage
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alexander.h.duyck@linux.intel.com,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 8:36 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sun 06-12-20 16:56:39, Muchun Song wrote:
> > The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> > of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> > to optimize memory usage.
>
> How much savings are we talking about here? I am not deeply familiar
> with the pcp allocator but can it compact smaller data types much
> better?

It is a percpu struct. The size of struct lruvec_stat is 304(tested on the
linux-5.5). So we can save 304 / 2 * nproc bytes per memcg where nproc
is the number of the possible CPU. If we have n memory cgroup in the
system. Finally, we can save (152 * nproc * n) bytes. In some configurations,
nproc here may be 512. And if we have a lot of dying cgroup. The n can be
100, 000 (I once saw it on my server).

It can not be smaller. Because the vmstat threshold is 32, and we have
some vmstat counters whose unit is byte. So the max bytes is 32 * 4k
which is 131072. The s16 can't hold these. Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h | 6 +++++-
> >  mm/memcontrol.c            | 2 +-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f9a496c4eac7..34cf119976b1 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -92,6 +92,10 @@ struct lruvec_stat {
> >       long count[NR_VM_NODE_STAT_ITEMS];
> >  };
> >
> > +struct per_cpu_lruvec_stat {
> > +     s32 count[NR_VM_NODE_STAT_ITEMS];
> > +};
> > +
> >  /*
> >   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
> >   * which have elements charged to this memcg.
> > @@ -111,7 +115,7 @@ struct mem_cgroup_per_node {
> >       struct lruvec_stat __percpu *lruvec_stat_local;
> >
> >       /* Subtree VM stats (batched updates) */
> > -     struct lruvec_stat __percpu *lruvec_stat_cpu;
> > +     struct per_cpu_lruvec_stat __percpu *lruvec_stat_cpu;
> >       atomic_long_t           lruvec_stat[NR_VM_NODE_STAT_ITEMS];
> >
> >       unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 49fbcf003bf5..c874ea37b05d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5184,7 +5184,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> >               return 1;
> >       }
> >
> > -     pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
> > +     pn->lruvec_stat_cpu = alloc_percpu_gfp(struct per_cpu_lruvec_stat,
> >                                              GFP_KERNEL_ACCOUNT);
> >       if (!pn->lruvec_stat_cpu) {
> >               free_percpu(pn->lruvec_stat_local);
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
