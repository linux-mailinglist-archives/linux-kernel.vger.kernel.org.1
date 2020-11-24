Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49652C23E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgKXLIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732840AbgKXLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:08:37 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F52C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:08:34 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so17172246pgl.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kj0WDd7GW3ZafwLkwvjtKCJlLdXVHYFvSyIRNFPhhJs=;
        b=KRxaSswNMnKDHkOWQ7Yc2KKjW2HjaY2VS0HOZmr6HNo+sMe//hXQfRkdpcncexV+GB
         JNUIxmzzFkT6MTPkf4NqWlctVnyRv7+Wsj3ahOikwnyEBCjv2+jtNf6X5nLSRVdZ+hHt
         ndhQCPoIPTrbnq+kmZk8kYoqKILIn1jIWn6ZnsDksipGyj27T1XAg3MTx2Lh95/UhNxj
         R4HwdbqimHJKyGsbNpzDBXDd7fkC0bNlekbpPDrdb+NMRnbRT2uzlqoDbVxbAEsUW4un
         xMXoSO9WPO3KLYzfQGQw9kR0BXMZ3qqKrLr3dUUfRvpGC+1GTVqPfyuxBvvgWtQmGPIr
         1gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kj0WDd7GW3ZafwLkwvjtKCJlLdXVHYFvSyIRNFPhhJs=;
        b=WzPG3OZUt7Q+SxqgRJDyOBsfXurnqU1bhNHdXIXZn+5b9Qh0V5onugwBVmrwa2B0bs
         qLYU2opsmPWW2N1DrkX6110oi3/twis7J7NLip6W/NmUTf7DMB8nUsCpYz7WCHNz2jAW
         73ZQkoHqKhK8fIqHG/uRk0OHJUyjM/ftEzQ8TIvi/OWyohWiOPg6XHAZ38luo9gefywx
         fpjhtlyy7wo6ZaItQsMUJGgV1cC2yovH3nO71Nkbtz2if+eE/Ug28qKxjVve39NFI+00
         YSvnBrV/eTmpwqYUextxKLe4xSaHlRO5MBGf/V9jOnpaEr/in2UA/Rs4yh6pYq43djDJ
         jaVg==
X-Gm-Message-State: AOAM533ch4XQZh5H5mUqwTHSa9ovj2MhS2Xefj4pRxIk1xqXahigRED5
        9l2JC952/y+jFQfYm8YqX9CNgfv6Pabkr86WpwgIdw==
X-Google-Smtp-Source: ABdhPJwAnnOF1DfZ6tU3qBpyxbXObsyrOi0H0yApKcnJAOa41sGtBxbjPtLnlPuc9h4FZRo23mRNTy2PVNoHj1uSHWE=
X-Received: by 2002:a62:16c1:0:b029:18c:8a64:fc04 with SMTP id
 184-20020a6216c10000b029018c8a64fc04mr3535171pfw.59.1606216113637; Tue, 24
 Nov 2020 03:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-15-songmuchun@bytedance.com> <5f6443f10292405d813ffb444ef315fc@hisilicon.com>
In-Reply-To: <5f6443f10292405d813ffb444ef315fc@hisilicon.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 24 Nov 2020 19:07:56 +0800
Message-ID: <CAMZfGtV5uSkNcoS1sKdOOwWXr6TaroRj_kJjJ7iqnF=NMnZ8NA@mail.gmail.com>
Subject: Re: [External] RE: [PATCH v6 14/16] mm/hugetlb: Add a kernel
 parameter hugetlb_free_vmemmap
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 6:54 PM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Muchun Song [mailto:songmuchun@bytedance.com]
> > Sent: Tuesday, November 24, 2020 10:53 PM
> > To: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> > mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> > dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> > viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> > mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> > rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> > jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> > willy@infradead.org; osalvador@suse.de; mhocko@suse.com; Song Bao Hua
> > (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: duanxiongchun@bytedance.com; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > linux-fsdevel@vger.kernel.org; Muchun Song <songmuchun@bytedance.com>
> > Subject: [PATCH v6 14/16] mm/hugetlb: Add a kernel parameter
> > hugetlb_free_vmemmap
> >
> > Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> > freeing unused vmemmap pages associated with each hugetlb page on boot.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
> >  mm/hugetlb_vmemmap.c                            | 19
> > ++++++++++++++++++-
> >  3 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index 5debfe238027..d28c3acde965 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1551,6 +1551,15 @@
> >                       Documentation/admin-guide/mm/hugetlbpage.rst.
> >                       Format: size[KMG]
> >
> > +     hugetlb_free_vmemmap=
> > +                     [KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> > +                     this controls freeing unused vmemmap pages associated
> > +                     with each HugeTLB page.
> > +                     Format: { on | off (default) }
> > +
> > +                     on:  enable the feature
> > +                     off: disable the feature
> > +
>
> We've a parameter here. but wouldn't it be applied to "x86/mm/64/:disable
> Pmd page mapping of vmemmap" as well?
> If (hugetlb_free_vmemmap_enabled)
>         Do Basepage mapping?

Oh, yeah, we can. Thanks.

>
> >       hung_task_panic=
> >                       [KNL] Should the hung task detector generate panics.
> >                       Format: 0 | 1
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst
> > b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index f7b1c7462991..6a8b57f6d3b7 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -145,6 +145,9 @@ default_hugepagesz
> >
> >       will all result in 256 2M huge pages being allocated.  Valid default
> >       huge page size is architecture dependent.
> > +hugetlb_free_vmemmap
> > +     When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables
> > freeing
> > +     unused vmemmap pages associated each HugeTLB page.
> >
> >  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
> >  indicates the current number of pre-allocated huge pages of the default size.
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 509ca451e232..b2222f8d1245 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -131,6 +131,22 @@ typedef void (*vmemmap_pte_remap_func_t)(struct
> > page *reuse, pte_t *ptep,
> >                                        unsigned long start, unsigned long end,
> >                                        void *priv);
> >
> > +static bool hugetlb_free_vmemmap_enabled __initdata;
> > +
> > +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     if (!strcmp(buf, "on"))
> > +             hugetlb_free_vmemmap_enabled = true;
> > +     else if (strcmp(buf, "off"))
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +early_param("hugetlb_free_vmemmap",
> > early_hugetlb_free_vmemmap_param);
> > +
> >  static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
> >  {
> >       return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
> > @@ -322,7 +338,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >       unsigned int order = huge_page_order(h);
> >       unsigned int vmemmap_pages;
> >
> > -     if (!is_power_of_2(sizeof(struct page))) {
> > +     if (!is_power_of_2(sizeof(struct page)) ||
> > +         !hugetlb_free_vmemmap_enabled) {
> >               pr_info("disable freeing vmemmap pages for %s\n", h->name);
> >               return;
> >       }
> > --
> > 2.11.0
>
> Thanks
> Barry
>


-- 
Yours,
Muchun
