Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46729A2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 03:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410039AbgJ0C7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 22:59:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40429 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409924AbgJ0C7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:59:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id w21so60368pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r/6wM2urus7RuK+nJNOIaHAlYFuE3iJoIvxfk3Ke04=;
        b=slH7iqOCvbuRJpOoFTcLbTGUdbV0PTNzytfn6YhKrnJ0ZvHkh9I3aom/I3EGuJ5yF/
         l4ufdqid2leBOdcUopOquocKGZ/EHVGg7Oh/tPDjjpbm8PtJL+JUG+gZi98oQPE23LoM
         eMiTj4EVGIVGcA1cuA2v/FrmwMiAnDpvBHIncBVMzS83A5FDvM1pY0RNyHw2XX6fjgkZ
         +VMqHnXIFr/ybLbdSel4j6JBIHw2l7p7LCUP2OHTl96MnRpCpQvJ8gkv3BWelgqBkUGd
         VbbO0EkBJb5JlJS6ZVz3o7sK7ugIEBSqnLL2XzVzqQrWjC3+CRwq1lRut5CCXYclcazG
         X0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r/6wM2urus7RuK+nJNOIaHAlYFuE3iJoIvxfk3Ke04=;
        b=jEodFoOme7P61zLdgSzuVwtXmxQbrTWtZJZP8xO/0GprU6cKXcLb/fZGjYFeHiO4d8
         C7m/mtlOmXn+uG8M4vCUD+cmMqDf5+hZzsH/J07C1KwmnERoozYGG9aDJloxsbjDWBOD
         iFgDUgLc1QZ/bhwbvB7yCfUkiKNe4EuTrnpDPddC+ELoAovODBuA26z8AOvvGlnYoMiv
         QDzV7IjbdovsmOkzA/erpwdxOmp89yXhoUFMxCWOOk3+wh125HCFOeGB46Hx62XNc16g
         lwztG4VhD+bgRHuTnEuK96Pb+D/jZGoIWe82ckvTnyud0scns5nVYIyiXwq0j8qx/5dr
         RkdQ==
X-Gm-Message-State: AOAM533pvWG8L+/f551lEZuyKVIZPgrN6C7uf/6WMZ93I3Bb/u0TKYQi
        +edUxochKZaG2YcXJvDIgPrpXDcmJ/5DJfnpI7Qkwg==
X-Google-Smtp-Source: ABdhPJyWYIE4OTNvD1Li2UgYskyIXudRuzoDpQ5mbVNn2nBDoaVGbFjNKzwuIOmIbtQ3Tu3mU4VqlNbMc44uum/3l/c=
X-Received: by 2002:a65:5383:: with SMTP id x3mr15962pgq.341.1603767552671;
 Mon, 26 Oct 2020 19:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-8-songmuchun@bytedance.com> <20201026160142.GT20115@casper.infradead.org>
In-Reply-To: <20201026160142.GT20115@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 27 Oct 2020 10:58:36 +0800
Message-ID: <CAMZfGtX2p_M15i0pE7tTu3amPNof5PW2jJFUnXtGdGRyGydAtw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/19] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
To:     Matthew Wilcox <willy@infradead.org>
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:01 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 10:51:02PM +0800, Muchun Song wrote:
> > +static void split_vmemmap_pmd(pmd_t *pmd, pte_t *pte_p, unsigned long addr)
> > +{
> > +     struct mm_struct *mm = &init_mm;
> > +     struct page *page;
> > +     pmd_t old_pmd, _pmd;
> > +     int i;
> > +
> > +     old_pmd = READ_ONCE(*pmd);
> > +     page = pmd_page(old_pmd);
> > +     pmd_populate_kernel(mm, &_pmd, pte_p);
> > +
> > +     for (i = 0; i < VMEMMAP_HPAGE_NR; i++, addr += PAGE_SIZE) {
> > +             pte_t entry, *pte;
> > +
> > +             entry = mk_pte(page + i, PAGE_KERNEL);
>
> I'd be happier if that were:
>
>         pgprot_t pgprot = PAGE_KERNEL;
> ...
>         for (i = 0; i < VMEMMAP_HPAGE_NR; i++, addr += PAGE_SIZE) {
>                 pte_t entry, *pte;
>
>                 entry = mk_pte(page + i, pgprot);
>                 pgprot = PAGE_KERNEL_RO;
>
> so that all subsequent tail pages are mapped read-only.
>

Good idea, do this can catch some illegal operations. Thanks.


-- 
Yours,
Muchun
