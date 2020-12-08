Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A302D2102
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgLHCl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgLHCl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:41:56 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18DC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 18:41:15 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id v3so6183795plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFKMN3Lenb+VaK77PoP0Px7plQtnVT6Nsw8KoPED3Ds=;
        b=GviSs/sA7OMEyX9L7NulKkRHF51iOhb+ZP4MiSlV1zDEy8K/VWZmn2GDoe/e707lyo
         Iy8K9sU893iw2hRgcNB3I9mrFRrravJar1qHdHTb+fwqrJ//DCb/i4CQxipeX20P2rL6
         2mD8H3AsfNbkIwC/00SSaSb/mR1FTAW3UpQ6y2FtTC30CsX+Kx8125GqWvt6Wkpf7EI8
         cLEr56nouqszr5E0aWMfnM5T/qdSd6XjO/WZI+/SQHHgiMsEvlmUolXN3YOIvDiXOMiO
         ApD3AX07skTKA+RyADmmrxjd019fpFTfGJEfUl6anx/E6qfFggm+FLko4uTWrFgG3eby
         mYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFKMN3Lenb+VaK77PoP0Px7plQtnVT6Nsw8KoPED3Ds=;
        b=qp8MVgIy0z+9qmSgZ9XfSlUpL5s7deFWX//KALASOjIvzF6bGWOT75NfPUKQL9TAwb
         psSK4nFOCjTvR76tnOZdB+x/bMF0WG/M4abGCbM+VVzcsN5ksVLsep+IzKIgDN0T0ZCS
         +CE4PGWqUisYnez4TjgYf6VZaqZntKqbgd4hWOfG021LKhRquDRJ0yclEVe9PXVvdHuv
         Jz/XLtTo9qhVXVKRPpuyr5dQGtQShrUPvMhWR1B7Tah0Hx55eJkiK8jxPGlnwhuCgfGF
         dGN/dkUiV9/JLHLtW89qRaSCdkWpBFbNi9E54cak1aWMN9fnWvbvD+URvAHnYcHgZC5S
         px3w==
X-Gm-Message-State: AOAM533DAtp0RmUZzUOossD4w4t41t0Fiy6Mood0RABZAlAOgWDPDldh
        uT4S1Pb4avbvhn6nzGHl4zulLj3Ie4OjWRQUglKKag==
X-Google-Smtp-Source: ABdhPJyW0aZTSOOLlbmbXWbngFtXa+woAAz2hOOzBNhuINR6CavZVPHFEJJO+nQyckR2TB3E46z41lVptmbzsWTdXj8=
X-Received: by 2002:a17:902:bb92:b029:d9:e9bf:b775 with SMTP id
 m18-20020a170902bb92b02900d9e9bfb775mr19295660pls.24.1607395275316; Mon, 07
 Dec 2020 18:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201207130018.GJ25569@dhcp22.suse.cz> <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com>
 <20201207150254.GL25569@dhcp22.suse.cz>
In-Reply-To: <20201207150254.GL25569@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Dec 2020 10:40:39 +0800
Message-ID: <CAMZfGtW8FMmNh0pEXJr2KVGPFD-VVWYSJoc_r3h7C+DxJGArdA@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH v2 00/12] Convert all vmstat
 counters to pages or bytes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 11:02 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 07-12-20 22:52:30, Muchun Song wrote:
> > On Mon, Dec 7, 2020 at 9:00 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Sun 06-12-20 18:14:39, Muchun Song wrote:
> > > > Hi,
> > > >
> > > > This patch series is aimed to convert all THP vmstat counters to pages
> > > > and some KiB vmstat counters to bytes.
> > > >
> > > > The unit of some vmstat counters are pages, some are bytes, some are
> > > > HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
> > > > counters to the userspace, we have to know the unit of the vmstat counters
> > > > is which one. It makes the code complex. Because there are too many choices,
> > > > the probability of making a mistake will be greater.
> > > >
> > > > For example, the below is some bug fix:
> > > >   - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
> > > >   - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")
> > > >
> > > > This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
> > > > And make the unit of the vmstat counters are either pages or bytes. Fewer choices
> > > > means lower probability of making mistakes :).
> > > >
> > > > This was inspired by Johannes and Roman. Thanks to them.
> > >
> > > It would be really great if you could summarize the current and after
> > > the patch state so that exceptions are clear and easier to review. The
> >
> > Agree. Will do in the next version. Thanks.
> >
> >
> > > existing situation is rather convoluted but we have at least units part
> > > of the name so it is not too hard to notice that. Reducing exeptions
> > > sounds nice but I am not really sure it is such an improvement it is
> > > worth a lot of code churn. Especially when it comes to KB vs B. Counting
> >
> > There are two vmstat counters (NR_KERNEL_STACK_KB and
> > NR_KERNEL_SCS_KB) whose units are KB. If we do this, all
> > vmstat counter units are either pages or bytes in the end. When
> > we expose those counters to userspace, it can be easy. You can
> > reference to:
> >
> >     [RESEND PATCH v2 11/12] mm: memcontrol: make the slab calculation consistent
> >
> > From this point of view, I think that it is worth doing this. Right?
>
> Well, unless I am missing something, we have two counters in bytes, two
> in kB, both clearly distinguishable by the B/KB suffix. Changing KB to B
> will certainly reduce the different classes of units, no question about
> that, but I am not really sure this is worth all the code churn. Maybe
> others will think otherwise.
>
> As I've said the THP accounting change makes more sense to me because it
> allows future changes which are already undergoing so there is more
> merit in those.

OK, will delete the convert of KB to B. Thanks.

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
