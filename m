Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BAE2CC4EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgLBSUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLBSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:20:48 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28647C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:20:08 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id 7so5877417ejm.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUYpkx4ZxrDZ2OB79kEFZcfOtkBumPZVnlZSjd2FA04=;
        b=moUFtLlwZPLByitqRiOIeYwNXMoPlJuxBLz1gnCVGT/YxONaXaQd+HHpDx/usjhUoY
         5HHpRaw/e2q5/kO6PgCS5dRAqptGZ5U1I2bu+XXnqLq32y+RNyUTx++i2S2Lntc2qpXN
         JN7JaprMy+/t7I8bbL2UUkPTfai13m7shfpIidkm6sH5EAH3e/Z1d17i87iLwD6DYTx7
         1g8EM/QoGi5NGaWu9NeezrI81Oi3K5o+9xAotLH2TLk7ZodZ0pzmzf2/OAiuY87cUNbL
         XFeq1wEVUPkRHGFnd95IFbsMUzFuv44vtuMraPj3fgnGHW0EvkmN9wKWM7V5SpbjiEGx
         tumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUYpkx4ZxrDZ2OB79kEFZcfOtkBumPZVnlZSjd2FA04=;
        b=RUb91JdIp8F80LG8xdMEYKSEVm1RvD+ZHTJwxN5C5Yy89PUra/sRCG9TsNTQfkSBkj
         zXt9AouDI4ZEaXUNVsb/aEve29b4xujX0Vzlf52pctG3Gd8vUpSgN8brtNNmy00efiFp
         DIO2VnFpN2QXy2W4rk96hbeReQAdVjtjWOSPcLHL6u6p3sDAejEzJ97e7I7995cNf/m7
         xQo/gH+xs3+m3bq80t0KcXWh0Ah8a+vfFQm+oDWSpq8QxVIatVywoI1iPJtI/gUrX/1p
         cZkq49YP1Pe8EoYsTcuWaz0RwmLjxbLJBeXPvzRquWSStOALHu1x+6z2Ix1V/T64wipi
         U/NA==
X-Gm-Message-State: AOAM531roq+8aPei7S95zaCnRvqBdr/6fy+l8kyAeSWMUQhdJQgaaXP6
        LQGHFxbuSKbWfJvziM/zNktXaU/CczuPWkQUMLVWeg==
X-Google-Smtp-Source: ABdhPJxhoDVGNsxW1twKjz90nP5sCB7siGQ9GxUNs9GysumSl0PZYi8K74h2MRBTmcUieCx3KA1tGAu15948W9zqEMI=
X-Received: by 2002:a17:906:c04d:: with SMTP id bm13mr956901ejb.519.1606933206862;
 Wed, 02 Dec 2020 10:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-4-pasha.tatashin@soleen.com> <20201202163145.GT1161629@iweiny-DESK2.sc.intel.com>
 <20201202163312.GU1161629@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201202163312.GU1161629@iweiny-DESK2.sc.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Dec 2020 13:19:31 -0500
Message-ID: <CA+CK2bBhW2hBystEfJyJ77xGNY9LHWLOLNN44E8hSuwO2yNs0Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm/gup: make __gup_longterm_locked common
To:     Ira Weiny <ira.weiny@intel.com>
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
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:33 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Wed, Dec 02, 2020 at 08:31:45AM -0800, 'Ira Weiny' wrote:
> > On Wed, Dec 02, 2020 at 12:23:27AM -0500, Pavel Tatashin wrote:
> > > __gup_longterm_locked() has CMA || FS_DAX version and a common stub
> > > version. In the preparation of prohibiting longterm pinning of pages from
> > > movable zone make the CMA || FS_DAX version common, and delete the stub
> > > version.
> > >
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  mm/gup.c | 13 -------------
> > >  1 file changed, 13 deletions(-)
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 3a76c005a3e2..0e2de888a8b0 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -1567,7 +1567,6 @@ struct page *get_dump_page(unsigned long addr)
> > >  }
> > >  #endif /* CONFIG_ELF_CORE */
> > >
> > > -#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
> > >  #ifdef CONFIG_FS_DAX
> > >  static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> > >  {
> > > @@ -1757,18 +1756,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
> > >             kfree(vmas_tmp);
> > >     return rc;
> > >  }
> >
> > Isn't this going to potentially allocate vmas_tmp only to not need it when
> > !FS_DAX and !CMA?
>
> To clarify, when FOLL_LONGTERM is set...

Yes, this is the case. We need that because once migration is checked
for all allocations, not only CMA, we need vmas_tmp for all cases.

Pasha

>
> IRa
>
> >
> > Ira
> >
> > > -#else /* !CONFIG_FS_DAX && !CONFIG_CMA */
> > > -static __always_inline long __gup_longterm_locked(struct mm_struct *mm,
> > > -                                             unsigned long start,
> > > -                                             unsigned long nr_pages,
> > > -                                             struct page **pages,
> > > -                                             struct vm_area_struct **vmas,
> > > -                                             unsigned int flags)
> > > -{
> > > -   return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> > > -                                  NULL, flags);
> > > -}
> > > -#endif /* CONFIG_FS_DAX || CONFIG_CMA */
> > >
> > >  static bool is_valid_gup_flags(unsigned int gup_flags)
> > >  {
> > > --
> > > 2.25.1
> > >
> > >
> >
