Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473CA2D7633
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436577AbgLKND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436548AbgLKNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:02:58 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B81C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:02:17 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so4555804plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1D/vNhY1Kjir7/4yg4dLbO4XK686OPxm5jp3OAIgbr8=;
        b=AWawLQUCOwrBbZjG6DCx/CFU1PMdE3Nz/CbFeHJOjYhctFibE5w8pITqDlux9YqPap
         HMEvI1eBfhOAZB3WkdP800zq4y4ptAbHO0d70OA23/FSfrEarsZFNNva6VWU9EG8qYFJ
         Bbm5DSlBBXltUxw44fQ2IXKNo+8i+vEfUR6yDLIcGzZCS9YD3PCAxM2IZrtllDVX+9iC
         kE4S3+p4fLSiAiXortmEjfRzR8lp5zawK0GSKJe5beoajfRlrT2Kv9x+HKrttc3n7sHc
         aK+up31FuwNld0+2j7B4qxhfEvIbdNWKlMkLop7Y3pxYWb4PQFQJ1KN8dySgu3/ciGu5
         zyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1D/vNhY1Kjir7/4yg4dLbO4XK686OPxm5jp3OAIgbr8=;
        b=FiLNanxes7o4B355/R1Z6Gy2zlMpusdWB8/+4QT/ed4Rq3eD8vLfadywHD8ZraQKh6
         /gbFLubhwNLu2F24c8nVmrhsgMxHo0pcKF71gkSgHsVrdQSQMYK5rjoEOw8uS0lF9YCo
         CIbSjg0L08/T8fx7Z9iwpC6MKN2EXwBbRI7PfaJ2nyT0yRTpc5FT2nRLd2c/MB8eq0gh
         qAdCeTnoFGsLmCrsgEFlvwFhbTxy65wfdb1dFwPjt/q3ZEj1NtIhNjfBkMHfppvQ2/OH
         r9wFI4lmfAdnjs5/n8BOIKn9dZtR5cuiJLBkTsRstkn4FZLrNuwgmnokh/vstAmZQpEH
         Bruw==
X-Gm-Message-State: AOAM530nX3ZgfrzdBGk1kBirP+BdBGtC7XKSYj/r/68z6sgCK73d4/Nk
        uphaDvGoz0vcXsonV62Nlr3+TdBfFzqrCTnDZXX3pw==
X-Google-Smtp-Source: ABdhPJyrkHW1jJ+y4/0xKMaA/QItNsnKqbDwvPlm6ZAwyXs/lLyssO3a2x19vc3Yn8Q2Bv7j1M8leRQeebyI6fqjGK4=
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id
 j8-20020a17090276c8b02900d9d6c3357dmr10794766plt.34.1607691736785; Fri, 11
 Dec 2020 05:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-7-songmuchun@bytedance.com> <20201211093517.GA22210@linux>
In-Reply-To: <20201211093517.GA22210@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Dec 2020 21:01:40 +0800
Message-ID: <CAMZfGtX4EF+4V+XQvDdiLXq0L8Q5p7aacK+T0sCc-Kddvg52fA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 06/12] mm/hugetlb: Allocate the vmemmap
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 5:35 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 11:55:20AM +0800, Muchun Song wrote:
> > When we free a HugeTLB page to the buddy allocator, we should allocate the
> > vmemmap pages associated with it. We can do that in the __free_hugepage()
> "vmemmap pages that describe the range" would look better to me, but it is ok.

Thanks.

>
> > +#define GFP_VMEMMAP_PAGE             \
> > +     (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_HIGH | __GFP_NOWARN)
> >
> >  #ifndef VMEMMAP_HPAGE_SHIFT
> >  #define VMEMMAP_HPAGE_SHIFT          HPAGE_SHIFT
> > @@ -197,6 +200,11 @@
> >       (__boundary - 1 < (end) - 1) ? __boundary : (end);               \
> >  })
> >
> > +typedef void (*vmemmap_remap_pte_func_t)(struct page *reuse, pte_t *pte,
> > +                                      unsigned long start, unsigned long end,
> > +                                      void *priv);
>
> Any reason to not have defined GFP_VMEMMAP_PAGE and the new typedef into
> hugetlb_vmemmap.h?

Because they can only be used in this hugetlb_vmemmap.c.

>
>
> > +static void vmemmap_restore_pte_range(struct page *reuse, pte_t *pte,
> > +                                   unsigned long start, unsigned long end,
> > +                                   void *priv)
> > +{
> > +     pgprot_t pgprot = PAGE_KERNEL;
> > +     void *from = page_to_virt(reuse);
> > +     unsigned long addr;
> > +     struct list_head *pages = priv;
> [...]
> > +
> > +             /*
> > +              * Make sure that any data that writes to the @to is made
> > +              * visible to the physical page.
> > +              */
> > +             flush_kernel_vmap_range(to, PAGE_SIZE);
>
> Correct me if I am wrong, but flush_kernel_vmap_range is a NOOP under arches which
> do not have ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE.
> Since we only enable support for x86_64, and x86_64 is one of those arches,
> could we remove this, and introduced later on in case we enable this feature
> on an arch that needs it?

OK. Will remove.

>
> I am not sure if you need to flush the range somehow, as you did in
> vmemmap_remap_range.
>
> > +retry:
> > +             page = alloc_page(GFP_VMEMMAP_PAGE);
> > +             if (unlikely(!page)) {
> > +                     msleep(100);
> > +                     /*
> > +                      * We should retry infinitely, because we cannot
> > +                      * handle allocation failures. Once we allocate
> > +                      * vmemmap pages successfully, then we can free
> > +                      * a HugeTLB page.
> > +                      */
> > +                     goto retry;
>
> I think this is the trickiest part.
> With 2MB HugeTLB pages we only need 6 pages, but with 1GB, the number of pages
> we need to allocate increases significantly (4088 pages IIRC).
> And you are using __GFP_HIGH, which will allow us to use more memory (by
> cutting down the watermark), but it might lead to putting the system
> on its knees wrt. memory.
> And yes, I know that once we allocate the 4088 pages, 1GB gets freed, but
> still.

Yeah, it is a problem. How about removing __GFP_HIGH only for
1GB HugeTLB page?

>
> I would like to hear Michal's thoughts on this one, but I wonder if it makes
> sense to not let 1GB-HugeTLB pages be freed.
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
