Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38802C85B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgK3Nim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgK3Nil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:38:41 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9AC061A04
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:37:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l11so6504850plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qu207Z75WzQUJJHqszmaKTu1R6TkuOOJQys6M2fXiGI=;
        b=QaLy8DKIRP24xFqCy3J7NDtZmBosZopR/eM0EPzGmgqiL6BrMap3ZWoMFxnbvPI0oZ
         lyuue7gFrhq+HJbhK+PaVpJYcMjX2xjGdvwJWE4VUnhv5e1QuFp2A+HXu1/0Ozln17fv
         v/nJ4urZRQDsaUDZytPGxOHVAPc1e+ESjRYfHi3z6zqNV8PVd6xAHJBZCx+3cnr6FY36
         8KNV5aFXjivavZVXkj7wsBpCUODW3Leg/5JHMk4wAjW5tOImUTntas1ZIvt0ZCLwuuZQ
         nWNutIM7vPeebfCo1CR4sUMIqP/EWMkQiYGNf8poGVXt/oFZGPiWIt410Td2tIZGJgr3
         TPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qu207Z75WzQUJJHqszmaKTu1R6TkuOOJQys6M2fXiGI=;
        b=MNd5U9SFT76imcBuup9Ydt6h3fFnZYQ/437cNnr4KYpCID65bx60Sjy8p8miW1pkzx
         W7a45IJMhdjn4BOL4Gf+1keTxI/h65odV9+FAlBWqwRzRryhA/+fCvdP2/OvlaUsJ62j
         tFCWKGZ0FTQU/xr2IIYSAQ5NVI+wqCN7hpQ/HJgygqnVzbEcFj+eAOUE8NlTMWPSmIO9
         l48TwAdlgJ7AIBPyL7SNtal/EPZkLeaSu6QU15O5DgkH2dJRs/GFhE9ivIcJbe3HgWUq
         gGfv36K7ynupVxQMaT5CdFkzvju9s1AphzU1DJWDgBuGrI37Y1JMpVp3eK9YIDySV9iZ
         z/BQ==
X-Gm-Message-State: AOAM530zrJEuy5Xgsp7OUsuLzr4MPjpx7lhfC5dDDWB7MWKzqxpfc8nm
        r9d5qfnzLGwtfyjDPeM7r0YKxRelbUbs5w3b5VpHgw==
X-Google-Smtp-Source: ABdhPJwVDB7YDEhOfM/bzPd9hd6ZDyyAWYZcOmV/hmtcR7dwZqYlZZQQ3yhdDZ/6Cn/n3EceqEJ1cqodHjf5k3zDGEs=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr10957073pjt.147.1606743446276;
 Mon, 30 Nov 2020 05:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20201130131512.6043-1-songmuchun@bytedance.com> <20201130132345.GJ17338@dhcp22.suse.cz>
In-Reply-To: <20201130132345.GJ17338@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 30 Nov 2020 21:36:49 +0800
Message-ID: <CAMZfGtWSLeiNcPYaAnOyv_fy9_rxHn0kA2Vzn=i+B8ngc61_4Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/memcg: fix NULL pointer dereference at workingset_eviction
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alex.shi@linux.alibaba.com, alexander.h.duyck@linux.intel.com,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 9:23 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 30-11-20 21:15:12, Muchun Song wrote:
> > We found a case of kernel panic. The stack trace is as follows
> > (omit some irrelevant information):
> >
> >     BUG: kernel NULL pointer dereference, address: 00000000000000c8
> >     RIP: 0010:workingset_eviction+0x26b/0x450
> >     Call Trace:
> >      __remove_mapping+0x224/0x2b0
> >      shrink_page_list+0x8c2/0x14e0
> >      shrink_inactive_list+0x1bf/0x3f0
> >      ? do_raw_spin_unlock+0x49/0xc0
> >      ? _raw_spin_unlock+0xa/0x20
> >      shrink_lruvec+0x401/0x640
> >
> > This was caused by commit 76761ffa9ea1 ("mm/memcg: bail out early when
> > !memcg in mem_cgroup_lruvec"). When the parameter of memcg is NULL, we
> > should not use the &pgdat->__lruvec. So this just reverts commit
> > 76761ffa9ea1 to fix it.
> >
> > Fixes: 76761ffa9ea1 ("mm/memcg: bail out early when !memcg in mem_cgroup_lruvec")
>
> I do not see any commits like that in the current Linus tree. Is this a
> commit id from the linux-next? If yes, can we just fold it into the
> respective patch in mmotm tree please?

Yes. This commit is on the linux-next tree. Of course can.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f9a496c4eac7..a1416205507c 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -610,17 +610,20 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> >  static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> >                                              struct pglist_data *pgdat)
> >  {
> > +     struct mem_cgroup_per_node *mz;
> >       struct lruvec *lruvec;
> >
> > -     if (mem_cgroup_disabled() || !memcg) {
> > +     if (mem_cgroup_disabled()) {
> >               lruvec = &pgdat->__lruvec;
> > -     } else {
> > -             struct mem_cgroup_per_node *mz;
> > -
> > -             mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> > -             lruvec = &mz->lruvec;
> > +             goto out;
> >       }
> >
> > +     if (!memcg)
> > +             memcg = root_mem_cgroup;
> > +
> > +     mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> > +     lruvec = &mz->lruvec;
> > +out:
> >       /*
> >        * Since a node can be onlined after the mem_cgroup was created,
> >        * we have to be prepared to initialize lruvec->pgdat here;
> > --
> > 2.11.0
> >
>
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
