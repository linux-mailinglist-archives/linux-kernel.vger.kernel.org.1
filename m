Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9295C2BA636
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgKTJbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgKTJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:31:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:31:10 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id j19so6809530pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOtWTRWUacCV4afBAmB0uz1HPtJWEPOQW4mb7oZY5Lc=;
        b=sqBBFahKA/fWvvT6v0hWx9OTS0y3W0Pch9RhXjiAujkFb2wZDebmdh4H/dIgkQwMdh
         zjXM/S8s20+UeBMZEUO+imZ9K18Bhz3HIMh4eoe274VbCtgQNRPcDlwBcFh6xNbsx9NM
         rq/M0ZAqb/GbPrcvxM58dkKlX+EGOmCxGvjZ/Koljpog8ws+9Nez4m2crpKLLDhmpP+E
         atZGgxJQxbC+ZcBg+cA3vzOCyb+GITC7PEf65rliKp6AJHBFwEME7x/syO0uxKc7r+jZ
         P6vpz7oB5n0o8O9XPwlKNDlq9F0o7ve1MCE+UblxrBROFhlmkW4aYBxAQ0zWmQ7XUVyV
         /LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOtWTRWUacCV4afBAmB0uz1HPtJWEPOQW4mb7oZY5Lc=;
        b=jH7fV8XEa/Xly3uNYD6jlYmvvu6PKAO9uv8UPKUUffjSSCjxIm+OvBtObJ09qLcJjW
         nxLLxkU7fpf5pO7X3J5BXUpwd9EXUhVfjMLwVPteIpDDdZIq/BycZ/LcCifZuGPhnzm0
         pjF0WfTnLjCgigru7V8vmcWWlhx62tieWpk/37s/ccdstvhqFnpE1rR0Rc27Jg6IU6/h
         5NPERR3B27E0RQvNRE7IcYo0qAO4VlzS8QpL4OP2zZ0XzrR8zm1akukJ64NB2/RBe4WZ
         GPhYn6SL4maJo/bD5PLGV/GgAH9nR6m4SWZ4bxaKI0xaei+QIg8lucanIlgeLTrzYMKR
         hmcg==
X-Gm-Message-State: AOAM532KIkcSZ/yu5lbzSK4iXWk4ZlR3qmNLX+nxB0C1VHSjcYBVxrJ+
        zR0dUIjDg4USeQROcj2TWyNp0sVqnxvo8aLwrG/veA==
X-Google-Smtp-Source: ABdhPJzUrWQJPe2coyaCpG5TNvaEojKLO8WAH7jZ5NPrvrro/woXmv5lXw0Cz4SHGWe1FgYGyudNgCWSGaUyxNltC3g=
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr9514004pjb.229.1605864670167;
 Fri, 20 Nov 2020 01:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-14-songmuchun@bytedance.com> <20201120081638.GD3200@dhcp22.suse.cz>
In-Reply-To: <20201120081638.GD3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 17:30:27 +0800
Message-ID: <CAMZfGtX3DUJggAzz_06Z2atHPknkCir6a49a983TsWOHt5ZQUQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 13/21] mm/hugetlb: Use PG_slab to
 indicate split pmd
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:16 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 14:43:17, Muchun Song wrote:
> > When we allocate hugetlb page from buddy, we may need split huge pmd
> > to pte. When we free the hugetlb page, we can merge pte to pmd. So
> > we need to distinguish whether the previous pmd has been split. The
> > page table is not allocated from slab. So we can reuse the PG_slab
> > to indicate that the pmd has been split.
>
> PageSlab is used outside of the slab allocator proper and that code
> might get confused by this AFAICS.

I got your concerns. Maybe we can use PG_private instead of the
PG_slab.

>
> From the above description it is not really clear why this is needed
> though. Who is supposed to use this? Say you are allocating a fresh
> hugetlb page. Once you have it, nobody else can be interfering. It is
> exclusive to the caller. The later machinery can check the vmemmap page
> tables to find out whether a split is needed or not. Or do I miss
> something?

Yeah, the commit log needs some improvement. The vmemmap pages
can use huge page mapping or basepage(e.g. 4KB) mapping. These two
cases may exist at the same time. I want to know which page size the
vmemmap pages mapping to. If we have split a PMD page table then
we set the flag, when we free the HugeTLB and the flag is set, we want
to merge the PTE page table to PMD. If the flag is not set, we do nothing
about the PTE page table.

Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb_vmemmap.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 06e2b8a7b7c8..e2ddc73ce25f 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -293,6 +293,25 @@ static void remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
> >       flush_tlb_kernel_range(start, end);
> >  }
> >
> > +static inline bool pmd_split(pmd_t *pmd)
> > +{
> > +     return PageSlab(pmd_page(*pmd));
> > +}
> > +
> > +static inline void set_pmd_split(pmd_t *pmd)
> > +{
> > +     /*
> > +      * We should not use slab for page table allocation. So we can set
> > +      * PG_slab to indicate that the pmd has been split.
> > +      */
> > +     __SetPageSlab(pmd_page(*pmd));
> > +}
> > +
> > +static inline void clear_pmd_split(pmd_t *pmd)
> > +{
> > +     __ClearPageSlab(pmd_page(*pmd));
> > +}
> > +
> >  static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
> >                                         unsigned long start,
> >                                         unsigned long end,
> > @@ -357,11 +376,12 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> >       ptl = vmemmap_pmd_lock(pmd);
> >       remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &remap_pages,
> >                                   __remap_huge_page_pte_vmemmap);
> > -     if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
> > +     if (!freed_vmemmap_hpage_dec(pmd_page(*pmd)) && pmd_split(pmd)) {
> >               /*
> >                * Todo:
> >                * Merge pte to huge pmd if it has ever been split.
> >                */
> > +             clear_pmd_split(pmd);
> >       }
> >       spin_unlock(ptl);
> >  }
> > @@ -443,8 +463,10 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> >       BUG_ON(!pmd);
> >
> >       ptl = vmemmap_pmd_lock(pmd);
> > -     if (vmemmap_pmd_huge(pmd))
> > +     if (vmemmap_pmd_huge(pmd)) {
> >               split_vmemmap_huge_page(head, pmd);
> > +             set_pmd_split(pmd);
> > +     }
> >
> >       remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
> >                                   __free_huge_page_pte_vmemmap);
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
