Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C62F5F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbhANK6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbhANK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:58:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6965C061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:57:57 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a188so3110723pfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cept6yDgxD1Uvrl1z08HyfZGxWF+qA4CuNNCEN/9TzM=;
        b=yiPxKRaazrQJhm62718dy5jL9EaBAIuTRkSQHSomn4R0VBrIU3J6k1Z45mE6OxLQua
         dLFtmeFhBJGfByaRgSLfQ4KRSVykikS+QfdJC9ViPatOCWLJb/I/pn/Erle1WQc/sDT7
         wPATSR+VHZd0wHjPVOWyvJlEFwPzreQbYFXVmZsUoe2yGW4cTZlmgiSOfq8OKs+fzzet
         6d7s09enWsOtGSVjoTAk5vGe6itxuSoIe42v61o9cfQWVlRMHStezspGOEdgqtki2lYS
         UYXD3pjurb2PEvLZlz+OGFVGGPWXpzxTkLbr143otO4TTWwCBeVKsDT3pjQohKjzJqCC
         OFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cept6yDgxD1Uvrl1z08HyfZGxWF+qA4CuNNCEN/9TzM=;
        b=CXuYF7cJqkldo//LKG0HRgIW2yY3Ewl2F9iaNGMWMKwbQ5dW/EJX8IaVGuT8MSkqTM
         eZg8cITUIf2PGgEFu790dRQ/fZiSerXpldVr+6qDz5pFVYp4qZTn/uFdGyHCyrpUXn2/
         E7c2f5D4OIBH+pyF7e13e76PjWSQHtqoIk3vYMoGAStd66xcABQdgjWtk/iLw1LDP5OJ
         2w2OJXH/JBgOxugm6I5fzNPLc0BAiDQkUGF2znLtHeaK4foLhbzNZ1qRlUusJWK0UgwZ
         v3uWn9fpQJuberDzwEsHu2vtMQXNS48cMIguITv14PNOCoEczLRlL7x84nDPgbsrb1xB
         uyvg==
X-Gm-Message-State: AOAM530vBHxzIuwzyGHNZ/hcy8Q5Dt5i/ZoLwd1IyNFgDu3lhBvh+YeW
        40XwNnUj+8JSgbKR6LEZsJi0f4vRJ0ts2gFZHVIqzA==
X-Google-Smtp-Source: ABdhPJyyMBF7pLP/eCMLv2h2a9321/g/MkgMtV/7I8OMnLA3cgFxTgYwKtCr5oB//J+rkCRPpgkMXLkFK0uouXSl4/k=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr6986456pgf.31.1610621877319;
 Thu, 14 Jan 2021 02:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-5-songmuchun@bytedance.com> <20210112080453.GA10895@linux>
In-Reply-To: <20210112080453.GA10895@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 14 Jan 2021 18:57:16 +0800
Message-ID: <CAMZfGtUOgD0vdj9E2mP2XFQWueW3ybWLRSyqUnQSdHZGGQHvqw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v12 04/13] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 4:05 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jan 06, 2021 at 10:19:22PM +0800, Muchun Song wrote:
> > Every HugeTLB has more than one struct page structure. We __know__ that
> > we only use the first 4(HUGETLB_CGROUP_MIN_ORDER) struct page structures
> > to store metadata associated with each HugeTLB.
> >
> > There are a lot of struct page structures associated with each HugeTLB
> > page. For tail pages, the value of compound_head is the same. So we can
> > reuse first page of tail page structures. We map the virtual addresses
> > of the remaining pages of tail page structures to the first tail page
> > struct, and then free these page frames. Therefore, we need to reserve
> > two pages as vmemmap areas.
> >
> > When we allocate a HugeTLB page from the buddy, we can free some vmemmap
> > pages associated with each HugeTLB page. It is more appropriate to do it
> > in the prep_new_huge_page().
> >
> > The free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> > pages associated with a HugeTLB page can be freed, returns zero for
> > now, which means the feature is disabled. We will enable it once all
> > the infrastructure is there.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> My memory may betray me after vacation, so bear with me.
>
> > +/*
> > + * Any memory allocated via the memblock allocator and not via the
> > + * buddy will be marked reserved already in the memmap. For those
> > + * pages, we can call this function to free it to buddy allocator.
> > + */
> > +static inline void free_bootmem_page(struct page *page)
> > +{
> > +     unsigned long magic = (unsigned long)page->freelist;
> > +
> > +     /*
> > +      * The reserve_bootmem_region sets the reserved flag on bootmem
> > +      * pages.
> > +      */
> > +     VM_WARN_ON_PAGE(page_ref_count(page) != 2, page);
>
> I have been thinking about this some more.
> And while I think that this macro might have its room somewhere, I do not
> think this is the case.
>
> Here, if we see that page's refcount differs from 2 it means that we had an
> earlier corruption.
> Now, as a person that has dealt with debugging memory corruptions, I think it
> is of no use to proceed further if such corruption happened, as this can lead
> to problems somewhere else that can manifest in funny ways, and you will find
> yourself scratching your head and trying to work out what happened.
>
> I am aware that this is not the root of the problem here, as someone might have
> had to decrease the refcount, but I would definitely change this to its
> VM_BUG_ON_* variant.
>
> > --- /dev/null
> > +++ b/mm/hugetlb_vmemmap.c
>
> [...]
>
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > new file mode 100644
> > index 000000000000..6923f03534d5
> > --- /dev/null
> > +++ b/mm/hugetlb_vmemmap.h
>
> [...]
>
> > +/**
> > + * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> > + *                   to the page which @reuse is mapped, then free vmemmap
> > + *                   pages.
> > + * @start:   start address of the vmemmap virtual address range.
> > + * @end:     end address of the vmemmap virtual address range.
> > + * @reuse:   reuse address.
> > + */
> > +void vmemmap_remap_free(unsigned long start, unsigned long end,
> > +                     unsigned long reuse)
> > +{
> > +     LIST_HEAD(vmemmap_pages);
> > +     struct vmemmap_remap_walk walk = {
> > +             .remap_pte      = vmemmap_remap_pte,
> > +             .reuse_addr     = reuse,
> > +             .vmemmap_pages  = &vmemmap_pages,
> > +     };
> > +
> > +     BUG_ON(start != reuse + PAGE_SIZE);
>
> It seems a bit odd to only pass "start" for the BUG_ON.
> Also, I kind of dislike the "addr += PAGE_SIZE" in vmemmap_pte_range.
>
> I wonder if adding a ".remap_start_addr" would make more sense.
> And adding it here with the vmemmap_remap_walk init.

How would vmemmap_pte_range look? If we introduce
vmemmap_remap_walk, "addr += PAGE_SIZE" can drop?

>
>
> --
> Oscar Salvador
> SUSE L3
