Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC96E2B744A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKRCo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKRCo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:44:26 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A575C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:44:25 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id v6so197402vsd.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1baSlx7+AuP0I6rzkrgeQ8LBxCjB7SE8APgJzoq8Tk=;
        b=TTgZMsABcbK/0tR56BhY5Kc3aVCHk2MgelMbWKx9Xwhkr5Frty7saHuiqmPAxqBqh4
         tClJ4m2IgA5rVTAuQyHfe049KsBCpdpoUZ+z7seEZFoCiR/ysG8XYEfemf/IP92tv4RG
         jU2JG55ayurOrn831ogClu8q9WHNpZ6CZCteSQsxNvF4NSDu7mdR4XPgO1YPRfNKYZts
         gliQu/cX/r8+X1HHYae48a84LeUPpoj7e5BBoxeqtQ8SGuRDU8W/gp12c8fO1i3LcKVu
         PFPunEFubjhtDS2uuJeE3m45WK5kIyDYVjgpY7n/iOCCh7MLe8STHz8OEyujXi3Adsht
         fU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1baSlx7+AuP0I6rzkrgeQ8LBxCjB7SE8APgJzoq8Tk=;
        b=e4I81ekIyCSUEgAQtoJPvxggpsPlp4TdqJV9WDo/jwrDtRk6/9PXtMR6k4vXz0FzzY
         t2H86heMwgVHgmDJb3ArntYm4ZJ4sHbU0Hy9wROInSHGycGJZGC0ghsoeB5aCZ/nFnZT
         SICzzuWaWR22UBziCPAUfd/RAQVWyFAEEwO0gZmacuZjLDnSRQ9ODRJpZdNi9A+PHy41
         af0dl0/bP3NX7W/DYdfYvMBWfmYTE8NLxQfpo37GM4NJcDajJnA7bhFvPSRJuZ+k2WP6
         2L7HxTsNFJ1jMpykjxh4J9ksjdcnG11g2yKXDmz4WsmQY2FOW6u4q0WMDL0oCj9T5c+F
         08Jg==
X-Gm-Message-State: AOAM5324YzEo61XDAy4sQaDt6/MygxR4E1qGkhrsWt5jolDQSvPl6vpX
        M0YNGw9+aOnEk2WzQMoGl9+ojbPqaTApwKLOm62DsM83s28=
X-Google-Smtp-Source: ABdhPJxxHA53i+lcdLKff/HqCsW/grer8JkoU730foAB0z0yMxezTLp9BJ0x6IGh+jGWE/i4nmTeGxMsZAFsAcIFFbY=
X-Received: by 2002:a05:6102:3129:: with SMTP id f9mr2009802vsh.26.1605667464406;
 Tue, 17 Nov 2020 18:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20201116220033.1837-1-urezki@gmail.com> <20201116220033.1837-2-urezki@gmail.com>
 <CAC=cRTN77LAn-9-6rGukc2aUZQzx7oP9eKt_hJeb=wbnhGqObQ@mail.gmail.com> <20201117130434.GA10769@pc636>
In-Reply-To: <20201117130434.GA10769@pc636>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Wed, 18 Nov 2020 10:44:13 +0800
Message-ID: <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Huang Ying <ying.huang@intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 9:04 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Tue, Nov 17, 2020 at 10:37:34AM +0800, huang ying wrote:
> > On Tue, Nov 17, 2020 at 6:00 AM Uladzislau Rezki (Sony)
> > <urezki@gmail.com> wrote:
> > >
> > > A current "lazy drain" model suffers from at least two issues.
> > >
> > > First one is related to the unsorted list of vmap areas, thus
> > > in order to identify the [min:max] range of areas to be drained,
> > > it requires a full list scan. What is a time consuming if the
> > > list is too long.
> > >
> > > Second one and as a next step is about merging all fragments
> > > with a free space. What is also a time consuming because it
> > > has to iterate over entire list which holds outstanding lazy
> > > areas.
> > >
> > > See below the "preemptirqsoff" tracer that illustrates a high
> > > latency. It is ~24 676us. Our workloads like audio and video
> > > are effected by such long latency:
> >
> > This seems like a real problem.  But I found there's long latency
> > avoidance mechanism in the loop in __purge_vmap_area_lazy() as
> > follows,
> >
> >         if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> >             cond_resched_lock(&free_vmap_area_lock);
> >
> I have added that "resched threshold" because of on my tests i could
> simply hit out of memory, due to the fact that a drain work is not up
> to speed to process such long outstanding list of vmap areas.

OK.  Now I think I understand the problem.  For free area purging,
there are multiple "producers" but one "consumer", and it lacks enough
mechanism to slow down the "producers" if "consumer" can not catch up.
And your patch tries to resolve the problem via accelerating the
"consumer".
That isn't perfect, but I think we may have quite some opportunities
to merge the free areas, so it should just work.

And I found the long latency avoidance logic in
__purge_vmap_area_lazy() appears problematic,

         if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
             cond_resched_lock(&free_vmap_area_lock);

Shouldn't it be something as follows?

         if (i >= BATCH && atomic_long_read(&vmap_lazy_nr) <
resched_threshold) {
             cond_resched_lock(&free_vmap_area_lock);
             i = 0;
         } else
             i++;

This will accelerate the purging via batching and slow down vmalloc()
via holding free_vmap_area_lock.  If it makes sense, can we try this?

And, can we reduce lazy_max_pages() to control the length of the
purging list?  It could be > 8K if the vmalloc/vfree size is small.

Best Regards,
Huang, Ying
