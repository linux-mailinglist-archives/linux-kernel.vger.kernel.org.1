Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73C22AD9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgKJPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgKJPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:11:42 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F39C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:11:42 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id b17so2451313ljf.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtTDtdN1A1QieMBE7zTey1TZRijKWFHZveMGkD1lWJA=;
        b=RdYCnj4p3/GHmjlXYgI+fjuxnLbOPRM2k2cc427mf+Cb8Rx5+Wc+YYf/tUKRMrw33r
         peCKg1GSLzA8Hfzdidwi1vbFpK9OYBOYnhatO8JHmxB2EH5hYzvWq0xfb74oKywNsyKn
         /te4G05FHpyoLPWsdNiI9jQSTdrPvxLcAX+NSPxQK5uiH9YNIGxyruXsPIHynYdtt/gz
         /PdacBSSZD8ll0Lvn7IrLZM4sYcwdEH+etxLUgai8UpqlEcLKxMiqP41xeP7eoxuhA+x
         4Z7IfjmcRrkqD0L2V+yxI6mf/FrIAAQI1fcg1rg2nAkeVtWOrPiYTvs1U4C719H9PmZ5
         mavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtTDtdN1A1QieMBE7zTey1TZRijKWFHZveMGkD1lWJA=;
        b=AeGaMbONjU8jW7aZyetOJmmrlv/U+8f6YMP2pB0Bkl752N2rxsTlYqBylq8o+fQiYu
         Lf2e4JKwwbkS1C/zM47Xjegcg49xOgrnWm3c95h3mdKX3FMD7tGtVEFiqi/QT14vUVr4
         TSFh80CzYavN++8XghOfT6KoNkIqhYHWoYwQVyJPqPU60BvqrczQg5an2b3CWI+VyBl8
         PBku3rFygfbeFfX3nf/fhNI1jaSo5TyNgpWsTQ1xDhUBDXgUcNVLf19UXgBdvczMgNq5
         x9/K1dgH2I54eeGJqSSmSerH0fUmJB+Bzjt3e26SLmtri691ssFhb119529bEWVd6ZzR
         Bj0A==
X-Gm-Message-State: AOAM533h0+W4cJWKCNULGxizaOkbs0Bu5USGEZE3WmZ7u80c3/zTUhgW
        QctQSyKmhSbfJB/erz7AZckVvKKq5HmLv2hMBYSHKQ==
X-Google-Smtp-Source: ABdhPJygo8HCLqCD23OB9X2E8bEgzq+LGdxTgDaielRw0ydqUsczbCnFnJGXHosXaBbD7zRmxzro84cfH+p2vEPghL8=
X-Received: by 2002:a2e:240e:: with SMTP id k14mr8995534ljk.332.1605021100389;
 Tue, 10 Nov 2020 07:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20201014190749.24607-1-rpalethorpe@suse.com> <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org> <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com> <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com> <20201020181822.GA397401@cmpxchg.org>
 <20201021193322.GA300658@carbon.dhcp.thefacebook.com> <20201023163053.GB535375@cmpxchg.org>
 <20201110012758.GA2612097@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201110012758.GA2612097@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Nov 2020 07:11:28 -0800
Message-ID: <CALvZod7GrYayHjYsqtF2AfcvkbTHCyWQJW4oXoO3fSGJeotDpQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 5:28 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Oct 23, 2020 at 12:30:53PM -0400, Johannes Weiner wrote:
> > On Wed, Oct 21, 2020 at 12:33:22PM -0700, Roman Gushchin wrote:
> > > On Tue, Oct 20, 2020 at 02:18:22PM -0400, Johannes Weiner wrote:
> > > > On Tue, Oct 20, 2020 at 10:07:17AM -0700, Roman Gushchin wrote:
> > > > > If we want these counter to function properly, then we should go into the opposite
> > > > > direction and remove the special handling of the root memory cgroup in many places.
> > > >
> > > > I suspect this is also by far the most robust solution from a code and
> > > > maintenance POV.
> > > >
> > > > I don't recall the page counter at the root level having been a
> > > > concern in recent years, even though it's widely used in production
> > > > environments. It's lockless and cache compact. It's also per-cpu
> > > > batched, which means it isn't actually part of the memcg hotpath.
> > >
> > >
> > > I agree.
> > >
> > > Here is my first attempt. Comments are welcome!
> > >
> > > It doesn't solve the original problem though (use_hierarchy == false and
> > > objcg reparenting), I'll send a separate patch for that.
> > >
> > > Thanks!
> > >
> > > --
> > >
> > > From 9c7d94a3f999447417b02a7100527ce1922bc252 Mon Sep 17 00:00:00 2001
> > > From: Roman Gushchin <guro@fb.com>
> > > Date: Tue, 20 Oct 2020 18:05:43 -0700
> > > Subject: [PATCH RFC] mm: memcontrol: do not treat the root memory cgroup
> > >  specially
> > >
> > > Currently the root memory cgroup is treated in a special way:
> > > it's not charged and uncharged directly (only indirectly with their
> > > descendants), processes belonging to the root memory cgroup are exempt
> > > from the kernel- and the socket memory accounting.
> > >
> > > At the same time some of root level statistics and data are available
> > > to a user:
> > >   - cgroup v2: memory.stat
> > >   - cgroup v1: memory.stat, memory.usage_in_bytes, memory.memsw.usage_in_bytes,
> > >                memory.kmem.usage_in_bytes and memory.kmem.tcp.usage_in_bytes
> > >
> > > Historically the reason for a special treatment was an avoidance
> > > of extra performance cost, however now it's unlikely a good reason:
> > > over years there was a significant improvement in the performance
> > > of the memory cgroup code. Also on a modern system actively using
> > > cgroups (e.g. managed by systemd) there are usually no (significant)
> > > processes in the root memory cgroup.
> > >
> > > The special treatment of the root memory cgroups creates a number of
> > > issues visible to a user:
> > > 1) slab stats on the root level do not include the slab memory
> > >    consumed by processes in the root memory cgroup
> > > 2) non-slab kernel memory consumed by processes in the root memory cgroup
> > >    is not included into memory.kmem.usage_in_bytes
> > > 3) socket memory consumed by processes in the root memory cgroup
> > >    is not included into memory.kmem.tcp.usage_in_bytes
> > >
> > > It complicates the code and increases a risk of new bugs.
> > >
> > > This patch removes a number of exceptions related to the handling of
> > > the root memory cgroup. With this patch applied the root memory cgroup
> > > is treated uniformly to other cgroups in the following cases:
> > > 1) root memory cgroup is charged and uncharged directly, try_charge()
> > >    and cancel_charge() do not return immediately if the root memory
> > >    cgroups is passed. uncharge_batch() and __mem_cgroup_clear_mc()
> > >    do not handle the root memory cgroup specially.
> > > 2) per-memcg slab statistics is gathered for the root memory cgroup
> > > 3) shrinkers infra treats the root memory cgroup as any other memory
> > >    cgroup
> > > 4) non-slab kernel memory accounting doesn't exclude pages allocated
> > >    by processes belonging to the root memory cgroup
> > > 5) if a socket is opened by a process in the root memory cgroup,
> > >    the socket memory is accounted
> > > 6) root cgroup is charged for the used swap memory.
> > >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > This looks great.
> >
> > The try_charge(), cancel_charge() etc. paths are relatively
> > straight-forward and look correct to me.
> >
> > The swap counters too.
> >
> > Slab is a bit trickier, but it also looks correct to me.
> >
> > I'm having some trouble with the shrinkers. Currently, tracked objects
> > allocated in non-root cgroups live in that cgroup. Tracked objects in
> > the root cgroup, as well as untracked objects, live in a global pool.
> > When reclaim iterates all memcgs and calls shrink_slab(), we special
> > case the root_mem_cgroup and redirect to the global pool.
> >
> > After your patch we have tracked objects allocated in the root cgroup
> > actually live in the root cgroup. Removing the shrinker special case
> > is correct in order to shrink those - but it removes the call to
> > shrink the global pool of untracked allocation classes.
> >
> > I think we need to restore the double call to shrink_slab() we had
> > prior to this:
> >
> > commit aeed1d325d429ac9699c4bf62d17156d60905519
> > Author: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Date:   Fri Aug 17 15:48:17 2018 -0700
> >
> >     mm/vmscan.c: generalize shrink_slab() calls in shrink_node()
> >
> >     The patch makes shrink_slab() be called for root_mem_cgroup in the same
> >     way as it's called for the rest of cgroups.  This simplifies the logic
> >     and improves the readability.
> >
> > where we iterate through all cgroups, including the root, to reclaim
> > objects accounted to those respective groups; and then a call to scan
> > the global pool of untracked objects in that numa node.
>
> I agree, thank you for pointing at this commit.
>
> >
> > For ease of review/verification, it could be helpful to split the
> > patch and remove the root exception case-by-case (not callsite by
> > callsite, but e.g. the swap counter, the memory counter etc.).
>
> Sorry for a long pause, here's an update. I've split the patch,
> fixed a couple of issues and was almost ready to send it upstream,
> but then I've noticed that on cgroup v1 kmem and memsw counters
> are sometimes heading into a negative territory and generating a warning
> in dmesg. It happens for a short amount of time at early stages
> of the system uptime. I haven't seen it happening with the memory counter.
>
> My investigation showed that the reason is that the result of a
> cgroup_subsys_on_dfl(memory_cgrp_subsys) call can be misleading at
> early stages. Depending on the return value we charge or skip the kmem
> counter and also handle the swap/memsw counter differently.
>
> The problem is that cgroup_subsys_on_dfl(memory_cgrp_subsys)'s return value
> can change at any particular moment. So I don't see how to make all root's
> counters consistent without tracking them all no matter which cgroup version
> is used. Which is obviously an overkill and will lead to an overhead, which
> unlikely can be justified.
>
> I'll appreciate any ideas, but I don't see a good path forward here
> (except fixing a particular issue with root's slab stats with the
> Muchun's patch).
>

Since the commit 0158115f702b0 ("memcg, kmem: deprecate
kmem.limit_in_bytes"), we are in the process of deprecating the limit
on kmem. If we decide that now is the time to deprecate it, we can
convert the kmem page counter to a memcg stat, update it for both v1
and v2 and serve v1's kmem.usage_in_bytes from that memcg stat. The
memcg stat is more efficient than the page counter, so I don't think
overhead should be an issue. This new memcg stat represents all types
of kmem memory for a memcg like slab, stack and no-type. What do you
think?
