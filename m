Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFF2CCAD6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgLCAEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgLCAEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:04:21 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D3DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:03:41 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cm17so128964edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HL4ZccAHg5V6Bd07F/4aifaU3FUPzQVBX0asc7HSKow=;
        b=klh/Kg3BizeiBqwvr7+X9DewlNQbIet2xxxofeWSvOolzkU9vrhZeGs19vQNq8tO4w
         SPMgZ8AibuFQ5sfLT1meSGaaOo3jfDzMYoYJU86tumYCS9bJH23Fhu2Mjw8cuqeMq4p/
         D0fR290cz4g2oCt+D+TAFu59j+h6ipOxhWako8EKL5xrcNZqcfevPtFoYRWZPuKTwxf8
         +B2EJKO59foyBuQ98EPeK3kpJY5KEXe40Ty3H6T9l/eR0Du2Nf83UcvRFBtkMeRNPMSr
         Tk0odFOyAi18mvyoixC1dCdJzVYHVnWAmlbFPNvgzrpC90i6AjPAc8HuAbWQz2uXn28B
         Af6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HL4ZccAHg5V6Bd07F/4aifaU3FUPzQVBX0asc7HSKow=;
        b=hWO0BZ3hRHfDNCcaVR4zqyGxYLQRfdvWiav9rAf+/q9uqwfCaC18enYcEnOILwBPmp
         79jUkKSIgpQ7wLp1XF2K6BUDnWBjKkMdkh/MFK+5Y29OawFA48DwAGtQSfdxWEx60h9s
         LVrB5sq5nSbnJpnLE5Y86+xm0PDH4gpCCSRUxEB4P8BLGSvQAmxOPdQtn3O3xtezd+HZ
         +1SzfEpUdrKoE7egYEqTtJiZbVvFr3uMyfUDzDHfoO2Lq+5fDx/TZGWAaExMfYnxCWwH
         hurBmRlN2LQ/qCHf37Jb0Gb7H7QN6i2sa/Npiwf6PhrLcL7xkTJmwWbLYM8VlOIBxj2K
         z7wQ==
X-Gm-Message-State: AOAM531j80yGTo4YIqQ+61VKMIBBK07JJl3igBHLoyAdK0qX2QiOW2v8
        Trw/mWtFGa59oEZmjYBV70o02ZZ7UVX4f7bmKjYG3w==
X-Google-Smtp-Source: ABdhPJydr86sgePFOj6k1Jj0u4GQFzDx78yKdXH78OgTb1z7VSnV/IAzJZVp4n9iByHf4Qtx8nBSIsTJUqBGdWRWyUU=
X-Received: by 2002:aa7:c652:: with SMTP id z18mr490202edr.60.1606953819960;
 Wed, 02 Dec 2020 16:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-4-pasha.tatashin@soleen.com> <20201202163145.GT1161629@iweiny-DESK2.sc.intel.com>
 <20201202163312.GU1161629@iweiny-DESK2.sc.intel.com> <CA+CK2bBhW2hBystEfJyJ77xGNY9LHWLOLNN44E8hSuwO2yNs0Q@mail.gmail.com>
In-Reply-To: <CA+CK2bBhW2hBystEfJyJ77xGNY9LHWLOLNN44E8hSuwO2yNs0Q@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Dec 2020 19:03:04 -0500
Message-ID: <CA+CK2bDPje=3gqUW4rhdZnxhsUUvbo2hx9v0Q5xqMh_NRwaixA@mail.gmail.com>
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

On Wed, Dec 2, 2020 at 1:19 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On Wed, Dec 2, 2020 at 11:33 AM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 08:31:45AM -0800, 'Ira Weiny' wrote:
> > > On Wed, Dec 02, 2020 at 12:23:27AM -0500, Pavel Tatashin wrote:
> > > > __gup_longterm_locked() has CMA || FS_DAX version and a common stub
> > > > version. In the preparation of prohibiting longterm pinning of pages from
> > > > movable zone make the CMA || FS_DAX version common, and delete the stub
> > > > version.
> > > >
> > > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > > > ---
> > > >  mm/gup.c | 13 -------------
> > > >  1 file changed, 13 deletions(-)
> > > >
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index 3a76c005a3e2..0e2de888a8b0 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -1567,7 +1567,6 @@ struct page *get_dump_page(unsigned long addr)
> > > >  }
> > > >  #endif /* CONFIG_ELF_CORE */
> > > >
> > > > -#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
> > > >  #ifdef CONFIG_FS_DAX
> > > >  static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> > > >  {
> > > > @@ -1757,18 +1756,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
> > > >             kfree(vmas_tmp);
> > > >     return rc;
> > > >  }
> > >
> > > Isn't this going to potentially allocate vmas_tmp only to not need it when
> > > !FS_DAX and !CMA?
> >
> > To clarify, when FOLL_LONGTERM is set...
>
> Yes, this is the case. We need that because once migration is checked
> for all allocations, not only CMA, we need vmas_tmp for all cases.

A slight correction, we only need vmas_tmp for check_dax_vmas().
Potentially, we could wrap vmas_tmp allocation in a #ifdef for FS_DAX,
but I do not think this is really needed.

Pasha

>
> Pasha
>
> >
> > IRa
> >
> > >
> > > Ira
> > >
> > > > -#else /* !CONFIG_FS_DAX && !CONFIG_CMA */
> > > > -static __always_inline long __gup_longterm_locked(struct mm_struct *mm,
> > > > -                                             unsigned long start,
> > > > -                                             unsigned long nr_pages,
> > > > -                                             struct page **pages,
> > > > -                                             struct vm_area_struct **vmas,
> > > > -                                             unsigned int flags)
> > > > -{
> > > > -   return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> > > > -                                  NULL, flags);
> > > > -}
> > > > -#endif /* CONFIG_FS_DAX || CONFIG_CMA */
> > > >
> > > >  static bool is_valid_gup_flags(unsigned int gup_flags)
> > > >  {
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > >
