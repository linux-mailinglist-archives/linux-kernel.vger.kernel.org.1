Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67B62DCE14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgLQJG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgLQJGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:06:24 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17562C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:05:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g20so13955034plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jju/bhtr378BZhL5XC8hlXJ5twNsYnX10+jclSTpAtw=;
        b=oyT19CCeCTvnLuZsgySvYPjdrvjtXQFVUeDBvJPphOXxl/MBFsaAONbs7EtEB9CB16
         Z33x5yEq+NVJZyrcFATL9oI8Lom7xeH8H7nWshGuzMO2DfrQXY/ZWSUv25tcCpoYmUWe
         ZkVeWr5GoxZlMbYI9gRf3oa7luwcmgIo27ljLWVTCs5MDwZfHxpMnDUNGT/+SWzbQ4xw
         pv7FZal9SXndCn9cAd8vDh4MZXHBPCpYMQKqvakbue1/f7ux2VwzBHjilo3x2BfVxIvI
         ks3ZW9TKrwk15fo6SLYheJGUS6QGy0019nm1laQvtbRpmEKZE2V15ZEcolLQc23reoZu
         J8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jju/bhtr378BZhL5XC8hlXJ5twNsYnX10+jclSTpAtw=;
        b=pNOkgLpsCEpF9EmFPlXcEUD7gQIW17qOtyPwSNswJGdsw1E5Pusj2DLTMDhaL2F20C
         Ceanbd4UG/2ej6w2j2Ut9WypzaLWfUtfkoXgeXV0wLBYHzTQaWTLkcwVA62oKApC7l9C
         4iAYixh3iPJTG4au0S2EH6rsy3t9JTgP9EqTCirj9Z0JOHpX8B2GUhpt3ATm5rmo//n/
         ELH6hgEytIX9+2uB9tF6+zLYo3abUV3n7uYkA/Hp2Fyy6HBZETOKtrMxmOttPz72cM4x
         /YlETZahmdWhZ+tQ/jo+UFq2ukyWCVwnd0gbwtopmMmI6yjAdG4l7I7TZZp2nV0p+nYr
         JMQw==
X-Gm-Message-State: AOAM531qi7IquS+odxGcsDNVegr45Lh9vaSZP5T7QqpllzDCzgnOuY+V
        p+VhphqOdMYM5PmVr8uDV7uyVNyYG8143hv7K2Ik/g==
X-Google-Smtp-Source: ABdhPJxDpXsIbZNc4x3sr9DJrY0ZC9PGO9w3Eabe2wNgO5QhVcnZ9m9fZAKWqgGcx69r2FmoF930NeWGyZWQQdyJwZ4=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr7047657pjt.147.1608195943608;
 Thu, 17 Dec 2020 01:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-4-songmuchun@bytedance.com> <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
 <20201216222549.GC3207@localhost.localdomain> <49f6a0f1-c6fa-4642-2db0-69f090e8a392@oracle.com>
 <CAMZfGtXwU7LcTZw7iKFNksVTYx8Bhd=9Nct+zfNy_ibuFiF6ew@mail.gmail.com>
In-Reply-To: <CAMZfGtXwU7LcTZw7iKFNksVTYx8Bhd=9Nct+zfNy_ibuFiF6ew@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 17:05:07 +0800
Message-ID: <CAMZfGtU4QRXp_ufJX_XZzbANbhLO1sdGvDEe+ugTg7WfVc-VYA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 2:54 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Dec 17, 2020 at 6:52 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 12/16/20 2:25 PM, Oscar Salvador wrote:
> > > On Wed, Dec 16, 2020 at 02:08:30PM -0800, Mike Kravetz wrote:
> > >>> + * vmemmap_rmap_walk - walk vmemmap page table
> > >>> +
> > >>> +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> > >>> +                         unsigned long end, struct vmemmap_rmap_walk *walk)
> > >>> +{
> > >>> +   pte_t *pte;
> > >>> +
> > >>> +   pte = pte_offset_kernel(pmd, addr);
> > >>> +   do {
> > >>> +           BUG_ON(pte_none(*pte));
> > >>> +
> > >>> +           if (!walk->reuse)
> > >>> +                   walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
> > >>
> > >> It may be just me, but I don't like the pte[-1] here.  It certainly does work
> > >> as designed because we want to remap all pages in the range to the page before
> > >> the range (at offset -1).  But, we do not really validate this 'reuse' page.
> > >> There is the BUG_ON(pte_none(*pte)) as a sanity check, but we do nothing similar
> > >> for pte[-1].  Based on the usage for HugeTLB pages, we can be confident that
> > >> pte[-1] is actually a pte.  In discussions with Oscar, you mentioned another
> > >> possible use for these routines.
> > >
> > > Without giving it much of a thought, I guess we could duplicate the
> > > BUG_ON for the pte outside the loop, and add a new one for pte[-1].
> > > Also, since walk->reuse seems to not change once it is set, we can take
> > > it outside the loop? e.g:
> > >
> > >       pte *pte;
> > >
> > >       pte = pte_offset_kernel(pmd, addr);
> > >       BUG_ON(pte_none(*pte));
> > >       BUG_ON(pte_none(pte[VMEMMAP_TAIL_PAGE_REUSE]));
> > >       walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
> > >       do {
> > >               ....
> > >       } while...
> > >
> > > Or I am not sure whether we want to keep it inside the loop in case
> > > future cases change walk->reuse during the operation.
> > > But to be honest, I do not think it is realistic of all future possible
> > > uses of this, so I would rather keep it simple for now.
> >
> > I was thinking about possibly passing the 'reuse' address as another parameter
> > to vmemmap_remap_reuse().  We could add this addr to the vmemmap_rmap_walk
> > struct and set walk->reuse when we get to the pte for that address.  Of
> > course this would imply that the addr would need to be part of the range.
>
> Maybe adding another one parameter is unnecessary.  How about doing
> this in the vmemmap_remap_reuse?
>
> The 'reuse' address just is start + PAGE_SIZE.
>
> void vmemmap_remap_free(unsigned long start, unsigned long size)
> {
>          unsigned long end = start + size;
>          unsigned long reuse_addr = start + PAGE_SIZE;
                                           ^^^
                                        Here is "-"
Sorry.

>          LIST_HEAD(vmemmap_pages);
>
>          struct vmemmap_remap_walk walk = {
>                   .remap_pte = vmemmap_remap_pte,
>                   .vmemmap_pages = &vmemmap_pages,
>                   .reuse_addr = reuse_addr.
>          };
>
> }
>
> >
> > Ideally, we would walk the page table to get to the reuse page.  My concern
> > was not explicitly about adding the BUG_ON.  In more general use, *pte could
> > be the first entry on a pte page.  And, then pte[-1] may not even be a pte.
> >
> > Again, I don't think this matters for the current HugeTLB use case.  Just a
> > little concerned if code is put to use for other purposes.
> > --
> > Mike Kravetz
>
>
>
> --
> Yours,
> Muchun



-- 
Yours,
Muchun
