Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F732D8088
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395183AbgLKVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391366AbgLKVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:10:19 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78149C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:09:39 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v22so10793090edt.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ao7xOAmYaX/ywGJg0iG/Mh6Kx1f1ZcL87diFd+Y1lgA=;
        b=aAfGSlEUgcDLpXRNkXIwp3DHZUaleYjADDcGxmniPbgCxhcNtqJwGP/McXAsdM/BAJ
         m9xejVVYuVGT+X0oCTQc5OkBSfq4uYXO1r0vnIGX6iznyDLybhsStAqQ8nE+VTYvT41/
         Q4AzJl/Rj5EBBtSby6Bvg346cED2t0FBYmJ1URTPm8E51HEVUW0ZlkLZ5mCMQ2HSZucZ
         nEm1DGQ0qOiATOM2Oc5DpmESg938oYmpTdtoJ8KTNWhi2qVmXaFEWcaFR8F4hLAn+D81
         B7LILJrvJvcZF/0nUbkByJepMPWl2TJXBXZ0L76aSvoQ0s31nM2o5dO4av6j9PkDHbjK
         YybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ao7xOAmYaX/ywGJg0iG/Mh6Kx1f1ZcL87diFd+Y1lgA=;
        b=Je8kcDBQeEZC1869h2SMMbCeh3t1OXEgtPIzgruTgVe+JAxNCcYIrTH89zeRGqZ9SL
         5bX2kr/bI7arnDnIuD8F4gV4PzNDvABh3XJLWAcT8/f3fx1yjyl3XfHanxG6q0qT7zjk
         EVcFxYRphDHu3UBamEb8poR/WPEl39YjYUeP3YoJ/VIibQ+L2x3CYmekSf2qbIB+wZyg
         vQHCk0Xg1VP2Non/oX9FKXIu+XbENcU4JfDwBnmaKH30vMlGvo1snZfU59rb0DzeU47f
         m8YWt3myif1/W+wVK57c47R38iVkZxq/2EjU5Bz0AZ0zc1dQzLZevHZNcG4jGYKXdjFe
         RjvA==
X-Gm-Message-State: AOAM5330cjikJJbVBw9SyOCFyKrs4qniM3m3gLwZsbqL9NmYz1En7GOB
        WJbd+bR7jlTvp7v9YmsUO1kXR+I0UpXMgFjg4Yeo3w==
X-Google-Smtp-Source: ABdhPJwlIqvueU3MoneKnbIXloAwNr6Ag2h5LtdJXzZ0BBDjWxTCUfq7+QMT89nt5UYSontzpxc+l3g5STb19Q+QkAU=
X-Received: by 2002:a50:f404:: with SMTP id r4mr975568edm.62.1607720978232;
 Fri, 11 Dec 2020 13:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-6-pasha.tatashin@soleen.com> <20201211202354.GA2225686@ziepe.ca>
 <CA+CK2bDPR8vH+H6cqBn=RTXRCp5kv3ExNPD8DHB09vVWLc3YmA@mail.gmail.com> <20201211204600.GD5487@ziepe.ca>
In-Reply-To: <20201211204600.GD5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 11 Dec 2020 16:09:02 -0500
Message-ID: <CA+CK2bC6u4wnHX53ZhfPtQBLTDbD3t4V9Zuhj=HwD3gEyL4Puw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 3:46 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Dec 11, 2020 at 03:40:57PM -0500, Pavel Tatashin wrote:
> > On Fri, Dec 11, 2020 at 3:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Fri, Dec 11, 2020 at 03:21:39PM -0500, Pavel Tatashin wrote:
> > > > @@ -1593,7 +1592,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> > > >                               }
> > > >
> > > >                               if (!isolate_lru_page(head)) {
> > > > -                                     list_add_tail(&head->lru, &cma_page_list);
> > > > +                                     list_add_tail(&head->lru, &movable_page_list);
> > > >                                       mod_node_page_state(page_pgdat(head),
> > > >                                                           NR_ISOLATED_ANON +
> > > >                                                           page_is_file_lru(head),
> > > > @@ -1605,7 +1604,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> > > >               i += step;
> > > >       }
> > > >
> > > > -     if (!list_empty(&cma_page_list)) {
> > > > +     if (!list_empty(&movable_page_list)) {
> > >
> > > You didn't answer my earlier question, is it OK that ZONE_MOVABLE
> > > pages leak out here if ioslate_lru_page() fails but the
> > > moval_page_list is empty?
> > >
> > > I think the answer is no, right?
> > In my opinion it is OK. We are doing our best to not pin movable
> > pages, but if isolate_lru_page() fails because pages are currently
> > locked by someone else, we will end up long-term pinning them.
> > See comment in this patch:
> > +        * 1. Pinned pages: (long-term) pinning of movable pages is avoided
> > +        *    when pages are pinned and faulted, but it is still possible that
> > +        *    address space already has pages in ZONE_MOVABLE at the time when
> > +        *    pages are pinned (i.e. user has touches that memory before
> > +        *    pinning). In such case we try to migrate them to a different zone,
> > +        *    but if migration fails the pages can still end-up pinned in
> > +        *    ZONE_MOVABLE. In such case, memory offlining might retry a long
> > +        *    time and will only succeed once user application unpins pages.
>
> It is not "retry a long time" it is "might never complete" because
> userspace will hold the DMA pin indefinitely.
>
> Confused what the point of all this is then ??
>
> I thought to goal here is to make memory unplug reliable, if you leave
> a hole like this then any hostile userspace can block it forever.

You are right, I used a wording from the previous comment, and it
should be made clear that pin may be forever. Without these patches it
is guaranteed that hot-remove will fail if there are pinned pages as
ZONE_MOVABLE is actually the first to be searched. Now, it will fail
only due to exceptions listed in ZONE_MOVABLE comment:

1. pin + migration/isolation failure
2. memblock allocation due to limited amount of space for kernelcore
3. memory holes
4. hwpoison
5. Unmovable PG_offline pages (? need to study why this is a scenario).

Do you think we should unconditionally unpin pages, and return error
when isolation/migration fails?

Pasha

>
> Jason
