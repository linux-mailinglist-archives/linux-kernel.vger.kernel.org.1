Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373102B1512
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 05:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKMESp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 23:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgKMESo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:18:44 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6696C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:18:44 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f27so6082180pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoQQYCm0CUI1d3dFcipn72mQMnKWNV7T/6zPt9SRkDM=;
        b=JhMbe0h76w8OnmRD67vqzsLImyr/I+HBgst0M3grAdYQtypY39XAU7r1pxUDVxoHup
         rNbWOcyhrPRBREEmks6mN/NkjP8fGXt64xtL1zSbxhNmYBkvc/iz7LGKO2d4OrB16A/Q
         2qn1pHpPryKku+WNUODMpAhN8C3PfKnY7jkO4/tLK5VzHlSNgYhgaOJeDc4LeQ7Zr8Q2
         xCSLxo/B2vYAEi3ZROc0DOVNjxy3qRrAJN2WqRPmdSTcehQVwo+FxCTCGW1QV3aWpKEs
         9JQl1UaUYhs8kBwcs6Dc5i0BqtQ3ADo0627YIDhwYdM4COkTnxrnw2Ouog98fxLWS6D9
         Tsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoQQYCm0CUI1d3dFcipn72mQMnKWNV7T/6zPt9SRkDM=;
        b=StPRmzVUHTHZP4wvDqJ7P8f/yeXbUIGExDIpJNat5EV7MoWQOvPQC+5R2LtGNBWgCj
         T3PqO+FYbG9aCnQBo2KlDPjAliFQapkEC9yiVu2o0XEEwBSt56vLeMNu0MgkIOOKUMdm
         QOLbc+CrC2FJJFxYWmwZT5dJbFpz9cqr2f52itylBaq7v22VaN4lGrfhqwP0+xGg5Ez+
         gJz0gtWW0tj/LmAosOka5BkfiE1kZRmGYteXGMmucaTbOqywnu0c/9gBfEM+lTSOSzQk
         ZhOL/pp/vFgkyQYB/Mdvkr582MCrUMeuCaMGwGAxTSFu/4vx4qMGcSEwytWMCjbIgSwP
         UV8A==
X-Gm-Message-State: AOAM531giRGWYIV9i/HeFUmQkBEq0HbLLGhovlK8Dzl/TKUcyz/zKBZZ
        lyc08UHXcTiKuOwqbD33i1pVpxwl0GNyuK5TXHAkrA==
X-Google-Smtp-Source: ABdhPJysNzFyG8GxRiZ3O2K/cMctulLuiEkBVF1gU2Xhkrh896y5T/IU+i9GQI8nyGwtxr5CK1N0HtfbnW7JNorvmB4=
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr709269pjb.229.1605241124066;
 Thu, 12 Nov 2020 20:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-6-songmuchun@bytedance.com> <9dc62874-379f-b126-94a7-5bd477529407@oracle.com>
 <CAMZfGtV+_vP66N1WagwNfxs4r3QGwnrYoR60yimwutTs=awXag@mail.gmail.com> <b7c16e3f-d906-1a11-dbd5-dc4199d70821@oracle.com>
In-Reply-To: <b7c16e3f-d906-1a11-dbd5-dc4199d70821@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 13 Nov 2020 12:18:07 +0800
Message-ID: <CAMZfGtUXus9gRsCbtV-+HmvWNY==oQxP+L3bzwmpTCZZ725Ynw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
To:     Mike Kravetz <mike.kravetz@oracle.com>
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
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 8:38 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/10/20 7:41 PM, Muchun Song wrote:
> > On Wed, Nov 11, 2020 at 8:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 11/8/20 6:10 AM, Muchun Song wrote:
> >> I am reading the code incorrectly it does not appear page->lru (of the huge
> >> page) is being used for this purpose.  Is that correct?
> >>
> >> If it is correct, would using page->lru of the huge page make this code
> >> simpler?  I am just missing the reason why you are using
> >> page_huge_pte(page)->lru
> >
> > For 1GB HugeTLB pages, we should pre-allocate more than one page
> > table. So I use a linked list. The page_huge_pte(page) is the list head.
> > Because the page->lru shares storage with page->pmd_huge_pte.
>
> Sorry, but I do not understand the statement page->lru shares storage with
> page->pmd_huge_pte.  Are you saying they are both in head struct page of
> the huge page?
>
> Here is what I was suggesting.  If we just use page->lru for the list
> then vmemmap_pgtable_prealloc() could be coded like the following:
>
> static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> {
>         struct page *pte_page, *t_page;
>         unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
>
>         if (!nr)
>                 return 0;
>
>         /* Store preallocated pages on huge page lru list */
>         INIT_LIST_HEAD(&page->lru);
>
>         while (nr--) {
>                 pte_t *pte_p;
>
>                 pte_p = pte_alloc_one_kernel(&init_mm);
>                 if (!pte_p)
>                         goto out;
>                 list_add(&virt_to_page(pte_p)->lru, &page->lru);
>         }
>
>         return 0;
> out:
>         list_for_each_entry_safe(pte_page, t_page, &page->lru, lru)
>                 pte_free_kernel(&init_mm, page_to_virt(pte_page));
>         return -ENOMEM;
> }
>
> By doing this we could eliminate the routines,
> vmemmap_pgtable_init()
> vmemmap_pgtable_deposit()
> vmemmap_pgtable_withdraw()
> and simply use the list manipulation routines.

Now I know what you mean. Yeah, just use page->lru can make code
simply. Thanks for your suggestions.

>
> To me, that looks simpler than the proposed code in this patch.
> --
> Mike Kravetz



-- 
Yours,
Muchun
