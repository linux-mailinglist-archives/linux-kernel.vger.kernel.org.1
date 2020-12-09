Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19D2D3BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgLIHHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgLIHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:07:08 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 23:06:28 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7so299101pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 23:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkn786HNMnRJCcN2vJ93qEyfsAgh7pkxJtiGF06J3yU=;
        b=JXrRB0nWVA5bEbEvNjxEzu/NNeNa7aKnAuns8JTBIx/sW/F+SxwH6QRAtQ0iiTX8h0
         Pac4yR3jIe7TZKkrxsjkSHBXB2sYr2OJpHc4wBiXDQyKPB3oQF+wkfxiqHFAC5c0jW7g
         yo4V3RXknI3qJ4Zrh7cHk1tdTj2f/wUWuSdQ0Liblz9+qjFB+QluSTdO+wyA/78lMxRC
         4SI1SKgLSphvUkVovLeGAhK4IvUiJWFmOARy7q+vYzadZQLrsrDAK5jLog+gVokidCMh
         31bF/AgWkPzKCdrxRNqlXaWLaA7X84nL2vH4nv0L3kZXAoY4FkkzIMz2vDn4MF3KTUap
         yVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkn786HNMnRJCcN2vJ93qEyfsAgh7pkxJtiGF06J3yU=;
        b=CZE1b8Ib2YbrmsuNAeKxIfDt3s0UOfVKroKAlkoFqnQKfiZDV7xdgvIfSSG2qFYTtC
         uXMSqfZB6WyBJCh9c9JKmEjJgYRUIL54wHZwIFiFybv4t2C/hPVnIEifV4bSrY1G5cDt
         uxihGrBOjuJTCBCA+YAMN4d7kl+sa8NbMFQoRfWTLQNhNHf4dPYdomBoR7EDDaX6JahG
         hfr+RVS2A3wdOsyDhYBFmR+7jc1CmMgEu/NCe4QXXYdBAiyC+PSm4fPg97VmuQumb4v/
         FZOsB3KKtVavSc5Ldzp4zf1Fl3OTobEN9rj+N20vtdTjssXPBDKgbPO8xyHX4c4N+btW
         Wo6w==
X-Gm-Message-State: AOAM533vb+qQmm81QuXng6VVtHRAilTGnVU3o43lBwXHb3P5O1QlUkxV
        WHwAh+SDKKDhRwXlqoG+0jKvzkU/0gl4zz6Tslso+w==
X-Google-Smtp-Source: ABdhPJyqvToolagl8ieU1B5JnTy01mh7I3u/Qdo1C4b/4NaYIk2VlSrMTXjvguF/PaTMidy6INo/h29mnjEw/Azl95c=
X-Received: by 2002:a17:902:bb92:b029:d9:e9bf:b775 with SMTP id
 m18-20020a170902bb92b02900d9e9bfb775mr1108490pls.24.1607497587958; Tue, 08
 Dec 2020 23:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20201208095132.79383-1-songmuchun@bytedance.com>
 <20201209022118.GB2385286@carbon.DHCP.thefacebook.com> <CAMZfGtUMP6mz3DE7DHS55fyto=LZuQpcitt59WuwhZw8m2LqBg@mail.gmail.com>
 <20201209031115.GA2390587@carbon.lan>
In-Reply-To: <20201209031115.GA2390587@carbon.lan>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 15:05:49 +0800
Message-ID: <CAMZfGtVJnZESZQZmPzk=mBqK0KH4L=-s_+ebTr-6Z76zdXXn7g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcontrol: optimize per-lruvec
 stats counter memory usage
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 11:52 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Dec 09, 2020 at 10:31:55AM +0800, Muchun Song wrote:
> > On Wed, Dec 9, 2020 at 10:21 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Dec 08, 2020 at 05:51:32PM +0800, Muchun Song wrote:
> > > > The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> > > > of lruvec_stat_cpu is enough.
>
> Actually the threshold can be as big as MEMCG_CHARGE_BATCH * PAGE_SIZE.
> It still fits into s32, but without explicitly saying it it's hard to
> understand why not choosing s8, as in vmstat.c.

Yeah, here I need to update the commit log.

>
> > > >
> > > > The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
> > > > is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
> > > > bytes per-memcg per-node where ncpu is the number of the possible CPU.
> > > > If there are c memory cgroup (include dying cgroup) and n NUMA node in
> > > > the system. Finally, we can save (152 * ncpu * c * n) bytes.
> > >
> > > Honestly, I'm not convinced.
> > > Say, ncpu = 32, n = 2, c = 500. We're saving <5Mb of memory.
> > > If the machine has 128Gb of RAM, it's .000000003%.
> >
> > Hi Roman,
> >
> > When the cpu hotplug is enabled, the ncpu can be 256 on
> > some configurations. Also, the c can be more large when
> > there are many dying cgroup in the system.
> >
> > So the savings depends on the environment and
> > configurations. Right?
>
> Of course, but machines with more CPUs tend to have more RAM as well.

Here I mean possible CPU not online CPU. The number of possible
CPUs may be greater than online CPUs. The per-cpu allocator is based
on the number of possible CPUs. Right?

Thanks.

>
> Thanks!



-- 
Yours,
Muchun
